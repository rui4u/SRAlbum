//
//  SRAlbumPreviewViewController.h
//  CameraDemo
//
//  Created by sharui on 2016/10/12.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "SRAlbumModel.h"

@protocol SRAlbumPreviewViewControllerDelegate <NSObject>

/**
 刷新选中图片

 @param selectedAssets <#selectedAssets description#>
 */
- (void)srResaveSelectImage:(NSMutableArray <PHAsset *> *)selectedAssets;

@end
/**
 预览界面
 */
@interface SRAlbumPreviewViewController : UICollectionViewController

/**
 刷新数据面包客
 */
@property (nonatomic ,strong ) id<SRAlbumPreviewViewControllerDelegate> delegate;
/**
 创建预览界面

 @param albumModel     相册模型
 @param indexPatch     角标
 @param selectedAssets 已选择照片

 @return <#return value description#>
 */
- (instancetype)initWithFetchResult:(SRAlbumModel *)albumModel
                      withIndexPath:(NSIndexPath *) indexPatch
                 withSelectedAssets:(NSMutableArray <PHAsset *> *)selectedAssets
               withCurrentPicNumber:(NSInteger)currentNum
                       andMaxNumber:(NSInteger )maxNumber;



@end
