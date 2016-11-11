//
//  PEResizeControl.h
//  PhotoCropEditor
//
//  Created by kishikawa katsumi on 2013/05/19.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//  拖动视图的调整

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol PEResizeControlViewDelegate;

@interface PEResizeControl : UIView

@property (nonatomic, assign) id<PEResizeControlViewDelegate> delegate;
@property (nonatomic, readonly, assign) CGPoint translation;

@end

@protocol PEResizeControlViewDelegate <NSObject>

// 开始调整
- (void)resizeControlViewDidBeginResizing:(PEResizeControl *)resizeControlView;
// 调整
- (void)resizeControlViewDidResize:(PEResizeControl *)resizeControlView;
// 结束调整
- (void)resizeControlViewDidEndResizing:(PEResizeControl *)resizeControlView;

@end
