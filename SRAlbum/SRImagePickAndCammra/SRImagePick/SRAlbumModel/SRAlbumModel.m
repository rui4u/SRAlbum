//
//  SRAlbumModel.m
//  CameraDemo
//
//  Created by sharui on 2016/10/13.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRAlbumModel.h"
@interface SRAlbumModel ()

/**
 图片处理结果
 */
@property (nonatomic ,strong ) PHFetchResult *fetchResult;

/**
 图片集合
 */
@property (nonatomic ,strong ) PHAssetCollection *assetCollection;
@end
@implementation SRAlbumModel


+ (instancetype)creatAlbumModelWithAssetCollection:(PHAssetCollection *)assetCollection {
    return [[self alloc] initWithAssetCollection:assetCollection];
}

- (instancetype)initWithAssetCollection:(PHAssetCollection *)assetCollection
{
    self = [super init];
    if (self) {
       
        
        // 设置查询选项
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        // 仅搜索照片
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeImage];
        // 按照创建日期降序排列照片
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        
        self.assetCollection = assetCollection;
        
        PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
        
        self.fetchResult = fetchResult;
    }
    return self;
}

/**
获取图片Image

@param index      获取哪一个
@param size       大小
@param completion 获取后回调
*/
- (void)requestThumbnailWithAssetIndex:(NSInteger)index Size:(CGSize)size completion:(void (^)(SRImageInfoModel* imageInfoModel))completion {
    
    PHAsset *asset = _fetchResult[index];
    SRImageInfoModel * imageInfoModel = [[SRImageInfoModel alloc] init];
    //获取图片数据
    [[PHImageManager defaultManager]
     requestImageForAsset:asset
     targetSize:[self sizeWithScale:size]
     contentMode:PHImageContentModeAspectFill
     options:[self imageRequestOptions]
     resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
         imageInfoModel.image = result;
         imageInfoModel.imageInfoDic = info;
         completion(imageInfoModel);
     }];
}

- (CGSize)sizeWithScale:(CGSize)size {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    return CGSizeMake(size.width * scale, size.height * scale);
}

/// 图像请求选项
- (PHImageRequestOptions *)imageRequestOptions {
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 设置 resizeMode 可以按照指定大小缩放图像
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 只回调一次缩放之后的照片，否则会调用多次
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    return options;
}

-(NSString *)title {
    return self.assetCollection.localizedTitle;
}
- (NSUInteger )count {
    return self.fetchResult.count;
}

- (PHAsset *)assetWithIndex:(NSInteger)index {
    if (index >= _fetchResult.count || index < 0) {
        return nil;
    }
    return _fetchResult[index];
}

@end
