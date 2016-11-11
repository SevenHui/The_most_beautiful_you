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
// 美图
#import "MJ_BeautifyPicturesViewController.h"

@interface MJ_RootViewController ()
<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIImagePickerController *beautifyImagePicker;
@property (nonatomic, strong) UIImagePickerController *cutoutImagePicker;

@end

@implementation MJ_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
    [self createRootButton];
    
}
- (void)config {

    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundImageView.backgroundColor = ROOTCOLOR;
    backgroundImageView.image = [UIImage imageNamed:@"最美的你.封面"];
    [self.view addSubview:backgroundImageView];
    
}

- (void)createRootButton {
    
    // 拍图
    MJ_Button *cameraButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN * 0.18, HEIGHTSCREEN * 0.74, WIDTHSCREEN * 0.20, WIDTHSCREEN * 0.20) type:UIButtonTypeCustom title:nil image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        MJ_CameraPicturesViewController *cameraVC = [[MJ_CameraPicturesViewController alloc] init];
        [self.navigationController pushViewController:cameraVC animated:YES];
        
    }];
    UIImageView *imageViewCamera = [[UIImageView alloc] initWithFrame:cameraButton.bounds];
    imageViewCamera.image = [UIImage imageNamed:@"xiangji.png"];
    imageViewCamera.clipsToBounds = YES;
    [imageViewCamera.layer setCornerRadius:WIDTHSCREEN * 0.20 / 2];
    imageViewCamera.layer.shouldRasterize = YES;
    [cameraButton addSubview:imageViewCamera];
    cameraButton.layer.cornerRadius = WIDTHSCREEN * 0.20 / 2;
    cameraButton.backgroundColor = COLOR;
    [self.view addSubview:cameraButton];
    
    // 美图
    MJ_Button *beautifyButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN * 0.58, HEIGHTSCREEN * 0.74, WIDTHSCREEN * 0.20, WIDTHSCREEN * 0.20) type:UIButtonTypeCustom title:nil image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        // 弹出系统相册
        self.beautifyImagePicker = [[UIImagePickerController alloc] init];
        // 设置图片来源
        _beautifyImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置代理
        _beautifyImagePicker.delegate = self;
        [self presentViewController:_beautifyImagePicker animated:YES completion:nil];
        
        
    }];
    UIImageView *imageViewBeautify = [[UIImageView alloc] initWithFrame:beautifyButton.bounds];
    imageViewBeautify.image = [UIImage imageNamed:@"meitu.png"];
    imageViewBeautify.clipsToBounds = YES;
    [imageViewBeautify.layer setCornerRadius:WIDTHSCREEN * 0.20 / 2];
    imageViewBeautify.layer.shouldRasterize = YES;
    [beautifyButton addSubview:imageViewBeautify];
    beautifyButton.layer.cornerRadius = WIDTHSCREEN * 0.20 / 2;
    beautifyButton.backgroundColor = COLOR;
    [self.view addSubview:beautifyButton];
    
    
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    MJ_BeautifyPicturesViewController *beautifyVC = [[MJ_BeautifyPicturesViewController alloc] init];
        beautifyVC.image = info[UIImagePickerControllerOriginalImage];
    [self.navigationController pushViewController:beautifyVC animated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
