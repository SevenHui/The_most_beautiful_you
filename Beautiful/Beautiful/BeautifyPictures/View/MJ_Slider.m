//
//  MJ_Slider.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_Slider.h"

@implementation MJ_TipView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.currentValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.currentValueLabel.backgroundColor = [UIColor clearColor];
        self.currentValueLabel.textColor = [UIColor blackColor];
        self.currentValueLabel.font = [UIFont systemFontOfSize:12.0];
        self.currentValueLabel.textAlignment = NSTextAlignmentCenter;
        self.currentValueLabel.adjustsFontSizeToFitWidth = YES;
        
        self.opaque = NO;
        
        [self addSubview:self.currentValueLabel];

    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.currentValueLabel.frame = CGRectMake(0, 5, frame.size.width, 15);
    
}

@end

@implementation MJ_Slider

- (MJ_TipView *)tipView {
    if (_tipView == nil)
    {
        [self addTarget:self action:@selector(updateTipViewframe) forControlEvents:UIControlEventValueChanged];
        _tipView = [[MJ_TipView alloc] initWithFrame:CGRectMake(self.frame.origin.x, HEIGHTSCREEN - 115, 28, 25)];
        _tipView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"slider_tip_white_bg"]];
        
        [self updateTipViewframe];
        [self addSubview:_tipView];
        
        _tipView.alpha = 0.0;
    }
    return _tipView;
}

- (void)updateTipViewframe
{
    CGFloat minimum =  self.minimumValue;
    CGFloat maximum = self.maximumValue;
    CGFloat value = self.value;
    
    if (minimum < 0.0) {
        
        value = self.value - minimum;
        maximum = maximum - minimum;
        minimum = 0.0;
    }
    
    CGFloat x = self.frame.origin.x;
    CGFloat maxMin = (maximum + minimum) / 2.0;
    
    x += (((value - minimum) / (maximum - minimum)) * self.frame.size.width) - (self.tipView.frame.size.width / 2.0);
    
    if (value > maxMin) {
        
        value = (value - maxMin) + (minimum * 1.0);
        value = value / maxMin;
        value = value * 11.0;
        
        x = x - value;
        
    } else {
        
        value = (maxMin - value) + (minimum * 1.0);
        value = value / maxMin;
        value = value * 11.0;
        
        x = x + value;
    }
    
    CGRect popoverRect = self.tipView.frame;
    popoverRect.origin.x = x;
    self.tipView.frame = popoverRect;

}

- (void)showPopoverAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tipView.alpha = 1.0;
        }];
    } else {
        self.tipView.alpha = 1.0;
    }
}

- (void)hidePopoverAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tipView.alpha = 0;
        }];
    } else {
        self.tipView.alpha = 0;
    }
}
- (void)setValue:(float)value
{
    [super setValue:value];
    [self updateTipViewframe];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateTipViewframe];
    [self showPopoverAnimated:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hidePopoverAnimated:YES];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hidePopoverAnimated:YES];
    [super touchesCancelled:touches withEvent:event];
}

@end
