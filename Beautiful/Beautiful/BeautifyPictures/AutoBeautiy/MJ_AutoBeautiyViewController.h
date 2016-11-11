//
//  MJ_AutoBeautiyViewController.h
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//  智能优化

#import <UIKit/UIKit.h>
#import "MJ_EffectBar.h"
#import "MJ_Slider.h"

typedef void(^MJ_AutoBeautiyViewControllerBlock)(UIImage *image);

@interface MJ_AutoBeautiyViewController : MJ_BaseViewController

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) MJ_AutoBeautiyViewControllerBlock block;

- (instancetype)initWithImage:(UIImage *)image;


@end
