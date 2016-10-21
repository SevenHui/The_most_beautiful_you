//
//  MJ_CutoutPicturesViewController.m
//  Beautiful
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CutoutPicturesViewController.h"

@interface MJ_CutoutPicturesViewController ()

@end

@implementation MJ_CutoutPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTopView];
    
    
}
#pragma mark - 顶部View
- (void)createTopView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    //        view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    // 返回按钮
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(view.bounds.size.width * 0.02, view.bounds.size.height * 0.5, view.bounds.size.width * 0.06, view.bounds.size.height * 0.4) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"返回"] color:nil addBlock:^(MJ_Button *button) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    //        backButton.backgroundColor = [UIColor purpleColor];
    [view addSubview:backButton];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width / 2 - view.bounds.size.width * 0.1, view.bounds.size.height * 0.5, view.bounds.size.width * 0.2, view.bounds.size.height * 0.4)];
    titleLabel.text = @"时光轴";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.29 blue:0.56 alpha:1.00];
    titleLabel.font = [UIFont systemFontOfSize:20];
    //        titleLabel.backgroundColor = [UIColor magentaColor];
    [view addSubview:titleLabel];
    
    // 日历
    MJ_Button *calendarButton = [MJ_Button buttonWithFrame:CGRectMake(view.bounds.size.width * 0.9, view.bounds.size.height * 0.5, view.bounds.size.width * 0.07, view.bounds.size.height * 0.4) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"日历"] color:nil addBlock:^(MJ_Button *button) {
        
        
    }];
    //    calendarButton.backgroundColor =[UIColor whiteColor];
    [view addSubview:calendarButton];
    
}

@end
