//
//  UIImage+PECrop.h
//  PhotoCropEditor
//
//  Created by Ernesto Rivera on 2013/07/29.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PECrop)
// 透明部分
- (UIImage *)rotatedImageWithtransform:(CGAffineTransform)rotation croppedToRect:(CGRect)rect;

@end
