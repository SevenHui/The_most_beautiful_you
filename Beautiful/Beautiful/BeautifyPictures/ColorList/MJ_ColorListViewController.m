//
//  MJ_ColorListViewController.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_ColorListViewController.h"
#import "MJ_DataManager.h"
#import "MJ_ApplyFilter.h"

@interface MJ_ColorListViewController ()

@property (nonatomic, strong) MJ_EffectBar *styleBar;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *imageOfCurrent;
@property (nonatomic, strong) MJ_Slider *slider;

@property NSInteger selectedIndex;

@end

@implementation MJ_ColorListViewController

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedIndex = 0;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createNavigationItem];
    [self createImageView];
    [self createButtom];
    [self setupSlider];
    
    
}

- (void)createNavigationItem {
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    
}
- (void)cancel:(id)sender {
    self.navigationController.toolbar.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)done:(id)sender {
    self.navigationController.toolbar.hidden = YES;
    if (self.block) {
        self.block(_imageOfCurrent);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)createImageView {
    self.imageView = [[UIImageView alloc] initWithImage:_image];
    _imageView.frame = CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 115);
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:_imageView];

}

- (void)createButtom {
    self.styleBar = [[MJ_EffectBar alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN - 105, WIDTHSCREEN, 30)];
    
    NSDictionary *autoDict = [[MJ_DataManager getDataSourceFromPlist] objectForKey:@"ColorList"];
    NSArray *normalImageArr = [autoDict objectForKey:@"normalImages"];
    NSArray *hightlightedImageArr = [autoDict objectForKey:@"HighlightedImages"];
    NSArray *textArr = [autoDict objectForKey:@"Texts"];
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < [textArr count]; i++)
    {
        MJ_EffectBarItem *item = [[MJ_EffectBarItem alloc] initWithFrame:CGRectZero];
        [item setFinishedSelectedImage:[UIImage imageNamed:[hightlightedImageArr objectAtIndex:i]] withFinishedUnselectedImage:[UIImage imageNamed:[normalImageArr objectAtIndex:i]] ];
        item.title = [textArr objectAtIndex:i];
        [items addObject:item];
    }
    self.styleBar.items = items;
    self.styleBar.delegate = self;
    [self.styleBar setSelectedItem:[self.styleBar.items objectAtIndex:0]];
    [self effectBar:self.styleBar didSelectItemAtIndex:0];
    [self.view addSubview:self.styleBar];

}

- (void)setupSlider {
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN - 115 - 40, WIDTHSCREEN, 40)];
    subview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:subview];
    
    self.slider = [[MJ_Slider alloc] initWithFrame:CGRectZero];
    self.slider.minimumValue = -0.5;
    self.slider.maximumValue = 0.5;
    self.slider.value = 0;
    self.slider.frame = CGRectMake(WIDTHSCREEN / 2 - 100, 10, 200, 20);
    [self.slider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventTouchUpInside];
    [self.slider addTarget:self action:@selector(updateTipView:) forControlEvents:UIControlEventValueChanged];
    [self.slider setThumbImage:[UIImage imageNamed:@"icon_slider_thumb"] forState:UIControlStateNormal];
    
    [subview addSubview:self.slider];
    self.slider.tipView.currentValueLabel.text = [NSString stringWithFormat:@"%f",self.slider.value];
    
}

#pragma mark - FWEffectBarDelegate
- (void)effectBar:(MJ_EffectBar *)bar didSelectItemAtIndex:(NSInteger)index {
    self.selectedIndex = index;
    switch (index) {
        case 0:
            self.slider.minimumValue = -.5;
            self.slider.maximumValue = 0.5;
            self.slider.value = 0.0;
            break;
            
        case 1:
            self.slider.minimumValue = 0.1;
            self.slider.maximumValue = 1.9;
            self.slider.value = 1.0;
            
            break;
            
        case 2:
            self.slider.minimumValue = 1000;
            self.slider.maximumValue = 10000;
            self.slider.value = 5000;
            
            break;
            
        case 3:
            self.slider.minimumValue = 0.0;
            self.slider.maximumValue = 2.0;
            self.slider.value = 1.0;
            break;
            
        case 4:
            self.slider.minimumValue = 0.0;
            self.slider.maximumValue = 1.0;
            self.slider.value = 0.5;
            break;
            
        case 5:
            self.slider.minimumValue = 0.0;
            self.slider.maximumValue = 1.0;
            self.slider.value = 0.5;
            break;
            
        case 6:
            self.slider.minimumValue = -1;
            self.slider.maximumValue = 1;
            self.slider.value = 0;
            break;
            
        default:
            break;
    }
}

- (void)updateTipView:(id)sender {
        MJ_TipView *tip = [[MJ_TipView alloc] initWithFrame:CGRectMake(100, self.slider.superview.frame.origin.y - 25, 28, 25)];
        [self.view addSubview:tip];
    self.slider.tipView.currentValueLabel.text = [NSString stringWithFormat:@"%f",self.slider.value];
}

- (void)updateValue:(id)sender {
    switch (self.selectedIndex) {
        case 0:
            self.imageOfCurrent = [MJ_ApplyFilter changeValueForBrightnessFilter:self.slider.value image:self.image];
            break;
            
        case 1:
            self.imageOfCurrent = [MJ_ApplyFilter changeValueForContrastFilter:self.slider.value image:self.image];
            self.imageView.image =   self.imageOfCurrent;
            break;
            
        case 2:
            self.imageOfCurrent = [MJ_ApplyFilter changeValueForWhiteBalanceFilter:self.slider.value image:self.image];
            break;
            
        case 3:
            self.imageOfCurrent = [MJ_ApplyFilter changeValueForSaturationFilter:self.slider.value image:self.image];
            break;
            
        case 4:
            self.imageOfCurrent = [MJ_ApplyFilter changeValueForHightlightFilter:self.slider.value image:self.image];
            break;
            
        case 5:
            self.imageOfCurrent = [MJ_ApplyFilter changeValueForLowlightFilter:self.slider.value image:self.image];
            break;
            
        case 6:
            self.imageOfCurrent = [MJ_ApplyFilter changeValueForExposureFilter:self.slider.value image:self.image];
            break;
            
        default:
            break;
    }
    
    self.imageView.image = self.imageOfCurrent;
}



@end
