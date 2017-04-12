//
//  SRImageGridCollectionViewCell.h
//  CameraDemo
//
//  Created by sharui on 2016/10/13.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRImageInfoModel.h"
@class SRImageGridCollectionViewCell;

@protocol SRImageGridCollectionViewCellDelegate <NSObject>

/**
 选择照片回调
 
 @param cell       哪一个照片
 @param isSelected 是否被选中
 */
- (void)imageGridCell:(SRImageGridCollectionViewCell *) cell didSelected:(BOOL) isSelected;

@end

@interface SRImageGridCollectionViewCell : UICollectionViewCell

/**
 图片资源
 */

@property (nonatomic ,strong ) SRImageInfoModel * imageInfoModel;

/**
 图片选择按钮
 */
@property (nonatomic) UIButton *selectedButton;

/**
 点击按钮多选面包客
 */
@property (nonatomic ,weak ) id<SRImageGridCollectionViewCellDelegate> delegate;
@end
