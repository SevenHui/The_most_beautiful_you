//
//  MJ_ShareCollectionViewCell.m
//  Beautiful
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_ShareCollectionViewCell.h"
#import "MJ_BaseModel.h"

@interface MJ_ShareCollectionViewCell ()

@property (nonatomic, strong) UIImageView *shareImageView;

@end

@implementation MJ_ShareCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        self.shareImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_shareImageView];
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _shareImageView.frame = self.contentView.bounds;
    
}
- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
    }
    
    _shareImageView.image = image;
    
}



@end
