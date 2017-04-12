//
//  SRCameraViewController.h
//  CameraDemo
//
//  Created by sharui on 2016/10/12.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SRCameraViewControllerControllerDelegate <NSObject>

- (void)srImagePickerSelectImage:(NSNotification *)notification;

@end
@interface SRCameraViewController : UIImagePickerController

/**
 相机照相后回调
 
 @param completion 是否允许  弹出类型（警告或相机）
 */
+ (void)initWithDelegateController:(id) viewController andResult:(void(^)(BOOL isAllowed ,id alert)) completion ;


/**
 相机代理
 */
@property (nonatomic ,weak ) id<SRCameraViewControllerControllerDelegate> srCameraViewControllerControllerDelegate;

@end
