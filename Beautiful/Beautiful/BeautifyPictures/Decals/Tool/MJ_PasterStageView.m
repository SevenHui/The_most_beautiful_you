//
//  MJ_PasterStageView.m
//  Beautiful
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_PasterStageView.h"
#import "MJ_PasterView.h"
#import "UIImage+AddFunction.h"

@interface MJ_PasterStageView ()
<MJ_PasterViewDelegate>
{
    CGPoint         startPoint;
    CGPoint         touchPoint;
    NSMutableArray  *m_listPaster;
}

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) MJ_PasterView *pasterCurrent;
@property (nonatomic, assign) int newPasterID;

@end

@implementation MJ_PasterStageView

- (void)setOriginImage:(UIImage *)originImage {
    if (_originImage != originImage) {
        _originImage = originImage;
    }
    
    self.imgView.image = originImage;
    
}

- (int)newPasterID {
    _newPasterID++;
    
    return _newPasterID;
}

- (void)setPasterCurrent:(MJ_PasterView *)pasterCurrent {
    _pasterCurrent = pasterCurrent;
    
    [self bringSubviewToFront:_pasterCurrent];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        CGRect rect = CGRectZero;
        rect.size.width = self.frame.size.width;
        rect.size.height = self.frame.size.width;
        rect.origin.y = ( self.frame.size.height - self.frame.size.width ) / 2.0;
        _imgView = [[UIImageView alloc] initWithFrame:rect];
        _imgView.contentMode = UIViewContentModeScaleToFill;
        
        if (![_imgView superview]) {
            [self addSubview:_imgView];
        }
    }
    
    return _imgView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        m_listPaster = [[NSMutableArray alloc] initWithCapacity:1];
        [self imgView];
        
    }
    
    return self;
}

- (void)addPasterWithImg:(UIImage *)imgP {
    [self clearAllOnFirst];
    self.pasterCurrent = [[MJ_PasterView alloc] initWithBgView:self pasterID:self.newPasterID img:imgP];
    _pasterCurrent.delegate = self;
    [m_listPaster addObject:_pasterCurrent];
}

- (UIImage *)doneEdit {
    [self clearAllOnFirst];
    
    CGFloat org_width = self.originImage.size.width;
    CGFloat org_heigh = self.originImage.size.height;
    CGFloat rateOfScreen = org_width / org_heigh;
    CGFloat inScreenH = self.frame.size.width / rateOfScreen;
    
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(WIDTHSCREEN, inScreenH);
    rect.origin = CGPointMake(0, (self.frame.size.height - inScreenH) / 2);
    
    UIImage *imgTemp = [UIImage getImageFromView:self];
    
    UIImage *imgCut = [UIImage squareImageFromImage:imgTemp scaledToSize:rect.size.width];
    
    return imgCut;
}


- (void)backgroundClicked:(UIButton *)btBg {
    [self clearAllOnFirst];
}

- (void)clearAllOnFirst {
    _pasterCurrent.isOnFirst = NO;
    
    [m_listPaster enumerateObjectsUsingBlock:^(MJ_PasterView *pasterV, NSUInteger idx, BOOL * _Nonnull stop) {
        pasterV.isOnFirst = NO;
    }];
}

#pragma mark - PasterViewDelegate
- (void)makePasterBecomeFirstRespond:(int)pasterID {
    [m_listPaster enumerateObjectsUsingBlock:^(MJ_PasterView *pasterV, NSUInteger idx, BOOL * _Nonnull stop) {
        
        pasterV.isOnFirst = NO;
        
        if (pasterV.pasterID == pasterID) {
            self.pasterCurrent = pasterV;
            pasterV.isOnFirst = YES;
        }
        
    }];
}

- (void)removePaster:(int)pasterID {
    [m_listPaster enumerateObjectsUsingBlock:^(MJ_PasterView *pasterV, NSUInteger idx, BOOL * _Nonnull stop) {
        if (pasterV.pasterID == pasterID) {
            [m_listPaster removeObjectAtIndex:idx];
            *stop = YES;
        }
    }];
}

@end
