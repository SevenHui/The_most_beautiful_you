//
//  MJ_CameraPictureCollectionViewCell.m
//  Beautiful
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CameraPictureCollectionViewCell.h"

@interface MJ_CameraPictureCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageview;

@end

@implementation MJ_CameraPictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageview = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageview];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageview.frame = self.contentView.bounds;
    
}

- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        _imageName = imageName;
    }
    
    _imageview.image = [UIImage imageNamed:imageName];
}


@end
