//
//  MJ_CurrentPicturesCollectionViewCell.m
//  Beautiful
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CurrentPicturesCollectionViewCell.h"

@interface MJ_CurrentPicturesCollectionViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

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
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
  //  _iconImageView.backgroundColor = [UIColor yellowColor];
    _iconImageView.frame = CGRectMake(WIDTH * 0.2, HEIGHT * 0.04, WIDTH * 0.6, WIDTH * 0.6);
    _iconImageView.layer.cornerRadius = WIDTH * 0.6 / 2;
    
    _titleLabel.frame = CGRectMake(0, _iconImageView.frame.size.height + _iconImageView.frame.origin.y, WIDTH, HEIGHT - _iconImageView.frame.size.height - _iconImageView.frame.origin.y);
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
    }
    _iconImageView.image = image;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
    }
    _titleLabel.text = text;
}


@end
