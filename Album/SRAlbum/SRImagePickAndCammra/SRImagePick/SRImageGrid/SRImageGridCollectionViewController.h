//
//  SRImageGridCollectionViewController.h
//  CameraDemo
//
//  Created by sharui on 16/10/11.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "SRAlbumModel.h"
/**
 相册网格
 */
@interface SRImageGridCollectionViewController : UICollectionViewController

/**
 相册数据

 @param fetchResult <#fetchResult description#>

 @return <#return value description#>
 */
- (instancetype)initWithSRAlbumModel:(SRAlbumModel *)fetchResult withCurrentPicNumber:(NSInteger)currentNum andMaxNumber:(NSInteger )maxNumber;
@end
