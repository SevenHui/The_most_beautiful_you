//
//  MJ_DecalsCollectionViewCell.m
//  Beautiful
//
//  Created by apple on 16/11/5.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_DecalsCollectionViewCell.h"

@interface MJ_DecalsCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MJ_DecalsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.contentView.bounds;
    
    
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
    }
    
    _imageView.image = image;
    
}

@end
