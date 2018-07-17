//
//  ViewController.m
//  SRAlbum
//
//  Created by sharui on 2017/4/12.
//  Copyright © 2017年 sharui. All rights reserved.
//

#import "ViewController.h"
#import "SRAlertController.h"
#import "SRImagePickerViewController.h"
#import "SRCameraViewController.h"


@interface ViewController ()<SRImagePickerViewControllerDelegate>
@property (nonatomic ,strong ) SRAlertController * alertController;
/**
 图片选择器
 */
@property (nonatomic ,strong ) SRImagePickerViewController * imagePickerVC;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self setAlertController];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	//触发
	[self presentViewController:self.alertController animated:YES completion:nil];
}
- (void)setAlertController {
	
	__weak typeof(self) weakSelf = self;
	
	[self.alertController addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		[SRCameraViewController initWithDelegateController:self andResult:^(BOOL isAllowed, id alert)  {
			[weakSelf presentViewController:alert animated:YES completion:nil];
		}];
		
	}]];
	[self.alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		
		//选择照片数
		weakSelf.imagePickerVC = [[SRImagePickerViewController alloc] initWithCurrentPicNumber:0 andMaxNumber:9];
		weakSelf.imagePickerVC.srImagePickerViewControllerDdelegate = self;
		[weakSelf presentViewController:weakSelf.imagePickerVC animated:YES completion:nil];

	}]];
	[self.alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
	
}
- (void)srImagePickerSelectImage:(NSNotification *)notification {
	//
	NSArray<SRImageInfoModel *>* obj = [notification object];
	
	[self setUpUI:obj];
}

- (void)setUpUI:(NSArray<SRImageInfoModel *>*) array{
    for (UIView * subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    
	//      总列数
	int totalColumns = 3;
	CGFloat width = ([UIScreen mainScreen].bounds.size.width )/ totalColumns - 10;
	//       每一格的尺寸
	CGFloat cellW = width;
	CGFloat cellH = width;
	
	//    间隙
	CGFloat margin =(self.view.frame.size.width - totalColumns * cellW) / (totalColumns + 1);
	
	//    根据格子个数创建对应的框框
	for(int index = 0; index< array.count; index++) {
		UIImageView *cellView = [[UIImageView alloc ]init];
		cellView.image = array[index].image;
		// 计算行号  和   列号
		int row = index / totalColumns;
		int col = index % totalColumns;
		//根据行号和列号来确定 子控件的坐标
		CGFloat cellX = margin + col * (cellW + margin);
		CGFloat cellY = 100 + row * (cellH + margin);
		cellView.frame = CGRectMake(cellX, cellY, cellW, cellH);
		
		// 添加到view 中
		[self.view addSubview:cellView];
	}
}

- (SRAlertController *)alertController {
	if (_alertController == nil) {
		_alertController = [SRAlertController alertControllerWithTitle:@"" message:@"选择照片方式" preferredStyle:UIAlertControllerStyleActionSheet];
	}
	return _alertController;
}
@end
