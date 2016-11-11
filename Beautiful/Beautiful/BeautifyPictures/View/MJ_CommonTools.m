//
//  MJ_CommonTools.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//



#import "MJ_CommonTools.h"
#import <CloudKit/CloudKit.h>


@implementation MJ_CommonTools

+ (NSDictionary *)getPlistDictionaryForButton
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"effectViewInfo" ofType:@"plist"];
    
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];;
}

+ (UIImage *)getImageWithFilter:(GPUImageFilter *)filter image:(UIImage *)originalImage method:(NSString *)methodName value:(float)value
{
    UIImage *image = originalImage;
    [filter performSelector:NSSelectorFromString(methodName) withObject:[NSString stringWithFormat:@"%f",value]];
    [filter forceProcessingAtSize:originalImage.size];
    GPUImagePicture *stillImage = [[GPUImagePicture alloc] initWithImage:image];
    [stillImage addTarget:filter];
    [stillImage processImage];
    [filter useNextFrameForImageCapture];
    
    return [filter imageFromCurrentFramebuffer];
}


@end
