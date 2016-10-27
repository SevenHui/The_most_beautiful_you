//
//  MJ_CurrentPicturesCollectionViewCell.h
//  Beautiful
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJ_BaseModel;

@interface MJ_CurrentPicturesCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) MJ_BaseModel *model;

@end
