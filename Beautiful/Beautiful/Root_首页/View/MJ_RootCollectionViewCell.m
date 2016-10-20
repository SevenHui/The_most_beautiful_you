//
//  MJ_RootCollectionViewCell.m
//  Beautiful
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_RootCollectionViewCell.h"
#import "MJ_RootModel.h"

@implementation MJ_RootCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.photoImageView = [[UIImageView alloc] init];
        _photoImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_photoImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.29 blue:0.56 alpha:1.00];
//        _titleLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_titleLabel];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.photoImageView.frame = CGRectMake(0, 0, WIDTH, WIDTH);
    _photoImageView.layer.cornerRadius = WIDTH / 2;
    
    self.titleLabel.frame = CGRectMake(0, WIDTH, WIDTH, HEIGHT - WIDTH);
    
}

- (void)setRootModel:(MJ_RootModel *)rootModel {
    if (_rootModel != rootModel) {
        _rootModel = rootModel;
    }
    
    _titleLabel.text = rootModel.title;
    
}


@end
