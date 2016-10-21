//
//  MJ_Button.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_Button.h"

@interface MJ_Button ()
// 给block变量写合成存储,一定要使用copy
@property (nonatomic, copy) block myBlock;

@end

@implementation MJ_Button

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

+ (MJ_Button *) buttonWithFrame:(CGRect)frame type:(UIButtonType)type title:(NSString *)title image:(UIImage *)image color:(UIColor *)color addBlock:(block)tempBlock{
    
    MJ_Button *button = [MJ_Button buttonWithType:type];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    
    [button setImage:image forState:UIControlStateNormal];
    
    button.frame = frame;
    
    [button addTarget:button action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.myBlock = tempBlock;
    
    return button;
    
    
}

- (void)buttonClicked:(MJ_Button *)button
{
//    触发
    button.tag = 10000;
    
    button.myBlock(button);
    
    
}


@end
