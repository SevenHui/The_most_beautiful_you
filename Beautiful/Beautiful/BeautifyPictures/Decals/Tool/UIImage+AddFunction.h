//
//  UIImage+AddFunction.h
//
//  Created by mini1 on 14-6-13.
//  Copyright (c) 2014年 TEASON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AddFunction)
// 剪切图片为正方形
+ (UIImage *)squareImageFromImage:(UIImage *)image
                     scaledToSize:(CGFloat)newSize;
// 将UIView转成UIImage
+ (UIImage *)getImageFromView:(UIView *)theView;

@end
