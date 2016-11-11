//
//  MJ_CropViewController.h
//  Beautiful
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 最美的你. All rights reserved.
//  编辑

#import "MJ_BaseViewController.h"

@protocol MJ_CropViewControllerDelegate;

@interface MJ_CropViewController : MJ_BaseViewController

@property (nonatomic, weak) id<MJ_CropViewControllerDelegate> delegate;
@property (nonatomic) UIImage *image;

@property (nonatomic) BOOL keepingCropAspectRatio;
@property (nonatomic) CGFloat cropAspectRatio;

@property (nonatomic) CGRect cropRect;
@property (nonatomic) CGRect imageCropRect;

@property (nonatomic) BOOL toolbarHidden;

@property (nonatomic, assign, getter = isRotationEnabled) BOOL rotationEnabled;

@property (nonatomic, readonly) CGAffineTransform rotationTransform;

@property (nonatomic, readonly) CGRect zoomedCropRect;


- (void)resetCropRect;
- (void)resetCropRectAnimated:(BOOL)animated;

@end

@protocol MJ_CropViewControllerDelegate <NSObject>
@optional

- (void)cropViewController:(MJ_CropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage;

- (void)cropViewController:(MJ_CropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect;

- (void)cropViewControllerDidCancel:(MJ_CropViewController *)controller;

@end
