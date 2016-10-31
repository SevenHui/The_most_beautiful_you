//
//  MJ_CutoutPicturesViewController.m
//  Beautiful
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CutoutPicturesViewController.h"
#import "MJ_ShareViewController.h"

@interface MJ_CutoutPicturesViewController ()

/**中间显示的当前图片*/
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MJ_CutoutPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTopView];
    [self createImageView];
    
}
#pragma mark - 顶部View
- (void)createTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    // 返回按钮
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.04, topView.bounds.size.height * 0.45, topView.bounds.size.width * 0.07, topView.bounds.size.height * 0.45) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"左箭头2"] color:nil addBlock:^(MJ_Button *button) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [topView addSubview:backButton];
    
    // 保存/分享
    MJ_Button *calendarButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.89, backButton.frame.origin.y, backButton.frame.size.width, backButton.frame.size.height) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"右箭头2"] color:nil addBlock:^(MJ_Button *button) {
        
        MJ_ShareViewController *shareVC = [[MJ_ShareViewController alloc] init];
        [self.navigationController pushViewController:shareVC animated:YES];
        
    }];
    [topView addSubview:calendarButton];
    
}

#pragma mark - 中间显示当前图片
- (void)createImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTHSCREEN, HEIGHTSCREEN * 0.66)];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.image = _image;
    [self.view addSubview:_imageView];
}



@end
