//
//  MJ_ShareViewController.m
//  Beautiful
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_ShareViewController.h"
#import "MJ_RootViewController.h"

@interface MJ_ShareViewController ()

/**分享图标*/
@property (nonatomic, strong) NSArray *imagesArray;

@end

@implementation MJ_ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTopView];
    [self createView];

}
#pragma mark - 顶部View
- (void)createTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    // 返回按钮
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.04, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.06, topView.bounds.size.height * 0.38) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"返回"] color:nil addBlock:^(MJ_Button *button) {
        
        MJ_RootViewController *rootVC = [[MJ_RootViewController alloc] init];
        [self.navigationController popToViewController:rootVC animated:YES];
        
    }];
    [topView addSubview:backButton];

    
}
#pragma mark - 保存View
- (void)createView {
    // 已保存
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTHSCREEN / 2 - WIDTHSCREEN * 0.08, HEIGHTSCREEN * 0.18, WIDTHSCREEN * 0.16, WIDTHSCREEN * 0.16)];
    imageView.image = [UIImage imageNamed:@"share_done"];
    [self.view addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTHSCREEN / 2 - WIDTHSCREEN * 0.08, HEIGHTSCREEN * 0.28, WIDTHSCREEN * 0.16, HEIGHTSCREEN * 0.05)];
    label.text = @"已保存";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    // 回首页
    MJ_Button *backRootButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN / 2 - WIDTHSCREEN * 0.15, HEIGHTSCREEN * 0.4, WIDTHSCREEN * 0.3, HEIGHTSCREEN * 0.06) type:UIButtonTypeCustom title:@"回首页" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    backRootButton.backgroundColor = ROOTCOLOR;
    backRootButton.layer.cornerRadius = 18;
    [self.view addSubview:backRootButton];
    
    // 进入美图
    MJ_Button *goShareButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN / 2 - WIDTHSCREEN * 0.15, HEIGHTSCREEN * 0.48, WIDTHSCREEN * 0.3, HEIGHTSCREEN * 0.06) type:UIButtonTypeCustom title:@"进入美图" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    goShareButton.backgroundColor = ROOTCOLOR;
    goShareButton.layer.cornerRadius = 18;
    [self.view addSubview:goShareButton];

}


@end
