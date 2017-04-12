//
//  AssetProofModel.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/10/28.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AssetProofModel : NSObject <NSCopying>


/**
 图片
 */
@property (nonatomic ,strong ) UIImage * image;

/**
 图片url
 */
@property (nonatomic ,copy ) NSString * url;

/**
 图片位置
 */
@property (nonatomic ,strong ) NSIndexPath * indexPath;

/**
 上传状态 -1：失败   0 ：上传中   1：成功
 */
@property (nonatomic , copy) NSString * uploadStatus;

@property (nonatomic ,copy ) NSString *   imageType;// "public.jpeg";
@end
