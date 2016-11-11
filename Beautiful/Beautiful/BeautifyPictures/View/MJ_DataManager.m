//
//  MJ_DataManager.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_DataManager.h"

@implementation MJ_DataManager

+ (NSDictionary *)getDataSourceFromPlist {
    
    NSString *plistPathString = [[NSBundle mainBundle] pathForResource:@"effectViewInfo" ofType:@"plist"];
    
    return [[NSDictionary alloc] initWithContentsOfFile:plistPathString];
    
}

@end
