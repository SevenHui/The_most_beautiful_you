//
//  MJ_DecalsViewController.m
//  Beautiful
//
//  Created by apple on 16/11/4.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_DecalsViewController.h"
#import "MJ_PasterStageView.h"
#import "MJ_PasterView.h"
#import "MJ_DecalsCollectionViewCell.h"

@interface MJ_DecalsViewController ()
<
UIScrollViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, strong) UIScrollView *scrollPaster;
@property (nonatomic, strong) MJ_PasterStageView *stageView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MJ_DecalsViewController

- (void)config {
    self.array = [NSMutableArray array];
    for (int i = 0; i < 30; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
        [_array addObject:image];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createNavigationItem];
    [self config];
    [self setup];
    [self createCollrctionView];
    
}

- (void)createNavigationItem {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    
}

- (void)cancel:(id)sender {
    self.navigationController.toolbar.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)done:(id)sender {
    self.navigationController.toolbar.hidden = YES;
    UIImage *imageResult = [_stageView doneEdit];
    [self.delegate didAddFinished:imageResult];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)setup {
    CGRect rectImage = CGRectZero;
    CGFloat sideFlex = 10.0f;
    CGFloat length = WIDTHSCREEN - sideFlex * 2;
    CGFloat y = (HEIGHTSCREEN - HEIGHTSCREEN * 0.25 - length - 64);
    rectImage.size = CGSizeMake(length, length);
    rectImage.origin.x = sideFlex;
    rectImage.origin.y = y;
    
    self.stageView = [[MJ_PasterStageView alloc] initWithFrame:rectImage];
    _stageView.backgroundColor = [UIColor clearColor];
    // 需要被贴纸加工的图片
    _stageView.originImage = self.image;
    [self.view addSubview:_stageView];
    
}

- (void)createCollrctionView {
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN * 0.75, WIDTHSCREEN, HEIGHTSCREEN * 0.17)];
    buttomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:buttomView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 7, HEIGHTSCREEN * 0.1);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:buttomView.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = YES;
    _collectionView.pagingEnabled = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [buttomView addSubview:_collectionView];
    
    [_collectionView registerClass:[MJ_DecalsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DecalsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.image = _array[indexPath.item];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *image = _array[indexPath.item];
    [_stageView addPasterWithImg:image];
    
}

@end
