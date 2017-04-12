//
//  SRImageGridCollectionViewCell.m
//  CameraDemo
//
//  Created by sharui on 2016/10/13.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRImageGridCollectionViewCell.h"
@interface SRImageGridCollectionViewCell ()

/**
 cell图片
 */
@property (nonatomic) UIImageView *imageView;
@end
NSString *const SRImagePickerBundleName = @"SRImagePicker.bundle";

@implementation SRImageGridCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.selectedButton];
    }
    return self;
}

#pragma mark - 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    
    CGFloat offsetX = self.bounds.size.width - _selectedButton.bounds.size.width;
    _selectedButton.frame = CGRectOffset(_selectedButton.bounds, offsetX, 0);
}

#pragma mark - 监听方法
- (void)clickSelectedButton {
    
    _selectedButton.selected = !_selectedButton.selected;
    [self.delegate imageGridCell:self didSelected:_selectedButton.selected];
}

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UIButton *)selectedButton {
    if (_selectedButton == nil) {
        _selectedButton = [[UIButton alloc] init];
        
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:SRImagePickerBundleName withExtension:nil];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        
        UIImage *normalImage = [UIImage imageNamed:@"check_box_default"
                                          inBundle:imageBundle
                     compatibleWithTraitCollection:nil];
        [_selectedButton setImage:normalImage forState:UIControlStateNormal];
        UIImage *selectedImage = [UIImage imageNamed:@"check_box_right"
                                            inBundle:imageBundle
                       compatibleWithTraitCollection:nil];
        [_selectedButton setImage:selectedImage forState:UIControlStateSelected];
        [_selectedButton sizeToFit];
        [_selectedButton addTarget:self action:@selector(clickSelectedButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
}

- (void)setImageInfoModel:(SRImageInfoModel *)imageInfoModel {
    
    _imageInfoModel = imageInfoModel;
    self.imageView.image = imageInfoModel.image;
}
@end
