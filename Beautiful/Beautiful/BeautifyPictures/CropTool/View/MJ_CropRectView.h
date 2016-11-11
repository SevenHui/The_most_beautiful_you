//
//  MJ_CropRectView.h
//  Beautiful
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_BaseView.h"

@protocol MJ_CropRectViewDelegate;

@interface MJ_CropRectView : MJ_BaseView

@property (nonatomic, assign) id<MJ_CropRectViewDelegate> delegate;

@property (nonatomic, assign) BOOL showsGridMajor;
@property (nonatomic, assign) BOOL showsGridMinor;
@property (nonatomic, assign) BOOL keepingAspectRatio;

@end

@protocol MJ_CropRectViewDelegate <NSObject>
// 开始编辑
- (void)cropRectViewDidBeginEditing:(MJ_CropRectView *)cropRectView;
// 编辑中
- (void)cropRectViewEditingChanged:(MJ_CropRectView *)cropRectView;
// 结束编辑
- (void)cropRectViewDidEndEditing:(MJ_CropRectView *)cropRectView;

@end
