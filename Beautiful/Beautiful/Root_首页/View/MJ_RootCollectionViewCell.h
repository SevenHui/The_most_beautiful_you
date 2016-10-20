//
//  MJ_RootCollectionViewCell.h
//  Beautiful
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJ_RootModel;
@interface MJ_RootCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) MJ_RootModel *rootModel;

@end
