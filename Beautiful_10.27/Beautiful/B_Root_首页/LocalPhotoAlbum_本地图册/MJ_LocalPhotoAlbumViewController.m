//
//  MJ_LocalPhotoAlbumViewController.m
//  Beautiful
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 最美的你. All rights reserved.
//  

#import "MJ_LocalPhotoAlbumViewController.h"
#import "MJ_CameraPicturesViewController.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MJ_LocalPhotoAlbumViewController ()
<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

{
    UIImagePickerController *imagePicker;
    UIImage *inputImage;
    
}

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MJ_LocalPhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTopView];
    [self getImageFromIpc];
    [self getOriginalImages];
    [self getThumbnailImages];
    
}
#pragma mark - 顶部View
- (void)createTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    // 返回
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.04, topView.bounds.size.height * 0.55, topView.bounds.size.width * 0.05, topView.bounds.size.height * 0.35) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"上一步"] color:nil addBlock:^(MJ_Button *button) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [topView addSubview:backButton];
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(topView.bounds.size.width / 2 - topView.bounds.size.width * 0.15, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.3, topView.bounds.size.height * 0.4)];
    titleLabel.text = @"选择照片";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.29 blue:0.56 alpha:1.00];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [topView addSubview:titleLabel];
    // 相机
    MJ_Button *calendarButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.88, topView.bounds.size.height * 0.48, topView.bounds.size.width * 0.07, topView.bounds.size.height * 0.42) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"相机"] color:nil addBlock:^(MJ_Button *button) {
        
        MJ_CameraPicturesViewController *cameraVC = [[MJ_CameraPicturesViewController alloc] init];
        [self.navigationController pushViewController:cameraVC animated:YES];
        
        
    }];
    [topView addSubview:calendarButton];
    
}

#pragma mark - 获取单张图片
- (void)getImageFromIpc {
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:^{
        
        
    }];
}

#pragma mark -- <UIImagePickerControllerDelegate>
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
}
#pragma mark - 获得所有相册的原图
- (void)getOriginalImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:YES];
    }
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
}
#pragma mark - 获得所有相册中的缩略图
- (void)getThumbnailImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:NO];
    }
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
}
#pragma mark - 遍历相册
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", result);
        }];
    }
}

@end
