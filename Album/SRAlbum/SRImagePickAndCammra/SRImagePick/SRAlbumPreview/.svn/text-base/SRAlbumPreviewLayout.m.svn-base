//
//  SRAlbumPreviewLayout.m
//  CameraDemo
//
//  Created by sharui on 2016/10/12.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "SRAlbumPreviewLayout.h"

@implementation SRAlbumPreviewLayout

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

/// 最小 Cell 宽高
- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat margin = 0;
    
    self.itemSize = CGSizeMake(screenW, screenH);
    self.minimumInteritemSpacing = margin;
    self.minimumLineSpacing = margin;
    self.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
