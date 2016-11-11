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
#import "MJ_CropViewController.h"
#import "MJ_FilterViewController.h"
#import "MJ_AutoBeautiyViewController.h"
#import "MJ_ColorListViewController.h"
#import "MJ_DecalsViewController.h"
#import "MJ_ScatchCardViewController.h"

typedef void(^MJ_BeautifyPicturesViewControllerBlock)(UIImage *img);

#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

@interface MJ_BeautifyPicturesViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
MJ_CropViewControllerDelegate,
MJ_FilterViewControllerDelegate,
MJ_DecalsViewControllerDelegate
>
{
    CIContext *_context;//coreImage上下文
    CIImage *_imageOfEditor;//要编辑的图像
    CIImage *_outPutImage;//处理后的图片
    CIFilter *_colorControlsFilter;//色彩滤镜
}
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

@property (nonatomic, assign) BOOL isAdjust;

@property (nonatomic, assign) NSInteger clickOfNumber;

@property (nonatomic, copy) MJ_BeautifyPicturesViewControllerBlock block;

@property (nonatomic, strong) MJ_FilterViewController *filterVC;

@property (nonatomic, strong) NSMutableArray *arrayOfRendering;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) BOOL isContrast;

@property (nonatomic, strong) UIButton *contrastBtn;

@property (nonatomic, strong) UIView *topView;


@end

@implementation MJ_BeautifyPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageViewOfCrop = [[UIImageView alloc] init];
  
    self.arrayOfRendering = [NSMutableArray array];
    
    self.textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor orangeColor];
    [_imageView addSubview:_textField];
    
    self.isChange = YES;
    self.isAdjust = YES;
    self.isContrast = YES;
    self.isChange = YES;
    
    [self config];
    [self createTopView];
    [self createImageView];
    [self createBottomView];
    
    [self createContrast];
    
    
}

- (void)config {
    
    self.iconArray = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"Unknown"],
                      [UIImage imageNamed:@"Unknown-1"],
                      [UIImage imageNamed:@"Unknown-2"],
                      [UIImage imageNamed:@"Unknown-3"],
                      [UIImage imageNamed:@"Unknown-4"],
                      [UIImage imageNamed:@"Unknown-5"],
                      nil];
    self.titleArray = @[@"优化", @"编辑", @"调节", @"特效", @"马赛克", @"贴纸"];
    
}

