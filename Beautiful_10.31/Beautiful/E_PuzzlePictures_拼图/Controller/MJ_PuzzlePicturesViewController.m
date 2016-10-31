//
//  MJ_PuzzlePicturesViewController.m
//  Beautiful
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_PuzzlePicturesViewController.h"
#import "JFImagePickerController.h"

@interface MJ_PuzzlePicturesViewController ()
<
JFImagePickerDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) NSMutableArray *photosArray;
@property (nonatomic, strong) UICollectionView *photosList;

@end


@implementation MJ_PuzzlePicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;

    self.photosArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 3;
    NSInteger size = [UIScreen mainScreen].bounds.size.width / 4 - 1;
    if (size % 2 != 0) {
        size -= 1;
    }
    NSLog(@"size = %ld", size);
    flowLayout.itemSize = CGSizeMake(size, size);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.photosList = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _photosList.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    _photosList.scrollIndicatorInsets = _photosList.contentInset;
    _photosList.delegate = self;
    _photosList.dataSource = self;
    _photosList.backgroundColor = [UIColor whiteColor];
    _photosList.alwaysBounceVertical = YES;
    [self.view addSubview:_photosList];
    [_photosList registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"imagePickerCell"];

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photosArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagePickerCell" forIndexPath:indexPath];
    ALAsset *asset = _photosArray[indexPath.row];
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:1];
    if (!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.bounds];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = 1;
        [cell addSubview:imgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(preview:)];
        [cell addGestureRecognizer:tap];
    }
    cell.tag = indexPath.item;
    [[JFImageManager sharedManager] thumbWithAsset:asset resultHandler:^(UIImage *result) {
        if (cell.tag==indexPath.item) {
            imgView.image = result;
        }
    }];
    return cell;
    
}
- (void)preview:(UITapGestureRecognizer *)tap{
    UIView *temp = tap.view;
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithPreviewIndex:temp.tag];
    picker.pickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)pickPhotos{
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:nil];
    picker.pickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - ImagePicker Delegate
- (void)imagePickerDidFinished:(JFImagePickerController *)picker{
    [_photosArray removeAllObjects];
    [_photosArray addObjectsFromArray:picker.assets];
    [_photosList reloadData];
    [self imagePickerDidCancel:picker];
}

- (void)imagePickerDidCancel:(JFImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
















@end
