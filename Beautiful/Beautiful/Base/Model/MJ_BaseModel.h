//
//  MJ_BaseModel.h
//  Beautiful
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJ_BaseModel : NSObject

/**图标*/
@property (nonatomic, copy) NSString *icon;
/**标题*/
@property (nonatomic, copy) NSString *title;

/**基类初始化方法*/
- (instancetype)initWithDic:(NSDictionary *)dic;

/**基类构造器方法*/
+ (instancetype)MJ_BaseModelWithDic:(NSDictionary *)dic;

NS_ASSUME_NONNULL_END
@end
