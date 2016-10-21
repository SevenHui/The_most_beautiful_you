//
//  MJ_ShareViewController.m
//  Beautiful
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_ShareViewController.h"

@interface MJ_ShareViewController ()

@end

@implementation MJ_ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
    [self createTopView];

}
- (void)createTopView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    //        view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    // 返回
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(view.bounds.size.width * 0.9, view.bounds.size.height * 0.5, view.bounds.size.width * 0.07, view.bounds.size.height * 0.4) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"返回"] color:nil addBlock:^(MJ_Button *button) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
//    backButton.backgroundColor = [UIColor orangeColor];
    [view addSubview:backButton];
    
}







@end
