//
//  MJ_RootViewController.m
//  Beautiful
//
//  Created by apple on 16/10/19.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_RootViewController.h"
#import "MJ_RootCollectionViewCell.h"
#import "MJ_CameraPhotoViewController.h"
#import "MJ_CameraVideoViewController.h"
#import "MJ_BeautifyPicturesViewController.h"
#import "MJ_TimeshaftViewController.h"

@interface MJ_RootViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, strong) UICollectionView *RootCollectionView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation MJ_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
    [self createRootCollectionView];
    [self createCameraButton];
    
    
}
- (void)config {
    self.titleArray = @[@"时光轴", @"美化图片", @"拼图", @"相册"];
    // 背景图片
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundImageView.backgroundColor = [UIColor colorWithRed:0.94 green:0.64 blue:0.69 alpha:1.00];
    [self.view addSubview:backgroundImageView];
    
}
#pragma mark - 首页四项功能
- (void)createRootCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 5, HEIGHTSCREEN * 0.17);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 16;
    flowLayout.sectionInset = UIEdgeInsetsMake(8, 16, 8, 16);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.RootCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN * 0.5, WIDTHSCREEN, HEIGHTSCREEN * 0.17) collectionViewLayout:flowLayout];
    _RootCollectionView.backgroundColor = [UIColor clearColor];
    _RootCollectionView.dataSource = self;
    _RootCollectionView.delegate = self;
    _RootCollectionView.scrollEnabled = NO;
    _RootCollectionView.pagingEnabled = YES;
    _RootCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_RootCollectionView];
    
    [_RootCollectionView registerClass:[MJ_RootCollectionViewCell class] forCellWithReuseIdentifier:@"RootCollectionView"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_RootCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RootCollectionView" forIndexPath:indexPath];
    
//    cell.backgroundColor = COLOR;
    cell.titleLabel.text = _titleArray[indexPath.item];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
    MJ_BeautifyPicturesViewController *beautifyPicturesVc = [[MJ_BeautifyPicturesViewController alloc] init];
    
    [self.navigationController pushViewController:beautifyPicturesVc animated:YES];
    
}
#pragma mark - 拍照片 & 拍视频
- (void)createCameraButton {
    // 拍照片
    UIButton *cameraPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraPhoto.frame = CGRectMake(WIDTHSCREEN * 0.16, HEIGHTSCREEN * 0.7, WIDTHSCREEN / 5, HEIGHTSCREEN * 0.17);
//    cameraPhoto.backgroundColor = COLOR;
    [self.view addSubview:cameraPhoto];
    
    UIImageView *imageCameraPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cameraPhoto.bounds.size.width, cameraPhoto.bounds.size.width)];
    imageCameraPhoto.backgroundColor = [UIColor redColor];
    imageCameraPhoto.layer.cornerRadius = cameraPhoto.bounds.size.width / 2;
    [cameraPhoto addSubview:imageCameraPhoto];
    
    UILabel *labelCameraPhoto = [[UILabel alloc] initWithFrame:CGRectMake(0, cameraPhoto.bounds.size.width, cameraPhoto.bounds.size.width, cameraPhoto.bounds.size.height - cameraPhoto.bounds.size.width)];
//    labelCameraPhoto.backgroundColor = [UIColor yellowColor];
    labelCameraPhoto.text = @"拍照片";
    labelCameraPhoto.textColor = [UIColor colorWithRed:0.91 green:0.29 blue:0.56 alpha:1.00];
    labelCameraPhoto.textAlignment = NSTextAlignmentCenter;
    [cameraPhoto addSubview:labelCameraPhoto];
    
    [cameraPhoto addTarget:self action:@selector(cameraPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 拍视频
    UIButton *cameraVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraVideo.frame = CGRectMake(WIDTHSCREEN * 0.63, HEIGHTSCREEN * 0.7, WIDTHSCREEN / 5, HEIGHTSCREEN * 0.17);
//    cameraVideo.backgroundColor = COLOR;

    UIImageView *imageCameraVideo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cameraVideo.bounds.size.width, cameraVideo.bounds.size.width)];
    imageCameraVideo.backgroundColor = [UIColor redColor];
    imageCameraVideo.layer.cornerRadius = cameraVideo.bounds.size.width / 2;
    [cameraVideo addSubview:imageCameraVideo];
    
    UILabel *labelCameraVideo = [[UILabel alloc] initWithFrame:CGRectMake(0, cameraVideo.bounds.size.width, cameraVideo.bounds.size.width, cameraVideo.bounds.size.height - cameraVideo.bounds.size.width)];
//    labelCameraVideo.backgroundColor = [UIColor yellowColor];
    labelCameraVideo.text = @"拍视频";
    labelCameraVideo.textColor = [UIColor colorWithRed:0.91 green:0.29 blue:0.56 alpha:1.00];
    labelCameraVideo.textAlignment = NSTextAlignmentCenter;
    [cameraVideo addSubview:labelCameraVideo];
    [self.view addSubview:cameraVideo];
    [cameraVideo addTarget:self action:@selector(cameraVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 拍照片点击事件
- (void)cameraPhotoAction:(UIButton *)cameraPhoto {
    
    MJ_CameraPhotoViewController *cameraPhotoVc = [[MJ_CameraPhotoViewController alloc] init];
    
    [self.navigationController pushViewController:cameraPhotoVc animated:YES];
    
}
#pragma mark - 拍视频点击事件
- (void)cameraVideoAction:(UIButton *)cameraVideo {
    
    MJ_CameraVideoViewController *cameraVideoVc = [[MJ_CameraVideoViewController alloc] init];
    
    [self.navigationController pushViewController:cameraVideoVc animated:YES];
    
}

@end
