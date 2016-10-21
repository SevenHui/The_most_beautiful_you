//
//  MJ_Model.m
//  Beautiful
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_Model.h"

@implementation MJ_Model

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}

+ (MJ_Model *)MJ_BaseModelWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
