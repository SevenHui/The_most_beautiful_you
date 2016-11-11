//
//  MJ_EffectBar.h
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJ_EffectBarItem.h"

@class MJ_EffectBar;

@protocol MJ_EffectBarDelegate <NSObject>

- (void)effectBar:(MJ_EffectBar *)bar didSelectItemAtIndex:(NSInteger)index;

@end

@interface MJ_EffectBar : UIScrollView

@property (nonatomic, assign) id<MJ_EffectBarDelegate> delegate;

@property (nonatomic, copy) NSArray *items;

@property (nonatomic, strong) MJ_EffectBarItem *selectedItem;

@property CGFloat margin;

@property (nonatomic) CGFloat itemWidth;
@property CGFloat itemBeginX;

- (void)setHeight:(CGFloat)height;

@end
