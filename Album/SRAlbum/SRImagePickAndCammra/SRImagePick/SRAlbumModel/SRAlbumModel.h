//
//  SRAlbumModel.h
//  CameraDemo
//
//  Created by sharui on 2016/10/13.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRImageInfoModel.h"
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface SRAlbumModel : NSObject

/**
 标题
 */
@property (nonatomic ,copy, readonly) NSString * title;

/**
 相片个数
 */
@property (nonatomic ,readonly) NSUInteger  count;

/**
 相片image
 */
@property (nonatomic ,strong) UIImage * image;

/**根据index获取想要的相册中的图片
 <#Description#>

 @param index      角标
 @param size       大小
 @param completion 回调相册图片
 */
- (void)requestThumbnailWithAssetIndex:(NSInteger)index
                                  Size:(CGSize)size
                            completion:(void (^)(SRImageInfoModel* imageInfoModel))completion ;

/**
 创建模型数据

 @param assetCollection <#assetCollection description#>

 @return <#return value description#>
 */
+ (instancetype)creatAlbumModelWithAssetCollection:(PHAssetCollection *)assetCollection;

/**
 根据角标找到图片

 @param index <#index description#>

 @return <#return value description#>
 */
- (PHAsset *)assetWithIndex:(NSInteger)index;
@end
