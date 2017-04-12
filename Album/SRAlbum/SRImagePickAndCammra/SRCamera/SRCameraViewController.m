//
//  SRCameraViewController.m
//  CameraDemo
//
//  Created by sharui on 2016/10/12.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRCameraViewController.h"
#import "SRImageInfoModel.h"
#import "SRAlertController.h"
#import <AVFoundation/AVFoundation.h>

@interface SRCameraViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation SRCameraViewController
+ (void)initWithDelegateController:(id) viewController
                         andResult:(void(^)(BOOL isAllowed ,id alert)) completion
{
 
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
        case AVAuthorizationStatusAuthorized:
            // 已经开启授权，可继续
            
            break;
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            // 未检测到摄像头弹出窗口
        { SRAlertController  *alert = [SRAlertController alertControllerWithTitle:@"警告"
                                                                          message:@"请到设置->隐私->相机->,开启相机服务,以便您可以使用扫描服务."
                                       
                                                                   preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            
            [alert addAction:confirm];
            completion(NO, alert);
        }
            break;
        default:
      
   
            break;
    }
    
    
    // 判断选择的模式是否为相机模式，如果没有则弹窗警告
    if ([SRCameraViewController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        SRCameraViewController * cameraVC = [[self alloc] init];
        
        cameraVC.srCameraViewControllerControllerDelegate = viewController;
        cameraVC.allowsEditing = YES;    // 允许编辑
        
        cameraVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        cameraVC.delegate = cameraVC;
        
        completion(YES , cameraVC);
    } else {
        // 未检测到摄像头弹出窗口
        SRAlertController *alert = [SRAlertController alertControllerWithTitle:@"警告"
                                                                       message:@"未检测到摄像头"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:confirm];
        
        completion(NO, alert);
        
        
    }

}

// 图片编辑完成之后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(srImagePickerSelectImage:) name:@"SRImagePickerSelectImage" object:nil];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    // 让image显示在界面上即可
    SRImageInfoModel * imageInfoModel = [[SRImageInfoModel alloc] init];
    imageInfoModel.image = image;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SRImagePickerSelectImage" object:@[imageInfoModel]];

    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SRImagePickerSelectImage" object:nil];
        
    }];
    // Present the camera interface
}

- (void)srImagePickerSelectImage:(NSNotification *)notification {
    
    
    if ([self.srCameraViewControllerControllerDelegate respondsToSelector:@selector(srImagePickerSelectImage:)]) {
        [self.srCameraViewControllerControllerDelegate srImagePickerSelectImage:notification];
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
