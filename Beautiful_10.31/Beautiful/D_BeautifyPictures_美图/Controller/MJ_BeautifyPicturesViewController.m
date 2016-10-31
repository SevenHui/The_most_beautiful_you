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
#import "MJ_CameraPicturesViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "PECropViewController.h"
#import <Photos/Photos.h>

typedef void(^MJ_BeautifyPicturesViewControllerBlock)(UIImage *img);

#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)
@interface MJ_BeautifyPicturesViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
PECropViewControllerDelegate
>

/**中间显示的当前图片*/
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *imageViewOfCrop;
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

@property (nonatomic, assign) NSInteger clickOfNumber;

@property (nonatomic, copy)MJ_BeautifyPicturesViewControllerBlock block;

@end

@implementation MJ_BeautifyPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageViewOfCrop = [[UIImageView alloc] init];
    
    self.isChange = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
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
    
    if (_cancelButton){
        self.clickOfNumber = 1;
    }
    if (_advanceButton) {
        self.clickOfNumber = 10;
    }
    
    // 保存/分享
    MJ_Button *calendarButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.89, backButton.frame.origin.y, backButton.frame.size.width, backButton.frame.size.height) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"右箭头2"] color:nil addBlock:^(MJ_Button *button) {
       
        /**
         *  将图片保存到iPhone本地相册
         *  UIImage *image            图片对象
         *  id completionTarget       响应方法对象
         *  SEL completionSelector    方法
         *  void *contextInfo         任意指针，会传递到selector定义的方法上。
         */
        
        if (self.imageViewOfCrop.image == nil) {
            UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        } else {
            UIImageWriteToSavedPhotosAlbum(_imageViewOfCrop.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        
    }];
    [topView addSubview:calendarButton];
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error == nil) {
        MJ_ShareViewController *shareVC = [[MJ_ShareViewController alloc] init];
        [self.navigationController pushViewController:shareVC animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
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
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTHSCREEN, HEIGHTSCREEN * 0.66)];
    _imageView.userInteractionEnabled = YES;
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.image = _image;
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

#pragma mark - 实现编辑协议方法
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect {
    _imageViewOfCrop.image = croppedImage;
    
}

#pragma mark - 功能点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _imageViewOfCrop.frame = CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height);
    [_imageView addSubview:_imageViewOfCrop];

    // 编辑
    if (indexPath.item == 1) {
        PECropViewController *cropEditVC = [[PECropViewController alloc] init];
        cropEditVC.delegate = self;
        // 获取当前图片
        UIImage *currentImage = [[UIImage alloc] init];
        currentImage = _imageView.image;
        // 传给编辑界面
        cropEditVC.image = currentImage;
        
        CGFloat width = currentImage.size.width;
        CGFloat height = currentImage.size.height;
        CGFloat length = MIN(width, height);
        
        cropEditVC.imageCropRect = CGRectMake((width = length) / 2, (height - length) / 2, length, length);
        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cropEditVC];
        
        [self presentViewController:navigation animated:YES completion:nil];
        
    }
    
    if (indexPath.item == 2) {
//        [self scaleToSize:useImage size:CGSizeMake(100, 100)];
    }
//    else {
    
    

    //加文字
//        [_imageView setImage:[self addText:useImage text:@"ffff"]];
    
    //加图片(水印)
//        [_imageView setImage:[self addImageLogo:useImage text:[UIImage imageNamed:@"logo"]]];

    
//    [_imageView setImage:[self addImage:useImage addMaskImage:[UIImage imageNamed:@"logo"]]];
    
//    NSLog(@"哈哈");
//    }
    

}



/*
 *转换成马赛克,level代表一个点转为多少level*level的正方形
 */
- (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level
{
    //获取BitmapData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = orginImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = CGBitmapContextGetData (context);
    
    //这里把BitmapData进行马赛克转换,就是用一个点的颜色填充一个level*level的正方形
    unsigned char pixel[kPixelChannelCount] = {0};
    NSUInteger index,preIndex;
    for (NSUInteger i = 0; i < height - 1 ; i++) {
        for (NSUInteger j = 0; j < width - 1; j++) {
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    memcpy(pixel, bitmapData + kPixelChannelCount*index, kPixelChannelCount);
                }else{
                    memcpy(bitmapData + kPixelChannelCount*index, pixel, kPixelChannelCount);
                }
            } else {
                preIndex = (i-1)*width +j;
                memcpy(bitmapData + kPixelChannelCount*index, bitmapData + kPixelChannelCount*preIndex, kPixelChannelCount);
            }
        }
    }
    
    NSInteger dataLength = width*height* kPixelChannelCount;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
    //创建要输出的图像
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
                                              kBitsPerComponent,
                                              kBitsPerPixel,
                                              width*kPixelChannelCount ,
                                              colorSpace,
                                              kCGImageAlphaPremultipliedLast,
                                              provider,
                                              NULL, NO,
                                              kCGRenderingIntentDefault);
    CGContextRef outputContext = CGBitmapContextCreate(nil,
                                                       width,
                                                       height,
                                                       kBitsPerComponent,
                                                       width*kPixelChannelCount,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    //释放
    if(resultImageRef){
        CFRelease(resultImageRef);
    }
    if(mosaicImageRef){
        CFRelease(mosaicImageRef);
    }
    if(colorSpace){
        CGColorSpaceRelease(colorSpace);
    }
    if(provider){
        CGDataProviderRelease(provider);
    }
    if(context){
        CGContextRelease(context);
    }
    if(outputContext){
        CGContextRelease(outputContext);
    }
    return resultImage;
    
}

/**
	加文字随意
	@param img 需要加文字的图片
	@param text1 文字描述
	@returns 加好文字的图片
 */
- (UIImage *)addText:(UIImage *)image text:(NSString *)text1 {
    
    int w = 300;
    int h = 140;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
    
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
    
    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Georgia", 15, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 0, 255, 255, 0.8);
    
    //位置调整
    CGContextShowTextAtPoint(context, w/2-strlen(text)*4.5, h - 135, text, strlen(text));
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:imageMasked];
    
}

/**
	加图片水印
	@param img 需要加logo图片的图片
	@param logo logo图片
	@returns 加好logo的图片
 */
- (UIImage *)addImageLogo:(UIImage *)image text:(UIImage *)logo {
    
    int w = image.size.width;
    int h = image.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
    
    CGContextDrawImage(context, CGRectMake(w - logoWidth, 0, logoWidth, logoHeight), [logo CGImage]);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    
    
}

/**
	加半透明水印
	@param useImage 需要加水印的图片
	@param addImage1 水印
	@returns 加好水印的图片
 */
- (UIImage *)addImage:(UIImage *)useIamge addMaskImage:(UIImage *)maskImage {
    
    UIGraphicsBeginImageContext(useIamge.size);
    [useIamge drawInRect:CGRectMake(0, 0, useIamge.size.width, useIamge.size.height)];
    
    //四个参数为水印图片的位置
    [maskImage drawInRect:CGRectMake(useIamge.size.width - 110, useIamge.size.height - 25, 100, 25)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
    
}

//- (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size {
//    
//    UIGraphicsBeginImageContext(size);
//    
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    
//    UIImage *endImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return endImage;
//}


@end
