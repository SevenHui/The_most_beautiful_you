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
@property (nonatomic, strong) UILabel *labelName;

@end

@implementation MJ_CameraPictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageview = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageview];
        
        self.labelName = [[UILabel alloc] init];
        _labelName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_labelName];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageview.frame = self.contentView.bounds;
    self.labelName.frame = CGRectMake(0, _imageview.bounds.size.height * 0.8, WIDTH, _imageview.bounds.size.height * 0.2);
}
- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        _imageName = imageName;
    }
    _imageview.image = [UIImage imageNamed:imageName];
}
- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
    }
    _labelName.text = text;
}

@end
