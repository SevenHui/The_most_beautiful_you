//
//  MJ_RootViewController.m
//  Beautiful
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_RootViewController.h"
// 拍图
#import "MJ_CameraPicturesViewController.h"
// 本地相册 (美图, 抠图)
#import "MJ_LocalPhotoAlbumViewController.h"
// 本地相册多选 (拼图)
#import "MJ_ShowAutoAlbumViewController.h"


@interface MJ_RootViewController ()

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation MJ_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
    [self createRootButton];
    
    
}
- (void)config {
    // 背景图片
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundImageView.backgroundColor = [UIColor colorWithRed:0.94 green:0.64 blue:0.69 alpha:1.00];
    [self.view addSubview:backgroundImageView];
    
}
#pragma mark - 首页四项功能
- (void)createRootButton {
    // 拍图
    MJ_Button *cameraButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN * 0.4, HEIGHTSCREEN * 0.75, WIDTHSCREEN * 0.21, WIDTHSCREEN * 0.21) type:UIButtonTypeCustom title:@"拍图" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        MJ_CameraPicturesViewController *cameraVC = [[MJ_CameraPicturesViewController alloc] init];
        [self.navigationController pushViewController:cameraVC animated:YES];
        
    }];
    cameraButton.layer.cornerRadius = WIDTHSCREEN * 0.21 / 2;
    cameraButton.backgroundColor = COLOR;
    [self.view addSubview:cameraButton];
    
    // 美图
    MJ_Button *beautifyButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN * 0.41, HEIGHTSCREEN * 0.55, WIDTHSCREEN * 0.19, WIDTHSCREEN * 0.19) type:UIButtonTypeCustom title:@"美图" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        MJ_LocalPhotoAlbumViewController *localVC = [[MJ_LocalPhotoAlbumViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:localVC];
        [self presentViewController:navigation animated:YES completion:nil];
        
    }];
    beautifyButton.layer.cornerRadius = WIDTHSCREEN * 0.19 / 2;
    beautifyButton.backgroundColor = COLOR;
    [self.view addSubview:beautifyButton];
    
    // 抠图
    MJ_Button *cutoutButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN * 0.19, HEIGHTSCREEN * 0.65, WIDTHSCREEN * 0.19, WIDTHSCREEN * 0.19) type:UIButtonTypeCustom title:@"抠图" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        MJ_LocalPhotoAlbumViewController *localVC = [[MJ_LocalPhotoAlbumViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:localVC];
        [self presentViewController:navigation animated:YES completion:nil];
        
    }];
    cutoutButton.layer.cornerRadius = WIDTHSCREEN * 0.19 / 2;
    cutoutButton.backgroundColor = COLOR;
    [self.view addSubview:cutoutButton];
    
    // 拼图
    MJ_Button *puzzleButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN * 0.63, HEIGHTSCREEN * 0.65, WIDTHSCREEN * 0.19, WIDTHSCREEN * 0.19) type:UIButtonTypeCustom title:@"拼图" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        MJ_ShowAutoAlbumViewController *showAutoAlbumVC = [[MJ_ShowAutoAlbumViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:showAutoAlbumVC];
        [self presentViewController:navigation animated:YES completion:nil];
        
    }];
    puzzleButton.layer.cornerRadius = WIDTHSCREEN * 0.19 / 2;
    puzzleButton.backgroundColor = COLOR;
    [self.view addSubview:puzzleButton];
    
    
}


@end
