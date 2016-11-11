//
//  MJ_CropView.h
//  Beautiful
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_BaseView.h"
#import <QuartzCore/QuartzCore.h>
/*
QuartzCore包含了CoreAnimation的框架，是iOS系统的基本渲染框架，是一个OC语言框架，是一套基于CoreGraphics的OC语言封装，封装出了基本渲染类CALayer。
 */
@interface MJ_CropView : MJ_BaseView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, readonly) UIImage *croppedImage;
@property (nonatomic, readonly) CGRect zoomedCropRect;
@property (nonatomic, readonly) CGAffineTransform rotation;
@property (nonatomic, readonly) BOOL userHasModifiedCropArea;

@property (nonatomic, assign) BOOL keepingCropAspectRatio;
@property (nonatomic, assign) CGFloat cropAspectRatio;

@property (nonatomic, assign) CGRect cropRect;
@property (nonatomic, assign) CGRect imageCropRect;
// 旋转角度
@property (nonatomic, assign) CGFloat rotationAngle;

@property (nonatomic, weak, readonly) UIRotationGestureRecognizer *rotationGestureRecognizer;

- (void)resetCropRect;
- (void)resetCropRectAnimated:(BOOL)animated;

- (void)setRotationAngle:(CGFloat)rotationAngle snap:(BOOL)snap;

@end
