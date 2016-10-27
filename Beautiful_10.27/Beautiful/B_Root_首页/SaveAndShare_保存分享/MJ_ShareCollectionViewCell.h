//
//  MJ_ShareCollectionViewCell.h
//  Beautiful
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJ_BaseModel;

@interface MJ_ShareCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *shareImageView;

@property (nonatomic, strong) MJ_BaseModel *model;

@end
