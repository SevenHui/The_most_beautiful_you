//
//  MJ_ShareCollectionViewCell.m
//  Beautiful
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_ShareCollectionViewCell.h"
#import "MJ_BaseModel.h"

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
    [self layoutSubviews];
    
    _shareImageView.frame = self.contentView.bounds;
    
}
- (void)setModel:(MJ_BaseModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    NSString *string = [NSString stringWithFormat:@"%@", model.icon];
    _shareImageView.image = [UIImage imageNamed:string];
    
    
}




@end
