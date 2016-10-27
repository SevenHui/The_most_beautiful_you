//
//  MJ_BeautifyPicturesViewController.m
//  Beautiful
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_BeautifyPicturesViewController.h"
#import "MJ_CurrentPicturesCollectionViewCell.h"
#import "MJ_ShareViewController.h"

@interface MJ_BeautifyPicturesViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

/**中间显示的当前图片*/
@property (nonatomic, strong) UIImageView *imageView;
/**界面底部四项功能*/
@property (nonatomic, strong) UICollectionView *collectionView;
/**界面底部图标数组和标题数组*/
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *titleArray;
/**撤销*/
@property (nonatomic, strong) UIButton *cancelButton;
/**前进*/
@property (nonatomic, strong) UIButton *advanceButton;

@property (nonatomic, assign) BOOL isChange;

@end

@implementation MJ_BeautifyPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.isChange = YES;
//    self.view.backgroundColor = [UIColor whiteColor];
    [self config];
    [self createTopView];
    [self createImageView];
    [self createBottomView];
    
}
- (void)config {
    // 底部标题数组
    self.titleArray = @[@"智能优化", @"编辑", @"调节", @"特效", @"文字", @"马赛克", @"背景虚化"];

}
#pragma mark - 顶部View
- (void)createTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    // 返回按钮
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.04, topView.bounds.size.height * 0.45, topView.bounds.size.width * 0.07, topView.bounds.size.height * 0.45) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"左箭头2"] color:nil addBlock:^(MJ_Button *button) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [topView addSubview:backButton];
    
    // 撤销/前进
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(topView.frame.size.width * 0.4, backButton.frame.origin.y, backButton.frame.size.width, backButton.frame.size.height);
    [_cancelButton setImage:[UIImage imageNamed:@"撤销"] forState:UIControlStateNormal];
    [topView addSubview:_cancelButton];
    [_cancelButton addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.advanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _advanceButton.frame = CGRectMake(_cancelButton.frame.size.width * 2 + _cancelButton.frame.origin.x, _cancelButton.frame.origin.y, _cancelButton.frame.size.width, _cancelButton.frame.size.height);
    [_advanceButton setImage:[UIImage imageNamed:@"前进"] forState:UIControlStateNormal];
    [topView addSubview:_advanceButton];
    [_advanceButton addTarget:self action:@selector(advanceButton:) forControlEvents:UIControlEventTouchUpInside];
    // 保存/分享
    MJ_Button *calendarButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.89, backButton.frame.origin.y, backButton.frame.size.width, backButton.frame.size.height) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"右箭头2"] color:nil addBlock:^(MJ_Button *button) {
        
        MJ_ShareViewController *shareVC = [[MJ_ShareViewController alloc] init];
        [self.navigationController pushViewController:shareVC animated:YES];
        
    }];
    [topView addSubview:calendarButton];
    
}
- (void)cancelButton:(UIButton *)cancelButton {
    if (_isChange == YES) {
        _isChange = NO;
        [cancelButton setImage:[UIImage imageNamed:@"撤销+1"] forState:UIControlStateNormal];
        
    } else if (_isChange == NO) {
        _isChange = YES;
        [cancelButton setImage:[UIImage imageNamed:@"撤销"] forState:UIControlStateNormal];
    }
    
}
- (void)advanceButton:(UIButton *)advanceButton {
    if (_isChange == YES) {
        _isChange = NO;
        [advanceButton setImage:[UIImage imageNamed:@"前进+1"] forState:UIControlStateNormal];
    } else if (_isChange == NO) {
        _isChange = YES;
        [advanceButton setImage:[UIImage imageNamed:@"前进"] forState:UIControlStateNormal];
    }
}

#pragma mark - 中间显示当前图片
- (void)createImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTHSCREEN, HEIGHTSCREEN - HEIGHTSCREEN * 0.08 - 64)];
    _imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageView];
}

#pragma mark - 底部View
- (void)createBottomView {
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN * 0.75, WIDTHSCREEN, HEIGHTSCREEN * 0.25)];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    // 界面底部四项功能
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 7, HEIGHTSCREEN * 0.1);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 25;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, buttomView.frame.size.height * 0.3, WIDTHSCREEN, buttomView.frame.size.height * 0.4) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = YES;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = YES;
    [buttomView addSubview:_collectionView];
    
    [_collectionView registerClass:[MJ_CurrentPicturesCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_CurrentPicturesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.titleLabel.text = _titleArray[indexPath.item];
    cell.titleLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}



@end
