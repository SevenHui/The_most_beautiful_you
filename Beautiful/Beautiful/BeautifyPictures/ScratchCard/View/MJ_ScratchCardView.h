//
//  MJ_ScratchCardView.h
//  Beautiful
//
//  Created by 洛洛大人 on 16/11/5.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJ_ScratchCardView : UIView

{
    CGPoint previousTouchLocation;
    CGPoint currentTouchLocation;
    
    CGImageRef hideImage;
    CGImageRef scratchImage;
    
    CGContextRef contextMask;
}
@property (nonatomic, assign) float sizeBrush;
@property (nonatomic, strong) UIView *hideView;

- (void)setHideView:(UIView *)hideView;
- (UIImage *)getEndImg;

@end
