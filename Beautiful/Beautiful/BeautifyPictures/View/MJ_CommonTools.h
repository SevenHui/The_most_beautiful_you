//
//  MJ_CommonTools.h
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#define kCN @"className"
#define kpn @"propertyName"
#define kPV @"propertyValue"
#define kIM @"imageName"

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface MJ_CommonTools : NSObject

+ (NSDictionary *)getPlistDictionaryForButton;

/*
 *filter class name
 *class property name
 *property value
 *image name
 *
 */
+ (UIImage *)getImageWithFilter:(GPUImageFilter *)filter image:(UIImage *)originalImage method:(NSString *)methodName value:(float)value;

@end
