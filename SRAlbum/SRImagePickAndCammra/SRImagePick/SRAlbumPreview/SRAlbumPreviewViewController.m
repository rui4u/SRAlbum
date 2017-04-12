//
//  SRAlbumPreviewViewController.m
//  CameraDemo
//
//  Created by sharui on 2016/10/12.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRAlbumPreviewViewController.h"
#import "SRAlbumPreviewLayout.h"
#import "SRAlbumPreviewCollectionViewCell.h"
#import "SRAlertController.h"

@interface SRAlbumPreviewViewController ()<SRAlbumPreviewCollectionViewCellDelegate>

/**
 当前照片个数
 */
@property (nonatomic ,assign ) NSInteger currentNum;

/**
 最大照片个数
 */
@property (nonatomic ,assign ) NSInteger maxNumber;
/**
 相册模型
 */
@property (nonatomic ,strong ) SRAlbumModel  * albumModel;

/**
 选中素材数组
 */
@property (nonatomic ,strong ) NSMutableArray <PHAsset *>*selectedAssets;

/**
 选择按钮
 */
@property (nonatomic ,strong ) UIButton *selectedButton;

/**
 当前页面角标
 */
@property (nonatomic ,strong ) NSIndexPath *currentIndexPath;

@end

@implementation SRAlbumPreviewViewController
{
    /// 预览按钮
    UIBarButtonItem *_previewItem;
    /// 完成按钮
    UIBarButtonItem *_doneItem;
    /// 选择多少张图片button
    UIButton * _selectedButtonNum;
}

static NSString * const reuseIdentifier = @"SRAlbumPreviewViewControllerCell";

- (instancetype)initWithFetchResult:(SRAlbumModel *)albumModel
                      withIndexPath:(NSIndexPath *) indexPatch
                 withSelectedAssets:(NSMutableArray <PHAsset *> *)selectedAssets
               withCurrentPicNumber:(NSInteger)currentNum andMaxNumber:(NSInteger )maxNumber

{
    
  
    self.currentNum = currentNum;
    self.maxNumber = maxNumber;
    self.selectedAssets = selectedAssets;
    SRAlbumPreviewLayout *layout = [[SRAlbumPreviewLayout alloc] init];
  
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        
        self.albumModel = albumModel;
        // 跳转到指定图片
        if (indexPatch != nil) {
            self.currentIndexPath = indexPatch;
            [self.collectionView scrollToItemAtIndexPath:indexPatch atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }else {
            
        
        }
        
        
        self.collectionView.pagingEnabled = YES;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self customNavigationBar];
    [self.collectionView registerClass:[SRAlbumPreviewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}


- (void)customNavigationBar {
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.navigationController.hidesBarsOnTap = YES;
    
    self.title = self.albumModel.title;
    // 工具条
    _previewItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:@selector(clickPreviewButton)];
    _previewItem.enabled = NO;
    _selectedButtonNum = [[UIButton alloc] init];
    _selectedButtonNum.frame = CGRectMake(0, 0, 20, 20);
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:@"SRImagePicker.bundle" withExtension:nil];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    UIImage *normalImage = [UIImage imageNamed:@"number_icon"
                                      inBundle:imageBundle
                 compatibleWithTraitCollection:nil];
    [_selectedButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_selectedButton sizeToFit];
    [_selectedButtonNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *counterItem = [[UIBarButtonItem alloc] initWithCustomView:_selectedButtonNum];
    
    _doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(clickFinishedButton)];
    _doneItem.enabled = NO;
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[
                        _previewItem,
                          counterItem,
                          spaceItem,
                          _doneItem];
    
    // 选择按钮
    
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectedButton];
}


/**
 预览
 */
- (void) clickPreviewButton {
    
    
}


/**
 完成
 */
- (void) clickFinishedButton {
    [self requestImages:self.selectedAssets completed:^(NSArray<UIImage *> *images) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SRImagePickerSelectImage" object:images];
    }];
}


/**
 取消
 */
- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)clickSelectedButton:(UIButton *)sender {
    
    PHAsset *asset = [self.albumModel assetWithIndex:self.currentIndexPath.item];
    sender.selected = !sender.selected;
    
    BOOL isSelected = sender.selected;
    if (isSelected) {
        //是否最大值
        if ((self.selectedAssets.count < self.maxNumber - self.currentNum)) {
            
            [self.selectedAssets addObject:asset];
        }else  {
            _selectedButton.selected = NO;
            SRAlertController * alertView = [SRAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"你最多只能选择%tu张照片",self.maxNumber - self.currentNum] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
                [alertView dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertView addAction:otherAction];
            
            [self presentViewController:alertView animated:YES completion:nil];
            
            
        }

    } else {
        [self.selectedAssets removeObject:asset];
    }
    //    cell.selectedButton.selected = isSelected;
    [self.delegate srResaveSelectImage:self.selectedAssets];
    [self updateCounter];
    
}
/// 更新计数显示
- (void)updateCounter {
    _doneItem.enabled = self.selectedAssets.count > 0;
    _previewItem.enabled = self.selectedAssets.count > 0;
    [_selectedButtonNum setTitle:[NSString stringWithFormat:@"%tu",self.selectedAssets.count] forState:UIControlStateNormal];
    
}

#pragma mark - 获取图片
- (void)requestImages:(NSArray <PHAsset *> *)selectedAssets completed:(void (^)(NSArray <UIImage *> *images))completed {
    
    /// 图像请求选项
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 设置 resizeMode 可以按照指定大小缩放图像
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 设置 deliveryMode 为 HighQualityFormat 可以只回调一次缩放之后的图像，否则会调用多次
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    // 设置加载图像尺寸(以像素为单位)
//    CGSize targetSize = CGSizeMake(200, 200);
    
    NSMutableArray <UIImage *> *images = [NSMutableArray array];
	NSMutableArray * imageInfoModels = [NSMutableArray new];
 
    for (NSInteger i = 0; i < selectedAssets.count; i++) {
        
        [images addObject:[UIImage new]];
    }
    
    dispatch_group_t group = dispatch_group_create();
    
    NSInteger i = 0;
	for (PHAsset *asset in selectedAssets) {
		
		dispatch_group_enter(group);
		
		
		SRImageInfoModel * imageInfoModel = [[SRImageInfoModel alloc] init];
		
		[[PHImageManager defaultManager]
		 requestImageForAsset:asset
		 targetSize:PHImageManagerMaximumSize
		 contentMode:PHImageContentModeAspectFill
		 options:options
		 resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
			 [images replaceObjectAtIndex:i withObject:result];
			 imageInfoModel.PHImageFileUTIKey = [info objectForKey:@"PHImageFileUTIKey"];
			 [imageInfoModels addObject:imageInfoModel];
			 
			 dispatch_group_leave(group);
		 }];
		i++;
	}
	
	dispatch_group_notify(group, dispatch_get_main_queue(), ^{
		
		for (int i = 0; i < images.count; i ++) {
			UIImage * image  = [images objectAtIndex:i];
			SRImageInfoModel * imageInfoModel = [imageInfoModels objectAtIndex:i];
			imageInfoModel.image = image;
		}
		completed(imageInfoModels.copy);
	});}

#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    
    return self.albumModel.count;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:(NSInteger)(scrollView.contentOffset.x /[UIScreen mainScreen].bounds.size.width) inSection:0];
    ;
    self.currentIndexPath = firstIndexPath;
    self.selectedButton.selected = [_selectedAssets containsObject:[self.albumModel assetWithIndex:firstIndexPath.item]];

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRAlbumPreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    [self.albumModel requestThumbnailWithAssetIndex:indexPath.item Size:cell.bounds.size completion:^(SRImageInfoModel *imageInfoModel) {
        cell.imageInfoModel = imageInfoModel;
    }];
    
    return cell;
}


- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRAlbumPreviewCollectionViewCell *cell  = (SRAlbumPreviewCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SRImagePickerSelectImage" object:@[cell.imageInfoModel]];


}
- (UIButton *)selectedButton {
    if (_selectedButton == nil) {
        _selectedButton = [[UIButton alloc] init];
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"SRImagePicker.bundle" withExtension:nil];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        
        UIImage *normalImage = [UIImage imageNamed:@"check_box_default"
                                          inBundle:imageBundle
                     compatibleWithTraitCollection:nil];
        [_selectedButton setImage:normalImage forState:UIControlStateNormal];
        UIImage *selectedImage = [UIImage imageNamed:@"check_box_right"
                                            inBundle:imageBundle
                       compatibleWithTraitCollection:nil];
        [_selectedButton setImage:selectedImage forState:UIControlStateSelected];
        [_selectedButton sizeToFit];
        [_selectedButton addTarget:self action:@selector(clickSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
    
}





@end
