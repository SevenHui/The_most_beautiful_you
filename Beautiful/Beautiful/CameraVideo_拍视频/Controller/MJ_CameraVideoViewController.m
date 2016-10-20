//
//  MJ_CameraVideoViewController.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CameraVideoViewController.h"
#import "MJ_Button.h"

@interface MJ_CameraVideoViewController ()

@end

@implementation MJ_CameraVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTopView];
    [self creatBottomView];
    
    
}
#pragma mark - 顶部View
- (void)creatTopView {
    // View
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHVIEW, 80)];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor grayColor];
    
    // 返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 20, 60, 40);
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [topView addSubview:button];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置
    MJ_Button *buttonOfSet = [MJ_Button buttonWithType:UIButtonTypeCustom];
    buttonOfSet.frame = CGRectMake(200, 20, 40, 40);
    [buttonOfSet setTitle:@"设" forState:UIControlStateNormal];
    [topView addSubview:buttonOfSet];
    buttonOfSet.backgroundColor = [UIColor greenColor];
   
    // 补光
    MJ_Button *buttonOfFillLight = [MJ_Button buttonWithType:UIButtonTypeCustom];
    buttonOfFillLight.frame = CGRectMake(buttonOfSet.frame.size.width * 2 + buttonOfSet.frame.origin.x, buttonOfSet.frame.origin.y, buttonOfSet.frame.size.width, buttonOfSet.frame.size.height);
    [buttonOfFillLight setTitle:@"补" forState:UIControlStateNormal];
    [topView addSubview:buttonOfFillLight];
    buttonOfFillLight.backgroundColor = [UIColor greenColor];
   
    // 旋转
    MJ_Button *buttonOfRotating = [MJ_Button buttonWithType:UIButtonTypeCustom];
    buttonOfRotating.frame = CGRectMake(buttonOfFillLight.frame.size.width * 2 + buttonOfFillLight.frame.origin.x, buttonOfFillLight.frame.origin.y, buttonOfFillLight.frame.size.width, buttonOfFillLight.frame.size.height);
    [buttonOfRotating setTitle:@"转" forState:UIControlStateNormal];
    [topView addSubview:buttonOfRotating];
    buttonOfRotating.backgroundColor = [UIColor greenColor];
    
}
#pragma mark - 底部View
- (void)creatBottomView {
    // View
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200)];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    
    // 相册
    MJ_Button *buttonOfPhoto = [MJ_Button buttonWithType:UIButtonTypeCustom];
    buttonOfPhoto.frame = CGRectMake(40, 130, 60, 40);
    [buttonOfPhoto setTitle:@"相册" forState:UIControlStateNormal];
    [bottomView addSubview:buttonOfPhoto];
    buttonOfPhoto.backgroundColor = [UIColor greenColor];
   
    // 拍照
    MJ_Button *buttonOfPat = [MJ_Button buttonWithType:UIButtonTypeCustom];
    buttonOfPat.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 110, 100, 80);
    [buttonOfPat setTitle:@"拍照" forState:UIControlStateNormal];
    [bottomView addSubview:buttonOfPat];
    buttonOfPat.backgroundColor = [UIColor greenColor];
    
    // 特效
    MJ_Button *buttonOfEffect = [MJ_Button buttonWithType:UIButtonTypeCustom];
    buttonOfEffect.frame = CGRectMake(self.view.frame.size.width - buttonOfPhoto.frame.size.width - buttonOfPhoto.frame.origin.x, buttonOfPhoto.frame.origin.y, buttonOfPhoto.frame.size.width, buttonOfPhoto.frame.size.height);
    [buttonOfEffect setTitle:@"特效" forState:UIControlStateNormal];
    [bottomView addSubview:buttonOfEffect];
    buttonOfEffect.backgroundColor = [UIColor greenColor];
    
    
}
#pragma mark - 返回点击事件
- (void)buttonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
