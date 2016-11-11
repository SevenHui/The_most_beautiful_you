//
//  MJ_AutoBeautiyViewController.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/10/31.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_AutoBeautiyViewController.h"
#import "MJ_DataManager.h"
#import "MJ_ApplyFilter.h"

@interface MJ_AutoBeautiyViewController ()
<MJ_EffectBarDelegate>

@property (nonatomic, strong) MJ_EffectBar *styleBar;
@property (nonatomic, strong) UIButton *buttonOfClose;
@property (nonatomic, strong) UIButton *buttonOfSave;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *imageOfCurrent;
@property (nonatomic, strong) MJ_Slider *slider;

@end

@implementation MJ_AutoBeautiyViewController

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createNavigationItem];
    [self createImageView];
    [self createButtom];
    
    
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
    
    NSDictionary *autoDict = [[MJ_DataManager getDataSourceFromPlist] objectForKey:@"AutoBeauty"];
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

#pragma mark - FWEffectBarDelegate
- (void)effectBar:(MJ_EffectBar *)bar didSelectItemAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            self.imageView.image = self.image;
            break;
        case 1:
            self.imageOfCurrent = [MJ_ApplyFilter autoBeautyFilter:self.image];
            self.imageView.image = self.imageOfCurrent;
            break;
        case 2:
            self.imageOfCurrent = [MJ_ApplyFilter applyRiseFilter:self.image];
            self.imageView.image = self.imageOfCurrent;
            break;
        case 3:
            self.imageOfCurrent = [MJ_ApplyFilter applyAmatorkaFilter:self.image];
            self.imageView.image = self.imageOfCurrent;
            break;
        case 4:
            self.imageOfCurrent = [MJ_ApplyFilter applyMissetikateFilter:self.image];
            self.imageView.image = self.imageOfCurrent;
            break;
        case 5:
            self.imageOfCurrent = [MJ_ApplyFilter applyHudsonFilter:self.image];
            self.imageView.image = self.imageOfCurrent;
            break;
        case 6:
            self.imageOfCurrent = [MJ_ApplyFilter applyNashvilleFilter:self.image];
            self.imageView.image = self.imageOfCurrent;
            break;
            
        default:
            break;
    }
   
}


@end
