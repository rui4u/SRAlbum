//
//  SRImagePickerViewController.h
//  CameraDemo
//
//  Created by sharui on 16/10/9.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"SRImageInfoModel.h"
#import "AssetProofModel.h"
@protocol SRImagePickerViewControllerDelegate <NSObject>

@optional
- (void)srImagePickerSelectImage:(NSNotification *)notification;

@end
/**
 相册框架根控制器
 */
@interface SRImagePickerViewController : UINavigationController

/**
 <#Description#>

 @param currentNum 当前个数
 @param maxNumber 最大个数
 @return <#return value description#>
 */
- (instancetype)initWithCurrentPicNumber:(NSInteger)currentNum andMaxNumber:(NSInteger )maxNumber;

- (instancetype) initWithCurrentPicNumber : (NSInteger ) currentNum
                             addMaxNumber : (NSInteger ) maxNumber
     srImagePickerViewControllerDdelegate : (__kindof id<SRImagePickerViewControllerDelegate >)srImagePickerViewControllerDdelegate ;

@property (nonatomic ,weak ) id<SRImagePickerViewControllerDelegate> srImagePickerViewControllerDdelegate;
@end
