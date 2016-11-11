//
//  MJ_FilterViewController.h
//  Beautiful
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 最美的你. All rights reserved.
//  特效

#import "MJ_BaseViewController.h"

@protocol MJ_FilterViewControllerDelegate <NSObject>

- (void)calendarImage:(UIImage *)image;

@end

@interface MJ_FilterViewController : MJ_BaseViewController

@property (nonatomic, assign) id<MJ_FilterViewControllerDelegate> delegate;

@property (nonatomic, strong) UIImage *image;

@end
