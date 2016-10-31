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
// 抠图
#import "MJ_CutoutPicturesViewController.h"
// 拼图
#import "MJ_PuzzlePicturesViewController.h"
#import "JFImagePickerController.h"

@interface MJ_RootViewController ()
<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
JFImagePickerDelegate
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
        
        // 弹出系统相册
        self.beautifyImagePicker = [[UIImagePickerController alloc] init];
        // 设置图片来源
        _beautifyImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置代理
        _beautifyImagePicker.delegate = self;
        [self presentViewController:_beautifyImagePicker animated:YES completion:nil];
        
        
    }];
    beautifyButton.layer.cornerRadius = WIDTHSCREEN * 0.19 / 2;
    beautifyButton.backgroundColor = COLOR;
    [self.view addSubview:beautifyButton];
    
    // 抠图
    MJ_Button *cutoutButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN * 0.19, HEIGHTSCREEN * 0.65, WIDTHSCREEN * 0.19, WIDTHSCREEN * 0.19) type:UIButtonTypeCustom title:@"抠图" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        // 弹出系统相册
        self.cutoutImagePicker = [[UIImagePickerController alloc] init];
        // 设置图片来源
        _cutoutImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置代理
        _cutoutImagePicker.delegate = self;
        [self presentViewController:_cutoutImagePicker animated:YES completion:nil];

        
    }];
    cutoutButton.layer.cornerRadius = WIDTHSCREEN * 0.19 / 2;
    cutoutButton.backgroundColor = COLOR;
    [self.view addSubview:cutoutButton];
    
    // 拼图
    MJ_Button *puzzleButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN * 0.63, HEIGHTSCREEN * 0.65, WIDTHSCREEN * 0.19, WIDTHSCREEN * 0.19) type:UIButtonTypeCustom title:@"拼图" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        // 系统相册多选图片
        JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:nil];
        picker.pickerDelegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    puzzleButton.layer.cornerRadius = WIDTHSCREEN * 0.19 / 2;
    puzzleButton.backgroundColor = COLOR;
    [self.view addSubview:puzzleButton];
    
}
#pragma mark - 相册将要结束 - 退出
- (void)imagePickerDidFinished:(JFImagePickerController *)picker{
    [self imagePickerDidCancel:picker];
    
}
- (void)imagePickerDidCancel:(JFImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 美图
    if (picker == _beautifyImagePicker) {
        MJ_BeautifyPicturesViewController *beautifyVC = [[MJ_BeautifyPicturesViewController alloc] init];
        beautifyVC.image = info[UIImagePickerControllerOriginalImage];
        [self.navigationController pushViewController:beautifyVC animated:YES];
    }
    // 抠图
    else if (picker == _cutoutImagePicker) {
        MJ_CutoutPicturesViewController *cutoutVC = [[MJ_CutoutPicturesViewController alloc] init];
        cutoutVC.image = info[UIImagePickerControllerOriginalImage];
        [self.navigationController pushViewController:cutoutVC animated:YES];
    }
   
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}




@end
