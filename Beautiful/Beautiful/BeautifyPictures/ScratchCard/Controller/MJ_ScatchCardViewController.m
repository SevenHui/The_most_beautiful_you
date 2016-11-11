//
//  MJ_ScatchCardViewController.m
//  Beautiful
//
//  Created by 洛洛大人 on 16/11/5.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_ScatchCardViewController.h"
#import "MJ_ScratchCardView.h"

#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

@interface MJ_ScatchCardViewController ()
<UIActionSheetDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) MJ_ScratchCardView *SCView;
@property (nonatomic) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIImage *imgaeOfOther;

@end

@implementation MJ_ScatchCardViewController

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imgaeOfOther = _image;
    
    [self config];
    [self prepareUI];
    
}

- (void)config {
    self.navigationController.navigationBar.hidden = NO;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    
    if (!self.toolbarItems) {
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *constrainButton = [[UIBarButtonItem alloc] initWithTitle:@"Constrain" style:UIBarButtonItemStylePlain target:self action:@selector(constrain:)];
        
        self.toolbarItems = @[flexibleSpace, constrainButton, flexibleSpace];
    }
    self.navigationController.toolbarHidden = self.toolbarHidden;
    
}

- (void)cancel:(id)sender {
    
    self.navigationController.toolbar.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)done:(id)sender {
    self.navigationController.toolbar.hidden = NO;
    UIImage *image = [self captureCurrentView:_imageView];
    if (self.block) {
        self.block(image);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)constrain:(id)sender {
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"10 x 10", @"20 x 20", @"30 x 30", @"40 x 40", @"50 x 50", @"60 x 60", @"80 x 80", @"100 x 100", nil];
    [self.actionSheet showFromToolbar:self.navigationController.toolbar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        [_imageView setImage:[MJ_ScatchCardViewController transToMosaicImage:_imgaeOfOther blockLevel:10]];
    } else if (buttonIndex == 1) {
        
        [_imageView setImage:[MJ_ScatchCardViewController transToMosaicImage:_imgaeOfOther blockLevel:20]];
    } else if (buttonIndex == 2) {
        
        [_imageView setImage:[MJ_ScatchCardViewController transToMosaicImage:_imgaeOfOther blockLevel:30]];
    } else if (buttonIndex == 3) {
        
        [_imageView setImage:[MJ_ScatchCardViewController transToMosaicImage:_imgaeOfOther blockLevel:40]];
    } else if (buttonIndex == 4) {
        
        [_imageView setImage:[MJ_ScatchCardViewController transToMosaicImage:_imgaeOfOther blockLevel:50]];
    }
    else if (buttonIndex == 5) {
        
        [_imageView setImage:[MJ_ScatchCardViewController transToMosaicImage:_imgaeOfOther blockLevel:60]];
    }
    else if (buttonIndex == 6) {
        NSLog(@"4");
        [_imageView setImage:[MJ_ScatchCardViewController transToMosaicImage:_imgaeOfOther blockLevel:80]];
        
    }
    else if (buttonIndex == 7) {
        NSLog(@"4");
        [_imageView setImage:[MJ_ScatchCardViewController transToMosaicImage:_imgaeOfOther blockLevel:100]];
        
    }
}

- (void)prepareUI {
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 414, 736 - 70)];
    _imageView.userInteractionEnabled = YES;

    _imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:_imageView];

    [_imageView setImage:[MJ_ScatchCardViewController transToMosaicImage:_imgaeOfOther blockLevel:50]];

    UIImageView *sImg = [[UIImageView alloc] initWithFrame:_imageView.bounds];
    sImg.contentMode = UIViewContentModeScaleToFill;
    sImg.image = _imgaeOfOther;
    _SCView = [[MJ_ScratchCardView alloc]initWithFrame:self.imageView.bounds];
    //涂抹大小
    [_SCView setSizeBrush:50.0];
    [_SCView setHideView:sImg];
    [self.imageView addSubview:_SCView];
    
}

//获取当前View的截图
-(UIImage *)captureCurrentView :(UIView *)view{
    
    CGRect frame = view.frame;
    
    UIGraphicsBeginImageContext(frame.size);
    
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

/*
 *转换成马赛克,level代表一个点转为多少level*level的正方形
 */
+ (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level
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

@end