- (void)createTopView {
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(_topView.bounds.size.width * 0.06, _topView.bounds.size.height * 0.45, _topView.bounds.size.width * 0.07, _topView.bounds.size.height * 0.45) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"左箭头2"] color:nil addBlock:^(MJ_Button *button) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [_topView addSubview:backButton];
    
    MJ_Button *calendarButton = [MJ_Button buttonWithFrame:CGRectMake(_topView.bounds.size.width * 0.87, backButton.frame.origin.y, backButton.frame.size.width, backButton.frame.size.height) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"右箭头2"] color:nil addBlock:^(MJ_Button *button) {
        
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
    [_topView addSubview:calendarButton];
    
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
- (void)createImageView {
    self.imageView = [[UIImageView alloc] initWithImage:_image];
    _imageView.frame = CGRectMake(0, 64, WIDTHVIEW, HEIGHTVIEW - (HEIGHTSCREEN * 0.15) - 64);
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.image = _image;
    [self.view addSubview:_imageView];
    
    
}
- (void)createContrast {
    self.contrastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _contrastBtn.frame = CGRectMake(WIDTHSCREEN / 2 - WIDTHSCREEN * 0.045, HEIGHTSCREEN * 0.8, WIDTHSCREEN * 0.09, HEIGHTSCREEN * 0.04);
    _contrastBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contrastBtn];
    [_contrastBtn setImage:[UIImage imageNamed:@"对比icon"] forState:UIControlStateNormal];
    [_contrastBtn addTarget:self action:@selector(contrastBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)contrastBtnAction:(UIButton *)sender {
    if (_imageViewOfCrop.image != nil) {
        
        if (_isContrast == YES) {
            _isContrast = NO;
            [sender setImage:[UIImage imageNamed:@"对比icon"] forState:UIControlStateNormal];
            _imageViewOfCrop.hidden = YES;
        } else {
            _isContrast = YES;
            [sender setImage:[UIImage imageNamed:@"对比icon"] forState:UIControlStateNormal];
            _imageViewOfCrop.hidden = NO;
        }
    }
    
}
- (void)createBottomView {
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN * 0.85, WIDTHSCREEN, HEIGHTSCREEN * 0.15)];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTHSCREEN / 7, HEIGHTSCREEN * 0.1);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:buttomView.bounds collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = YES;
    _collectionView.pagingEnabled = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [buttomView addSubview:_collectionView];
    
    [_collectionView registerClass:[MJ_CurrentPicturesCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_CurrentPicturesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.image = _iconArray[indexPath.item];
    cell.text = _titleArray[indexPath.item];
    
    return cell;
}

#pragma mark - 实现编辑协议方法
- (void)cropViewController:(MJ_CropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect {
    _imageViewOfCrop.image = croppedImage;
    
}
#pragma mark - 实现特效协议方法
- (void)calendarImage:(UIImage *)image {
    _imageViewOfCrop.image = image;
}
- (void)didAddFinished:(UIImage *)image {
    _imageViewOfCrop.image = image;
}
#pragma mark - 功能点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _imageViewOfCrop.frame = _imageView.bounds;
    [_imageView addSubview:_imageViewOfCrop];
    
    // 获取当前图片
    UIImage *currentImage = [[UIImage alloc] init];
    
    // 智能优化
    if (indexPath.item == 0) {
        MJ_AutoBeautiyViewController *autoBeautiyVC = [[MJ_AutoBeautiyViewController alloc] init];

        if (_imageViewOfCrop.image == nil) {
            currentImage = _imageView.image;
            // 传给编辑界面
            autoBeautiyVC.image = currentImage;
        } else {
            currentImage = _imageViewOfCrop.image;
            autoBeautiyVC.image = currentImage;
        }
        
        autoBeautiyVC.block = ^(UIImage *image) {
            _imageViewOfCrop.image = image;
        };

        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:autoBeautiyVC];
        [self presentViewController:navigation animated:YES completion:nil];
    }
    
    // 编辑
    if (indexPath.item == 1) {
        MJ_CropViewController *cropEditVC = [[MJ_CropViewController alloc] init];
        cropEditVC.delegate = self;
        
        if (_imageViewOfCrop.image == nil) {
            currentImage = _imageView.image;
            // 传给编辑界面
            cropEditVC.image = currentImage;
        } else {
            currentImage = _imageViewOfCrop.image;
            cropEditVC.image = currentImage;
        }
        
        CGFloat width = currentImage.size.width;
        CGFloat height = currentImage.size.height;
        CGFloat length = MIN(width, height);
        
        cropEditVC.imageCropRect = CGRectMake((width = length) / 2, (height - length) / 2, length, length);
        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cropEditVC];
        [self presentViewController:navigation animated:YES completion:nil];
        
    }
    
    // 调节
    if (indexPath.item == 2) {
        
        MJ_ColorListViewController *colorListVc = [[MJ_ColorListViewController alloc] init];
       
        if (_imageViewOfCrop.image == nil) {
            currentImage = _imageView.image;
            colorListVc.image = currentImage;
        } else {
            currentImage = _imageViewOfCrop.image;
            colorListVc.image = currentImage;
        }
        
        colorListVc.block = ^(UIImage *image) {
            _imageViewOfCrop.image = image;
        };
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:colorListVc];
        [self presentViewController:navigation animated:YES completion:nil];
    }
    
    // 特效
    if (indexPath.item == 3) {
        
        MJ_FilterViewController *filterVC = [[MJ_FilterViewController alloc] init];
        filterVC.delegate = self;
        
        if (_imageViewOfCrop.image == nil) {
            currentImage = _imageView.image;
            filterVC.image = currentImage;
        } else {
            currentImage = _imageViewOfCrop.image;
            filterVC.image = currentImage;
        }
        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:filterVC];
        [self presentViewController:navigation animated:YES completion:nil];
    }
    
    // 马赛克
    if (indexPath.item == 4) {
        MJ_ScatchCardViewController *shareVC = [[MJ_ScatchCardViewController alloc] init];

        if (_imageViewOfCrop.image == nil) {
            currentImage = _imageView.image;
            shareVC.image = currentImage;
        } else {
            currentImage = _imageViewOfCrop.image;
            shareVC.image = currentImage;
        }
        shareVC.block = ^(UIImage *image) {
            _imageViewOfCrop.image = image;
        };

        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:shareVC];
            [self presentViewController:navigation animated:YES completion:nil];
        }
    
    // 贴纸
    if (indexPath.item == 5) {
        
        MJ_DecalsViewController *decalsVC = [[MJ_DecalsViewController alloc] init];
        decalsVC.delegate = self;
        
        if (_imageViewOfCrop.image == nil) {
            currentImage = _imageView.image;
            decalsVC.image = currentImage;
        } else {
            currentImage = _imageViewOfCrop.image;
            decalsVC.image = currentImage;
        }
        
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:decalsVC];
        [self presentViewController:navigation animated:YES completion:nil];
        
    }
    
}

/*
 *转换成马赛克,level代表一个点转为多少level*level的正方形
 */
- (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level {
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
    //获取上下文
    UIGraphicsBeginImageContext(image.size);
    
    //会这图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    //绘制水印文字
    CGRect rect = CGRectMake(0, 80, 150, 150);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    
    style.alignment = NSTextAlignmentCenter;
    
    //文字属性
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:18],
                          NSParagraphStyleAttributeName:style,
                          NSForegroundColorAttributeName:[UIColor whiteColor]};
    //将文字绘制上去
    [text1 drawInRect:rect withAttributes:dic];
    //获取绘制得到的图片
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束图片的绘制
    UIGraphicsEndImageContext();
    return watermarkImage;
    
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


@end
