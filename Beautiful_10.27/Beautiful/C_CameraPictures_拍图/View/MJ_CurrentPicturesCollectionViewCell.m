//
//  MJ_CurrentPicturesCollectionViewCell.m
//  Beautiful
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CurrentPicturesCollectionViewCell.h"
#import "MJ_BaseModel.h"

@implementation MJ_CurrentPicturesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:0.94 green:0.64 blue:0.69 alpha:1.00];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _iconImageView.backgroundColor = [UIColor redColor];
    _iconImageView.frame = CGRectMake(WIDTH * 0.07, HEIGHT * 0.04, WIDTH * 0.85, WIDTH * 0.85);
    _iconImageView.layer.cornerRadius = WIDTH * 0.85 / 2;
    
    _titleLabel.frame = CGRectMake(0, _iconImageView.frame.size.height + _iconImageView.frame.origin.y, WIDTH, HEIGHT - _iconImageView.frame.size.height - _iconImageView.frame.origin.y);
    
    
}

- (void)setModel:(MJ_BaseModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    _iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", model.icon]];
    _titleLabel.text = model.title;
    
    
}


@end
