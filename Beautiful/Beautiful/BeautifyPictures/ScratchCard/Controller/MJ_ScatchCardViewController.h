//
//  MJ_ScatchCardViewController.h
//  Beautiful
//
//  Created by 洛洛大人 on 16/11/5.
//  Copyright © 2016年 最美的你. All rights reserved.
//  马赛克

#import <UIKit/UIKit.h>


typedef void(^MJ_ScatchCardViewControllerBlock)(UIImage *image);
@interface MJ_ScatchCardViewController : UIViewController
@property (nonatomic, copy) MJ_ScatchCardViewControllerBlock block;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) BOOL toolbarHidden;

- (instancetype)initWithImage:(UIImage *)image;



@end
