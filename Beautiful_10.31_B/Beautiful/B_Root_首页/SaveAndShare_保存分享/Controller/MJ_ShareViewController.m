//
//  MJ_ShareViewController.m
//  Beautiful
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_ShareViewController.h"
#import "MJ_ShareCollectionViewCell.h"

@interface MJ_ShareViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

/**分享*/
@property (nonatomic, strong) UICollectionView *collectionView;
/**分享图标*/
@property (nonatomic, strong) NSArray *imagesArray;

@end

@implementation MJ_ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self config];
    [self createTopView];
    [self createView];
    [self createButtomView];

}
- (void)config {
    self.imagesArray = [NSArray arrayWithObjects: [UIImage imageNamed:@"share_moments_normal"], [UIImage imageNamed:@"share_wechat_normal"], [UIImage imageNamed:@"share_qzone_normal"], [UIImage imageNamed:@"share_qq_normal"], nil];
    
}

#pragma mark - 顶部View
- (void)createTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    // 返回按钮
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.04, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.06, topView.bounds.size.height * 0.38) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"返回"] color:nil addBlock:^(MJ_Button *button) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [topView addSubview:backButton];

    
}
#pragma mark - 保存View
- (void)createView {
    // 已保存
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTHSCREEN / 2 - WIDTHSCREEN * 0.08, HEIGHTSCREEN * 0.18, WIDTHSCREEN * 0.16, WIDTHSCREEN * 0.16)];
    imageView.image = [UIImage imageNamed:@"share_done"];
    [self.view addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTHSCREEN / 2 - WIDTHSCREEN * 0.08, HEIGHTSCREEN * 0.28, WIDTHSCREEN * 0.16, HEIGHTSCREEN * 0.05)];
    label.text = @"已保存";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    // 回首页
    MJ_Button *backRootButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN / 2 - WIDTHSCREEN * 0.15, HEIGHTSCREEN * 0.4, WIDTHSCREEN * 0.3, HEIGHTSCREEN * 0.06) type:UIButtonTypeCustom title:@"回首页" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    backRootButton.backgroundColor = [UIColor colorWithRed:0.94 green:0.64 blue:0.69 alpha:1.00];
    backRootButton.layer.cornerRadius = 18;
    [self.view addSubview:backRootButton];
    
    // 进入美图
    MJ_Button *goShareButton = [MJ_Button buttonWithFrame:CGRectMake(WIDTHSCREEN / 2 - WIDTHSCREEN * 0.15, HEIGHTSCREEN * 0.48, WIDTHSCREEN * 0.3, HEIGHTSCREEN * 0.06) type:UIButtonTypeCustom title:@"进入美图" image:nil color:[UIColor whiteColor] addBlock:^(MJ_Button *button) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    goShareButton.backgroundColor = [UIColor colorWithRed:0.94 green:0.64 blue:0.69 alpha:1.00];
    goShareButton.layer.cornerRadius = 18;
    [self.view addSubview:goShareButton];

    
}
#pragma mark - 分享View
- (void)createButtomView {
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN * 0.62, WIDTHSCREEN, HEIGHTSCREEN * 0.04)];
    shareLabel.text = @"━━━━━━━ 分享 ━━━━━━━";
    shareLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:shareLabel];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 8, HEIGHTSCREEN * 0.07);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 41;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 42, 10, 42);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * 0.71, WIDTHSCREEN, self.view.frame.size.height * 0.1) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = YES;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[MJ_ShareCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_ShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.image = _imagesArray[indexPath.item];

    return cell;
}



@end
