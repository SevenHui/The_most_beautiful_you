//
//  MJ_PasterStageView.h
//  Beautiful
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 最美的你. All rights reserved.
//  画布View, 用来放需要被加工的图片, 用来管理贴纸, 贴纸的新增和删除, 保存退出等

#import "MJ_BaseView.h"

@interface MJ_PasterStageView : MJ_BaseView
// 原图
@property (nonatomic,strong) UIImage *originImage;

- (instancetype)initWithFrame:(CGRect)frame;
// 加贴纸
- (void)addPasterWithImg:(UIImage *)imgP;
// 完成保存
- (UIImage *)doneEdit;

@end
