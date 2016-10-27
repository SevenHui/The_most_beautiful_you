//
//  MJ_ShowAutoAlbumViewController.m
//  Beautiful
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_ShowAutoAlbumViewController.h"
#import "YFShowAlbumCell.h"
#import "YFSelfImage.h"
#import "NSObject+YFPhoto.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+YF.h"
#import "MJ_CameraPicturesViewController.h"

static NSString * const SHOWCELL = @"YFShowAlbumCell";

@interface MJ_ShowAutoAlbumViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

{
    //右边的按钮
    MJ_Button *selectBtn;
}

@property(nonatomic,strong)UICollectionView *collectionView;
//所有需要显示的图片
@property(nonatomic,strong)NSMutableArray *dataArray;
//选中的图片
@property(nonatomic,strong)NSMutableArray *selectedArray;

@end

@implementation MJ_ShowAutoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];

    [self createTopView];
    
    _dataArray = [NSMutableArray array];
    _selectedArray = [NSMutableArray array];
    //多少照片
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
    [library callAllPhoto:_group result:^(YFSelfImage *image) {
        [_dataArray addObject:image];
    }];
    //加载
    [self initCollectionView];
    
}

#pragma mark - 顶部View
- (void)createTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    // 返回相册
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.04, topView.bounds.size.height * 0.45, topView.bounds.size.width * 0.07, topView.bounds.size.height * 0.45) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"相册"] color:nil addBlock:^(MJ_Button *button) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [topView addSubview:backButton];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(topView.bounds.size.width / 2 - topView.bounds.size.width * 0.1, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.2, topView.bounds.size.height * 0.4)];
    titleLabel.text = @"相册";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.29 blue:0.56 alpha:1.00];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [topView addSubview:titleLabel];
    
    // 完成选定图片
    selectBtn = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.89, backButton.frame.origin.y, backButton.frame.size.width, backButton.frame.size.height) type:UIButtonTypeCustom title:@"完成" image:nil color:nil addBlock:^(MJ_Button *button) {
        
        //把选择的图片传送过去
        NSDictionary *dic = @{@"cellImage":self.selectedArray};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushImage" object:nil userInfo:dic];
        //退出模态
        [self dismissViewControllerAnimated:YES completion:^{
            //这一步确保退出到显示界面的时候显示相册组控制器一定退出
            [self.navigationController popViewControllerAnimated:YES];
        }];

        
    }];
    selectBtn.userInteractionEnabled = NO;
    [topView addSubview:selectBtn];

}

#pragma mark - 加载九宫格
- (void)initCollectionView{
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTHSCREEN, HEIGHTSCREEN * 0.65) collectionViewLayout:[self setFlowOut]];
    _collectionView.backgroundColor = [UIColor orangeColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    if (_color) {
        _collectionView.backgroundColor = _color;
    }
    
    [_collectionView registerNib:[UINib nibWithNibName:SHOWCELL bundle:nil] forCellWithReuseIdentifier:SHOWCELL];
    [self.view addSubview:_collectionView];
}

#pragma mark - 格式
- (UICollectionViewFlowLayout *)setFlowOut{
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    NSInteger rowCount = 4;
    if (_listCount && _listCount > 0) {
        rowCount = _listCount;
    }
    layOut.itemSize = CGSizeMake(self.view.frame.size.width / rowCount, self.view.frame.size.width / rowCount);
    layOut.minimumLineSpacing = 0;
    layOut.minimumInteritemSpacing = 0;
    return layOut;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_showStyle == ENUM_Camera) {
        return self.dataArray.count + 1;
        
    }else{
        return self.dataArray.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YFShowAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SHOWCELL forIndexPath:indexPath];
    //数据
    NSInteger cellIndex;
    if (_showStyle == ENUM_Camera) {
        cellIndex = indexPath.row - 1;//如果是相机模式，那么就要改变cell与数组的显示坐标对应
    }else{
        
        cellIndex = indexPath.row;
    }
    
    cell.selectBtn.tag = cellIndex;
    //按钮选中块
    __weak typeof(self)weakSelf = self;
    cell.selectedBlock = ^(NSInteger index){
        
        //把选中的图片放倒一个数组里面
        [weakSelf.selectedArray addObject:[weakSelf.dataArray objectAtIndex:index]];
        selectBtn.userInteractionEnabled = YES;
    };
    //取消选定
    cell.cancelBlock = ^(NSInteger index){
        
        //找出取消的cell
        YFSelfImage *oldImage = [weakSelf.dataArray objectAtIndex:index];
        //从选中的数组去除
        for (YFSelfImage *newImage in weakSelf.selectedArray) {
            if (newImage == oldImage) {
                //移除
                [weakSelf.selectedArray removeObject:newImage];
                //判断完成按钮是否可以使用
                if(weakSelf.selectedArray.count <= 0){
                    
                    selectBtn.userInteractionEnabled = NO;
                }
                return ;
            }
        }
    };
    
    if (_showStyle == ENUM_Camera) {
        if (indexPath.row == 0) {
            cell.imageView.image       = [UIImage imageNamed:@"相机"];
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cell.selectBtn.hidden      = YES;
        }else{
            
            YFSelfImage *image = [_dataArray objectAtIndex:cellIndex];
            cell.imageView.image = image;
            cell.selectBtn.hidden = NO;
        }
    }else{
        
        YFSelfImage *image = [_dataArray objectAtIndex:cellIndex];
        cell.imageView.image = image;
    }
    return cell;
}

#pragma mark - 选择
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (_showStyle == ENUM_Camera && indexPath.row == 0) {
        //选择相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        // picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        //进入照相界面
        MJ_CameraPicturesViewController *cameraVC = [[MJ_CameraPicturesViewController alloc] init];
        [self.navigationController pushViewController:cameraVC animated:YES];
    }
    
}
#pragma mark  相机代理
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //图片
    UIImage *image;
    //判断是不是从相机过来的
    if (picker.sourceType != UIImagePickerControllerSourceTypePhotoLibrary) {
        //关闭相机
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    //通过判断picker的sourceType，如果是拍照则保存到相册去.非常重要的一步，不然，无法获取照相的图片
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

#pragma mark - 确定相机图片保存到系统相册后，进行图片获取
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"已保存");
    //操作获得的照片，我这是直接显示，你那个你加到你显示的一组里面去显示去就好了
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
    
    //操作获得的照片，我这是直接显示，你那个你加到你显示的一组里面去显示去就好了
    [library afterCameraAsset:^(ALAsset *asset) {
        YFSelfImage *image = [[YFSelfImage alloc]initWithCGImage:asset.thumbnail];
        image.asset = asset;
        //传递
        NSDictionary *dic = @{@"saveImage":image};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SAVEIMAGE" object:nil userInfo:dic];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    
}


@end
