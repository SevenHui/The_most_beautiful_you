//
//  MJ_FilterCollectionViewCell.m
//  Beautiful
//
//  Created by apple on 16/11/3.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_FilterCollectionViewCell.h"

@interface MJ_FilterCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MJ_FilterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:0.94 green:0.64 blue:0.69 alpha:1.00];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.contentView.frame;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
    }
    _titleLabel.text = text;
    
}


@end
