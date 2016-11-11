//
//  MJ_ColorListViewController.h
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//  调节

#import <UIKit/UIKit.h>
#import "MJ_Slider.h"
#import "MJ_EffectBar.h"

typedef void(^MJ_ColorListViewControllerBlock)(UIImage *image);

@interface MJ_ColorListViewController : MJ_BaseViewController <MJ_EffectBarDelegate>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) MJ_ColorListViewControllerBlock block;

- (instancetype)initWithImage:(UIImage *)image;



@end
