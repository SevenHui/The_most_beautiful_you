//
//  MJ_DecalsViewController.h
//  Beautiful
//
//  Created by apple on 16/11/4.
//  Copyright © 2016年 最美的你. All rights reserved.
//  贴纸

#import "MJ_BaseViewController.h"

@protocol MJ_DecalsViewControllerDelegate <NSObject>

- (void)didAddFinished:(UIImage *)image;

@end

@interface MJ_DecalsViewController : MJ_BaseViewController

@property (nonatomic, assign) id<MJ_DecalsViewControllerDelegate> delegate;

@property (nonatomic, strong) UIImage *image;

@end
