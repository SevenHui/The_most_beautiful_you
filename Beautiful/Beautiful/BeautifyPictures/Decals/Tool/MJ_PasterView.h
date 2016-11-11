//
//  MJ_PasterView.h
//  Beautiful
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_BaseView.h"
#import "MJ_PasterStageView.h"

@class MJ_PasterView;

@protocol MJ_PasterViewDelegate <NSObject>
// 切换控制正在操作哪一张贴纸
- (void)makePasterBecomeFirstRespond:(int)pasterID;
// 删除某张
- (void)removePaster:(int)pasterID;

@end

@interface MJ_PasterView : UIView

@property (nonatomic, strong) UIImage *imagePaster;
@property (nonatomic, assign) int pasterID;
// 是否正在操作
@property (nonatomic, assign) BOOL isOnFirst;


@property (nonatomic, assign) id<MJ_PasterViewDelegate> delegate;

- (instancetype)initWithBgView:(MJ_PasterStageView *)bgView
                      pasterID:(int)pasterID
                           img:(UIImage *)img;
- (void)remove;

@end
