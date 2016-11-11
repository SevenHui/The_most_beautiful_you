//
//  MJ_FilterViewController.m
//  Beautiful
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_FilterViewController.h"
#import "MJ_FilterCollectionViewCell.h"
#import "MJ_ApplyFilter.h"

static NSMutableDictionary *filenameDic;

@interface MJ_FilterViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) GPUImagePicture *stillImageSource;

@end

@implementation MJ_FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    self.array = @[@"原图", @"LOMO", @"怀旧", @"酒红", @"淡雅", @"锐化", @"哥特", @"清宁", @"浪漫", @"光晕", @"蓝调", @"梦幻"];
    
    [self createNavigationItem];
    [self createImageView];
    [self creatCollectionView];
    
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
    [self.delegate calendarImage:_currentImageView.image];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)createImageView {
    self.imageView = [[UIImageView alloc] initWithImage:_image];
    _imageView.frame = CGRectMake(0, 0, WIDTHSCREEN, HEIGHTSCREEN - 64 - HEIGHTSCREEN * 0.25);
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    self.currentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _currentImageView.frame = _imageView.frame;
    [_imageView addSubview:_currentImageView];

    
}

- (void)creatCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 5, HEIGHTSCREEN * 0.05);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN * 0.75 - 64, WIDTHSCREEN, HEIGHTSCREEN * 0.25) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    //    水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 40, 20, 40);
    
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //    隐藏滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    //    关闭回弹效果
    _collectionView.bounces = NO;
    
    [_collectionView registerClass:[MJ_FilterCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.text = _array[indexPath.item];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *imageResult = [self effectImage:indexPath.item withImage:_imageView.image];
    _currentImageView.image = imageResult;
    
    
}

// @"原图", @"LOMO", @"怀旧", @"酒红", @"淡雅", @"锐化", @"哥特", @"清宁", @"浪漫", @"光晕", @"蓝调", @"梦幻"
- (UIImage *)effectImage:(long)filter withImage:(UIImage*)image {
    UIImage *imageResult = nil;
    switch (filter) {
        case 0:
            imageResult = image;
            break;
        case 1:
            imageResult = [MJ_ApplyFilter applyLomofiFilter:image];
            break;
        case 2:
            imageResult = [MJ_ApplyFilter applyEarlybirdFilter:image];
            break;
        case 3:
            imageResult = [MJ_ApplyFilter applyLordKelvinFilter:image];
            break;
        case 4:
            imageResult = [MJ_ApplyFilter applyBrannanFilter:image];
            break;
        case 5:
            imageResult = [MJ_ApplyFilter applyValenciaFilter:image];
            break;
        case 6:
            imageResult = [MJ_ApplyFilter applySutroFilter:image];
            break;
        case 7:
            imageResult = [MJ_ApplyFilter applyHudsonFilter:image];
            break;
        case 8:
            imageResult = [MJ_ApplyFilter applyAmaroFilter:image];
            break;
        case 9:
            imageResult = [MJ_ApplyFilter applyToasterFilter:image];
            break;
        case 10:
            imageResult = [MJ_ApplyFilter applyWaldenFilter:image];
            break;
        case 11:
            imageResult = [MJ_ApplyFilter applyXproIIFilter:image];
            break;
    
        default:
        {
            imageResult = image;
            break;
        }
    }
    NSLog(@"imageResult: %@", imageResult);
    return imageResult;

}


@end
