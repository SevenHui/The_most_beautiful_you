//
//  MJ_Button.h
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJ_Button;

typedef void(^block)(MJ_Button *button);


@interface MJ_Button : UIButton

+ (MJ_Button *)buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title image:(UIImage *)image color:(UIColor *)color addBlock:(block)tempBlock;

@end
