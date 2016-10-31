//
//  UIView+MJ_AddView.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/28.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "UIView+MJ_AddView.h"

@implementation UIView (MJ_AddView)


- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint XPoint = self.center;
    XPoint.x = centerX;
    self.center = XPoint;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint YPoint = self.center;
    YPoint.y = centerY;
    self.center = YPoint;
}


- (CGFloat)centerY {
    return self.center.y;
}



@end
