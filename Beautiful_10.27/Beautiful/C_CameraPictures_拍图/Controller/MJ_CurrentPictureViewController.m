//
//  MJ_CurrentPictureViewController.m
//  Beautiful
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CurrentPictureViewController.h"
#import "MJ_CurrentPicturesCollectionViewCell.h"
// 返回相机
#import "MJ_CameraPicturesViewController.h"
// 跳到相册
#import "MJ_LocalPhotoAlbumViewController.h"
// 转到美图
#import "MJ_BeautifyPicturesViewController.h"
// 转到抠图
#import "MJ_CutoutPicturesViewController.h"

@interface MJ_CurrentPictureViewController ()
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

@end

@implementation MJ_CurrentPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self config];
    [self createTopView];
    [self createImageView];
    [self createBottomView];
    
}

- (void)config {
    // 底部图标数组
    self.iconArray = [NSArray arrayWithObjects: [UIImage imageNamed:@" "], [UIImage imageNamed:@" "], [UIImage imageNamed:@"materials_stickerset_delete_a"], [UIImage imageNamed:@"save_highlight"], nil];
    // 底部标题数组
    self.titleArray = @[@"美图", @"抠图", @"删除", @"分享"];

}
#pragma mark - 顶部View
- (void)createTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    // 返回相机
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.04, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.06, topView.bounds.size.height * 0.38) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"返回"] color:nil addBlock:^(MJ_Button *button) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [topView addSubview:backButton];
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(topView.bounds.size.width / 2 - topView.bounds.size.width * 0.15, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.3, backButton.frame.size.height)];
    titleLabel.text = @"--/--";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.29 blue:0.56 alpha:1.00];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [topView addSubview:titleLabel];
    
}
#pragma mark - 中间显示当前图片
- (void)createImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTHSCREEN, HEIGHTSCREEN - HEIGHTSCREEN * 0.13 - 64)];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.image = _image;
    [self.view addSubview:_imageView];
}
#pragma mark - 底部View
- (void)createBottomView {
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN * 0.87, WIDTHSCREEN, HEIGHTSCREEN * 0.13)];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    // 界面底部四项功能
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 8, HEIGHTSCREEN * 0.1);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 41;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 42, 10, 42);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, buttomView.frame.size.height * 0.2, WIDTHSCREEN, buttomView.frame.size.height * 0.7) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [buttomView addSubview:_collectionView];
    
    [_collectionView registerClass:[MJ_CurrentPicturesCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_CurrentPicturesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.titleLabel.text = _titleArray[indexPath.item];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 转到美图界面
    if (indexPath.item == 0) {
        MJ_BeautifyPicturesViewController *beautifyVC = [[MJ_BeautifyPicturesViewController alloc] init];
        [self.navigationController pushViewController:beautifyVC animated:YES];
    }
    // 转到抠图界面
    if (indexPath.item == 1) {
        MJ_CutoutPicturesViewController *cutoutVC = [[MJ_CutoutPicturesViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:cutoutVC];
        [self.navigationController pushViewController:navigation animated:YES];
    }
    // 是否删除
    if (indexPath.item == 2) {
        NSLog(@"是否删除当前图片");
    }
    if (indexPath.item == 3) {
        NSLog(@"分享到QQ好友orQQ空间or微信好友or朋友圈or新浪微博");
    }
}





@end
