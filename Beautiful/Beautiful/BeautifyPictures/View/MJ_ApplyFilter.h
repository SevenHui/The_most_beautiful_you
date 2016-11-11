//
//  MJ_ApplyFilter.h
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJ_ApplyFilter : NSObject


//亮度
+ (UIImage *)changeValueForBrightnessFilter:(float)value image:(UIImage *)image;

//对比度
+ (UIImage *)changeValueForContrastFilter:(float)value image:(UIImage *)image;

//饱和度
+ (UIImage *)changeValueForSaturationFilter:(float)value image:(UIImage *)image;

//高光
+ (UIImage *)changeValueForHightlightFilter:(float)value image:(UIImage *)image;

//暗部
+ (UIImage *)changeValueForLowlightFilter:(float)value image:(UIImage *)image;

//智能补光
+ (UIImage *)changeValueForExposureFilter:(float)value image:(UIImage *)image;

//色温
+ (UIImage *)changeValueForWhiteBalanceFilter:(float)value image:(UIImage *)image;

//自然饱和度
+ (UIImage *)changeValueForVibranceFilter:(float)value image:(UIImage *)image;

//锐化
+ (UIImage *)changeValueForSharpenilter:(float)value image:(UIImage *)image;

//智能优化
+ (UIImage *)autoBeautyFilter:(UIImage *)image;

+ (UIImage *)applyToLookupFilter:(UIImage *)image;

//复杂滤镜

+ (UIImage *)applyAmatorkaFilter:(UIImage *)image;

+ (UIImage *)applyMissetikateFilter:(UIImage *)image;

+ (UIImage *)applySoftEleganceFilter:(UIImage *)image;

+ (UIImage *)applyNashvilleFilter:(UIImage *)image;
// 酒红 3
+ (UIImage *)applyLordKelvinFilter:(UIImage *)image;
// 浪漫 8
+ (UIImage *)applyAmaroFilter:(UIImage *)image;

+ (UIImage *)applyRiseFilter:(UIImage *)image;
// 青柠 7
+ (UIImage *)applyHudsonFilter:(UIImage *)image;
// 梦幻 11
+ (UIImage *)applyXproIIFilter:(UIImage *)image;
// no
+ (UIImage *)apply1977Filter:(UIImage *)image;
// 锐化 5
+ (UIImage *)applyValenciaFilter:(UIImage *)image;
// 蓝调 10
+ (UIImage *)applyWaldenFilter:(UIImage *)image;
// LOMO 1
+ (UIImage *)applyLomofiFilter:(UIImage *)image;
// no
+ (UIImage *)applyInkwellFilter:(UIImage *)image;

+ (UIImage *)applySierraFilter:(UIImage *)image;
// 怀旧 2
+ (UIImage *)applyEarlybirdFilter:(UIImage *)image;
// 哥特 6
+ (UIImage *)applySutroFilter:(UIImage *)image;
// 光晕 9
+ (UIImage *)applyToasterFilter:(UIImage *)image;
// 淡雅 4
+ (UIImage *)applyBrannanFilter:(UIImage *)image;

+ (UIImage *)applyHefeFilter:(UIImage *)image;
// no
+ (UIImage *)applyGlassFilter:(UIImage *)image;

//模糊效果
+ (UIImage *)applyBoxBlur:(UIImage *)image;

+ (UIImage *)applyGaussianBlur:(UIImage *)image;
+ (UIImage *)applyGaussianSelectiveBlur:(UIImage *)image;
+ (UIImage *)applyiOSBlur:(UIImage *)image;
+ (UIImage *)applyMotionBlur:(UIImage *)image;
+ (UIImage *)applyZoomBlur:(UIImage *)image;
+ (UIImage *)applyColorInvertFilter:(UIImage *)image;
+ (UIImage *)applySepiaFilter:(UIImage *)image;
+ (UIImage *)applyHistogramFilter:(UIImage *)image;
+ (UIImage *)applyRGBFilter:(UIImage *)image;
+ (UIImage *)applyToneCurveFilter:(UIImage *)image;
+ (UIImage *)applySketchFilter:(UIImage *)image;
/**
 GPUImageGaussianBlurFilter
 GPUImageBoxBlurFilter
 GPUImageGaussianSelectiveBlurFilter
 GPUImageiOSBlurFilter
 GPUImageMotionBlurFilter
 GPUImageZoomBlurFilter
 */


@end
