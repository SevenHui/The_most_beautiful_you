//
//  MJ_Slider.h
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MJ_TipView : UIView

@property (nonatomic, strong) UILabel *currentValueLabel;

@end

@interface MJ_Slider : UISlider

@property (nonatomic, strong) MJ_TipView *tipView;

@end
