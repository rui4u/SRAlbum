//
//  SRImagePickerViewController.m
//  CameraDemo
//
//  Created by sharui on 16/10/9.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRImagePickerViewController.h"
#import "SRAlbumTableViewController.h"

@interface SRImagePickerViewController ()

/**
 相册根控制器
 */
@property (nonatomic ,strong ) SRAlbumTableViewController * rootViewController;
@end

@implementation SRImagePickerViewController
- (instancetype) initWithCurrentPicNumber : (NSInteger ) currentNum
                             addMaxNumber : (NSInteger ) maxNumber
     srImagePickerViewControllerDdelegate : (__kindof id<SRImagePickerViewControllerDelegate >)srImagePickerViewControllerDdelegate
{
    self = [self initWithCurrentPicNumber:currentNum andMaxNumber:maxNumber];
    if (self)
    {
        self.srImagePickerViewControllerDdelegate = srImagePickerViewControllerDdelegate;
    }
    return self ;
}

- (instancetype)initWithCurrentPicNumber:(NSInteger)currentNum andMaxNumber:(NSInteger )maxNumber
{
    self = [super init];
    if (self) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        self.toolbarHidden = NO;

        [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(srImagePickerSelectImage:) name:@"SRImagePickerSelectImage" object:nil];         
        _rootViewController = [[SRAlbumTableViewController alloc] initWithCurrentPicNumber:currentNum andMaxNumber:maxNumber];
        [self pushViewController:_rootViewController animated:NO];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    
    //确保先弹出 后计算个数
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    
    //跟控制器隐藏toolbar
    self.toolbarHidden = (self.viewControllers.count == 1);
    self.hidesBarsOnTap = NO;
    
    return viewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //相册列表时隐藏
    [self setToolbarHidden: [viewController isKindOfClass:[SRAlbumTableViewController class]] animated:YES];

    return [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)srImagePickerSelectImage:(NSNotification *)notification {
    
    
    if ([self.srImagePickerViewControllerDdelegate respondsToSelector:@selector(srImagePickerSelectImage:)]) {
        [self.srImagePickerViewControllerDdelegate srImagePickerSelectImage:notification];
    }
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void) viewDidDisappear:(BOOL)animated {
    
    //
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SRImagePickerSelectImage" object:nil];
    [super viewWillDisappear:animated];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
