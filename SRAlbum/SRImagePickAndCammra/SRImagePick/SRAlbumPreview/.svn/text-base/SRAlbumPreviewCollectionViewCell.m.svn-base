//
//  SRAlbumPreviewCollectionViewCell.m
//  CameraDemo
//
//  Created by sharui on 2016/10/12.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRAlbumPreviewCollectionViewCell.h"

#define SRScreenWidth [UIScreen mainScreen].bounds.size.width
#define SRScreenHeight [UIScreen mainScreen].bounds.size.height
@interface SRAlbumPreviewCollectionViewCell()<UIScrollViewDelegate>
@property (nonatomic,strong)UIImageView *imageView;

/**
 背景图片
 */
@property (nonatomic,strong)UIScrollView *scroll;
/**
 预览界面图片
 */
@property (nonatomic,strong)UIImage *conImage;
@end

@implementation SRAlbumPreviewCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self){
        
        _scroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scroll.minimumZoomScale = 1;
        _scroll.maximumZoomScale = 2;
        _scroll.delegate = self;
        _scroll.directionalLockEnabled = YES;
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        
//        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo)];
//        tapGesture.numberOfTapsRequired = 1;
//        [_scroll addGestureRecognizer:tapGesture];
        [self.imageView setContentMode: UIViewContentModeScaleAspectFit];
        [_scroll addSubview:_imageView];
        [self.contentView addSubview:_scroll];
        
        
    }
    return self;
}


- (void)setConImage:(UIImage *)conImage{
    _conImage = conImage;
 
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_conImage != nil) {
        _scroll.zoomScale = 1;
        CGFloat w = SRScreenWidth;
        CGFloat h = _conImage.size.height /_conImage.size.width* w;
        
        NSLog(@"图片的大小:w = %f  h = %f",w,h);
        _scroll.frame = CGRectMake(0, 0, SRScreenWidth, SRScreenHeight);
        _scroll.contentSize = CGSizeMake(SRScreenWidth, h);
        
        _imageView.frame = CGRectMake(2.5, (SRScreenHeight-h)/2, SRScreenWidth -5, h);
        [_imageView setImage:_conImage];
    }
}

- (void)Actiondo {
    
    if ([self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:)]){
    
        [self.delegate didSelectItemAtIndexPath:self.indexPath];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    [self contentScroller];
    
}

- (void)contentScroller{
    CGRect f = _imageView.frame;
    CGSize size = _scroll.frame.size;
    
    if(f.size.width < size.width){
        f.origin.x = (SRScreenWidth - f.size.width)/2;
    }else{
        f.origin.x = 0.0f;
    }
    if(f.size.height < size.height){
        f.origin.y = (SRScreenHeight - f.size.height)/2;
    }else{
        f.origin.y = 0.0f;
    }
    _imageView.frame = f;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return _imageView;
}

- (void)setImageInfoModel:(SRImageInfoModel *)imageInfoModel {
    _imageInfoModel = imageInfoModel;
    self.conImage = _imageInfoModel.image;
}
@end
