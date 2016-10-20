//
//  MJ_CameraPhotoViewController.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CameraPhotoViewController.h"
#import "MJ_Button.h"

@interface MJ_CameraPhotoViewController ()

@end

@implementation MJ_CameraPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTopView];
    [self creatBottomView];
    
    
}
#pragma mark - 顶部View
- (void)creatTopView {
    // View
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHVIEW, HEIGHTVIEW * 0.1)];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor grayColor];
    
//    返回
    MJ_Button *button = [MJ_Button buttonWithFrame:CGRectMake(topView.frame.size.width * 0.02, HEIGHTVIEW * 0.027, WIDTHVIEW * 0.15, HEIGHTVIEW * 0.05) type:UIButtonTypeCustom title:@"返回" image:nil color:[UIColor greenColor] addBlock:^(MJ_Button *button) {
        
        [self buttonAction:button];
    }];
    button.backgroundColor = COLOR;
    [topView addSubview:button];
   
//    设置
    MJ_Button *buttonOfSet = [MJ_Button buttonWithFrame:CGRectMake(WIDTHVIEW * 0.48, HEIGHTVIEW * 0.027, HEIGHTVIEW * 0.05, HEIGHTVIEW * 0.05) type:UIButtonTypeCustom title:@"设" image:nil color:[UIColor greenColor] addBlock:^(MJ_Button *button) {
       
    }];
    [topView addSubview:buttonOfSet];
    buttonOfSet.backgroundColor = COLOR;

   
//    补光
    MJ_Button *buttonOfFillLight = [MJ_Button buttonWithFrame:CGRectMake(buttonOfSet.frame.size.width * 2 + buttonOfSet.frame.origin.x, buttonOfSet.frame.origin.y, buttonOfSet.frame.size.width, buttonOfSet.frame.size.height) type:UIButtonTypeCustom title:@"补" image:nil color:[UIColor greenColor] addBlock:^(MJ_Button *button) {
        
    }];
    [topView addSubview:buttonOfFillLight];
    buttonOfFillLight.backgroundColor = COLOR;
    
//     旋转
    MJ_Button *buttonOfRotating = [MJ_Button buttonWithFrame:CGRectMake(buttonOfFillLight.frame.size.width * 2 + buttonOfFillLight.frame.origin.x, buttonOfFillLight.frame.origin.y, buttonOfFillLight.frame.size.width, buttonOfFillLight.frame.size.height) type:UIButtonTypeCustom title:@"转" image:nil color:[UIColor greenColor] addBlock:^(MJ_Button *button) {
        
    }];
    [topView addSubview:buttonOfRotating];
    buttonOfRotating.backgroundColor = COLOR;
    
   
    
}
#pragma mark - 底部View
- (void)creatBottomView {
//    View
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - WIDTHVIEW * 0.48, self.view.frame.size.width, WIDTHVIEW * 0.48)];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor lightGrayColor];
   
//    相册
    MJ_Button *buttonOfPhoto = [MJ_Button buttonWithFrame:CGRectMake(HEIGHTVIEW * 0.05, HEIGHTVIEW * 0.177, WIDTHVIEW * 0.15, HEIGHTVIEW * 0.05) type:UIButtonTypeCustom title:@"相册" image:nil color:[UIColor greenColor] addBlock:^(MJ_Button *button) {
        
    }];
    [bottomView addSubview:buttonOfPhoto];
    buttonOfPhoto.backgroundColor = COLOR;

  
  
//    拍照
    MJ_Button *buttonOfPat = [MJ_Button buttonWithFrame:CGRectMake(self.view.frame.size.width / 2 - WIDTHVIEW * 0.12, HEIGHTVIEW * 0.15, WIDTHVIEW * 0.24, HEIGHTVIEW * 0.11) type:UIButtonTypeCustom title:@"拍照" image:nil color:[UIColor greenColor] addBlock:^(MJ_Button *button) {
        
    }];
    [bottomView addSubview:buttonOfPat];
    buttonOfPat.backgroundColor = COLOR;
   
//    特效
    MJ_Button *buttonOfEffect = [MJ_Button buttonWithFrame:CGRectMake(self.view.frame.size.width - buttonOfPhoto.frame.size.width - buttonOfPhoto.frame.origin.x, buttonOfPhoto.frame.origin.y, buttonOfPhoto.frame.size.width, buttonOfPhoto.frame.size.height) type:UIButtonTypeCustom title:@"特效" image:nil color:[UIColor greenColor] addBlock:^(MJ_Button *button) {
        
    }];
    [bottomView addSubview:buttonOfEffect];
   buttonOfEffect.backgroundColor = COLOR;

    
}
#pragma mark - 返回点击事件
- (void)buttonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}





@end
