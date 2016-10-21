//
//  MJ_BaseViewController.m
//  Beautiful
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_BaseViewController.h"

@interface MJ_BaseViewController ()

@end

@implementation MJ_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

}



@end
