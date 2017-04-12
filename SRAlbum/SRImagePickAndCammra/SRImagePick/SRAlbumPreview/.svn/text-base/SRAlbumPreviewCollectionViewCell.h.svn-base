//
//  SRAlbumPreviewCollectionViewCell.h
//  CameraDemo
//
//  Created by sharui on 2016/10/12.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRImageInfoModel.h"
@protocol SRAlbumPreviewCollectionViewCellDelegate <NSObject>

/**
 选择哪那张图片

 @param indexPath cell路径
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 预览界面cell
 */
@interface SRAlbumPreviewCollectionViewCell : UICollectionViewCell


/**
 预览界面图片信息
 */
@property (nonatomic ,strong ) NSDictionary * conImageInfo;

/**
 记录cell位置
 */
@property (nonatomic ,assign ) NSIndexPath  *indexPath;

/**
 信息模型
 */
@property (nonatomic ,strong ) SRImageInfoModel * imageInfoModel;
/**
 点击面包客
 */
@property (nonatomic ,weak ) id <SRAlbumPreviewCollectionViewCellDelegate> delegate;
@end
