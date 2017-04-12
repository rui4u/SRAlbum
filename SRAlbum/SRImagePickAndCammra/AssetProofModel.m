//
//  AssetProofModel.m
//  HZPrivateEquityiOSClient
//
//  Created by sharui on 2016/10/28.
//  Copyright © 2016年 ZhentaiNing_Huizhong. All rights reserved.
//

#import "AssetProofModel.h"

@implementation AssetProofModel


- (void)setImageType:(NSString *)imageType {
    NSArray *array = [imageType componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
    
    _imageType = array.lastObject;

}
- (id)copyWithZone:(nullable NSZone *)zone
{
    AssetProofModel * assetProofModel =
    [[AssetProofModel allocWithZone:zone ] init];
    assetProofModel->_image = _image;
    assetProofModel-> _url = _url ;
    assetProofModel->_indexPath = _indexPath;
    assetProofModel->_uploadStatus = _uploadStatus;
    assetProofModel->_imageType = _imageType;
    return assetProofModel;
}


@end
