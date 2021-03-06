//
//  ImageInfoModel.h
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/10/26.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 图片信息模型
 */
@interface SRImageInfoModel : NSObject

/**
 图片
 */
@property (nonatomic ,strong ) UIImage * image;


/**
 图片数据字典
 */
@property (nonatomic ,strong ) NSDictionary * imageInfoDic;


@property (nonatomic ,copy ) NSString *    PHImageFileOrientationKey;// 0;
@property (nonatomic ,copy ) NSString *   PHImageFileSandboxExtensionTokenKey;// "ccf1b6bb33f2cb4d4b1f1e41bd7f5e561409f735;00000000;00000000;000000000000001a;com.apple.app-sandbox.read;00000001;01000004;00000000000ebfe4;/users/hzcf/library/developer/coresimulator/devices/da44171e-cbab-447e-a8c4-e50675bbb6f2/data/media/dcim/100apple/img_0002.jpg";

/**
 图片路径
 */
@property (nonatomic ,copy ) NSString *   PHImageFileURLKey;// "file:///Users/hzcf/Library/Developer/CoreSimulator/Devices/DA44171E-CBAB-447E-A8C4-E50675BBB6F2/data/Media/DCIM/100APPLE/IMG_0002.JPG";

/**
 图片类型
 */
@property (nonatomic ,copy ) NSString *   PHImageFileUTIKey;// "public.jpeg";
@property (nonatomic ,strong ) NSNumber * PHImageResultDeliveredImageFormatKey;// 9999;
@property (nonatomic ,strong ) NSNumber * PHImageResultIsDegradedKey;// 0;
@property (nonatomic ,strong ) NSNumber * PHImageResultIsInCloudKey;// 0;
@property (nonatomic ,strong ) NSNumber * PHImageResultIsPlaceholderKey;// 0;
@property (nonatomic ,strong ) NSNumber * PHImageResultOptimizedForSharing;// 0;
@property (nonatomic ,strong ) NSNumber * PHImageResultRequestIDKey;// 6;
@property (nonatomic ,strong ) NSNumber * PHImageResultWantedImageFormatKey;// 4035;

@property (nonatomic ,strong ) NSNumber * PHImageResultImageTypeKey;
@end
