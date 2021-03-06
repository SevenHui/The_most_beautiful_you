//
//  MJ_CameraPicturesViewController.m
//  Beautiful
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CameraPicturesViewController.h"
#import "MJ_FilterCollectionViewCell.h"
#import "MJ_BeautifyPicturesViewController.h"

@interface MJ_CameraPicturesViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UIGestureRecognizerDelegate,
CAAnimationDelegate
>
{
    CALayer *_focusLayer;
}

//相机
@property (nonatomic, strong) GPUImageStillCamera *mjCamera;
//过滤器
@property (nonatomic, strong) GPUImageFilter *mjFilter;
//承载图片的imageView
@property (nonatomic, strong) GPUImageView *mjGPUImageView;
//用于保存原图
@property AVCaptureStillImageOutput *photoOutPut;
//开关(闪光灯)
@property (nonatomic, assign) BOOL isSwitch;
//特效
@property (nonatomic, assign) BOOL isEffect;
//动画
@property (nonatomic, strong) CATransition *animationhaha;

//滤镜效果图数组
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) ALAssetsGroup *assetGroup;
//效果图展示collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
//开始的缩放比例
@property (nonatomic, assign) CGFloat beginGestureScale;
//最后缩放的比例
@property (nonatomic, assign) CGFloat effectivcScale;

@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, assign) NSInteger delay;

@end

@implementation MJ_CameraPicturesViewController
{
    //聚焦层
    CALayer *focusLayer;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSwitch = YES;
    self.isEffect = YES;
    self.delay = 0;
    
    self.imageArray = @[@"原图", @"晕影", @"怀旧", @"磨皮", @"水粉画", @"卡通", @"素描", @"黑白", @"浮雕"];
    
    [self camera];
    [self creatTopView];
    [self creatBottomView];
    [self creatCollectionView];
    
}
#pragma mark - 滤镜展示collectionView
- (void)creatCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 4, 100);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //    水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //    隐藏滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    //    关闭回弹效果
    _collectionView.bounces = NO;
    
    [_collectionView registerClass:[MJ_FilterCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.text = _imageArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.item);
    [_mjCamera removeTarget:_mjFilter];
    
    if (indexPath.item == 0) {
        //原画
        _mjFilter = [[GPUImageFilter alloc] init];
    } else if (indexPath.item == 1) {
        //晕影
        _mjFilter = [[GPUImageVignetteFilter alloc] init];
    } else if (indexPath.item == 2) {
        //怀旧
        _mjFilter = [[GPUImageSepiaFilter alloc] init];
    } else if (indexPath.item == 3) {
        //磨皮
        _mjFilter = [[GPUImageBilateralFilter alloc] init];
    } else if (indexPath.item == 4) {
        //水粉画
        _mjFilter = [[GPUImageKuwaharaFilter alloc] init];
    } else if (indexPath.item == 5) {
        //卡通
        _mjFilter = [[GPUImageToonFilter alloc] init];
    } else if (indexPath.item == 6) {
        //素描
        _mjFilter = [[GPUImageSketchFilter alloc] init];
    } else if (indexPath.item == 7) {
        //黑白
        _mjFilter = [[GPUImageGrayscaleFilter alloc] init];
    } else  {
        //浮雕
        _mjFilter = [[GPUImageEmbossFilter alloc] init];
    }
    
    [_mjCamera addTarget:_mjFilter];
    [_mjFilter addTarget:_mjGPUImageView];
    
}

#pragma mark - 创建相机
- (void)camera {
    
    //    参数1,相片的尺寸
    //    参数2,前后摄像头   , AVCaptureDevicePositionBack 后置摄像头
    //    设置默认为前置摄像头
    _mjCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetPhoto cameraPosition:AVCaptureDevicePositionFront];
    //    设置照片的方向为设备的方向
    _mjCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    //设置是否为镜像
    _mjCamera.horizontallyMirrorFrontFacingCamera = YES;
    _mjCamera.horizontallyMirrorRearFacingCamera = NO;
    
    //    这个滤镜可以换其他的
    _mjFilter = [[GPUImageFilter alloc] init];
    
    [self setfocusImage:[UIImage imageNamed:@"聚焦框"]];
    
    _mjGPUImageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    
    [_mjCamera addTarget:_mjFilter];
    [_mjFilter addTarget:_mjGPUImageView];
    
    
    [self.view addSubview:_mjGPUImageView];
    
    [_mjCamera startCameraCapture];
    
    [self setBeginGestureScale:1.0f];
    [self setEffectivcScale:1.0f];
    
}

#pragma mark - 顶部View
- (void)creatTopView {
    // View
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHSCREEN, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.06, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.06, topView.bounds.size.height * 0.38) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"返回"] color:nil addBlock:^(MJ_Button *button) {}];
    
    //    闪光灯
    UIButton *buttonOfFillLight = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOfFillLight.frame = CGRectMake(topView.frame.size.width * 0.7, backButton.frame.origin.y, backButton.frame.size.width, backButton.frame.size.height);
    [buttonOfFillLight setImage:[UIImage imageNamed:@"闪光灯开启"] forState:UIControlStateNormal];
    [self.view addSubview:buttonOfFillLight];
    [buttonOfFillLight addTarget:self action:@selector(buttonOfFillLightAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:buttonOfFillLight];
    
    //    添加旋转动画
    self.animationhaha = [CATransition animation];
    _animationhaha.duration = .5f;
    _animationhaha.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _animationhaha.type = @"oglFlip";
    
    
    //     切换摄像头
    MJ_Button *buttonOfRotating = [MJ_Button buttonWithFrame:CGRectMake(buttonOfFillLight.frame.size.width * 2.4 + buttonOfFillLight.frame.origin.x, buttonOfFillLight.frame.origin.y, buttonOfFillLight.frame.size.width * 1.2, buttonOfFillLight.frame.size.height) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"切换摄像头_空"] color:[UIColor greenColor] addBlock:^(MJ_Button *button) {
        
        [self.mjCamera rotateCamera];
        _animationhaha.subtype = kCATransitionFromRight;
        
    }];
    [topView addSubview:buttonOfRotating];
    
}

#pragma mark - 开启与关闭闪光灯
- (void)buttonOfFillLightAction:(UIButton *)buttonOfFillLight {
    if (_isSwitch == YES) {
        _isSwitch = NO;
        [buttonOfFillLight setImage:[UIImage imageNamed:@"闪光灯关闭"] forState:UIControlStateNormal];
    } else if (_isSwitch == NO) {
        _isSwitch = YES;
        [buttonOfFillLight setImage:[UIImage imageNamed:@"闪光灯开启"] forState:UIControlStateNormal];
    }
}

#pragma mark - 底部View
- (void)creatBottomView {
    // View
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHTSCREEN * 0.9, WIDTHSCREEN, HEIGHTSCREEN * 0.1)];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    
    // 返回按钮
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(buttomView.bounds.size.width * 0.07, buttomView.bounds.size.height * 0.3, buttomView.bounds.size.width * 0.07, buttomView.bounds.size.width * 0.07) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"返回"] color:nil addBlock:^(MJ_Button *button) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    [buttomView addSubview:backButton];
    
    // 拍照
    MJ_Button *buttonOfPat = [MJ_Button buttonWithFrame:CGRectMake(buttomView.bounds.size.width / 2 - buttomView.bounds.size.width * 0.09, buttomView.bounds.size.height * 0.02, buttomView.bounds.size.width * 0.18, buttomView.bounds.size.width * 0.18) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"share_instagram_normal"] color:COLOR addBlock:^(MJ_Button *button) {
        
        if (_mjCamera.inputCamera.position == AVCaptureDevicePositionBack && _isSwitch == YES) {
            [_mjCamera.inputCamera lockForConfiguration:nil];
            [_mjCamera.inputCamera setTorchMode:AVCaptureTorchModeOn];
            [_mjCamera.inputCamera unlockForConfiguration];
        }
        
        [_mjCamera capturePhotoAsJPEGProcessedUpToFilter:_mjFilter withCompletionHandler:^(NSData *processedJPEG, NSError *error) {
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                
                [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:processedJPEG options:nil];
                
                if (_mjCamera.inputCamera.position == AVCaptureDevicePositionBack && _isSwitch == YES) {
                    [_mjCamera.inputCamera lockForConfiguration:nil];
                    [_mjCamera.inputCamera setTorchMode:AVCaptureTorchModeOff];
                    [_mjCamera.inputCamera unlockForConfiguration];
                }
                
                
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                
            }];
            
        }];
   

    }];
    
        [buttomView addSubview:buttonOfPat];

    // 特效
    MJ_Button *buttonOfEffect = [MJ_Button buttonWithFrame:CGRectMake(buttomView.bounds.size.width * 0.85, buttomView.bounds.size.height * 0.3, buttomView.bounds.size.width * 0.07, buttomView.bounds.size.width * 0.07) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"相机特效"] color:nil addBlock:^(MJ_Button *button) {
        if (_isEffect == YES) {
            self.collectionView.frame = CGRectMake(0, self.view.frame.size.height - buttomView.frame.size.height - 50, self.view.frame.size.width, 50);
            _isEffect = NO;
        } else {
            
            self.collectionView.frame = CGRectMake(0, 0, 0, 0);
            
            _isEffect = YES;
        }
    
    }];
    buttonOfEffect.layer.cornerRadius = buttomView.bounds.size.width * 0.07 / 2;
    [buttomView addSubview:buttonOfEffect];
    
}

- (void)setfocusImage:(UIImage *)focusImage {
    
    if (!focusImage) return;
    
    if (!focusLayer) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self.mjGPUImageView addGestureRecognizer:tap];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [self.mjGPUImageView addGestureRecognizer:pinch];
        
        pinch.delegate = self;
        
    }
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, focusImage.size.width, focusImage.size.height)];
    imageview.image = focusImage;
    
    CALayer *layer = imageview.layer;
    layer.hidden = YES;
    [self.mjGPUImageView.layer addSublayer:layer];
    focusLayer = layer;
    
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch {
    self.effectivcScale = self.beginGestureScale * pinch.scale;
    if (self.effectivcScale < 1.0f) {
        self.effectivcScale = 1.0f;
    }
    //设置最大放大倍数为3倍
    CGFloat maxScaleAndCropFactor = 3.0f;
    if (self.effectivcScale > maxScaleAndCropFactor) {
        self.effectivcScale = maxScaleAndCropFactor;
        [CATransaction begin];
        
        [CATransaction setAnimationDuration:025];
        NSError *error;
        
        if ([self.mjCamera.inputCamera lockForConfiguration:&error]) {
            [self.mjCamera.inputCamera setVideoZoomFactor:self.effectivcScale];
            [self.mjCamera.inputCamera unlockForConfiguration];
        } else {
            NSLog(@"error : %@", error);
        }
        [CATransaction commit];
        
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
        self.beginGestureScale = self.effectivcScale;
    }
    return YES;
}


- (void)tapGesture:(UITapGestureRecognizer *)tapGesture {
    self.mjGPUImageView.userInteractionEnabled = NO;
    CGPoint touchPoint = [tapGesture locationInView:tapGesture.view];
    [self layerAnimationWith:touchPoint];
    /**
     *下面是照相机焦点坐标轴和屏幕坐标轴的映射问题，这个坑困惑了我好久，花了各种方案来解决这个问题，以下是最简单的解决方案也是最准确的坐标转换方式
     */
    if (_mjCamera.cameraPosition == AVCaptureDevicePositionBack) {
        touchPoint = CGPointMake(touchPoint.y / tapGesture.view.bounds.size.height, 1 - touchPoint.x / tapGesture.view.bounds.size.width);
        
    }
    else
        touchPoint = CGPointMake(touchPoint.y /tapGesture.view.bounds.size.height ,touchPoint.x/tapGesture.view.bounds.size.width);
    /*以下是相机的聚焦和曝光设置，前置不支持聚焦但是可以曝光处理，后置相机两者都支持，下面的方法是通过点击一个点同时设置聚焦和曝光，当然根据需要也可以分开进行处理
     */
    if([self.mjCamera.inputCamera isExposurePointOfInterestSupported] && [self.mjCamera.inputCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
    {
        NSError *error;
        if ([self.mjCamera.inputCamera lockForConfiguration:&error]) {
            [self.mjCamera.inputCamera setExposurePointOfInterest:touchPoint];
            [self.mjCamera.inputCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            if ([self.mjCamera.inputCamera isFocusPointOfInterestSupported] && [self.mjCamera.inputCamera isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
                [self.mjCamera.inputCamera setFocusPointOfInterest:touchPoint];
                [self.mjCamera.inputCamera setFocusMode:AVCaptureFocusModeAutoFocus];
            }
            [self.mjCamera.inputCamera unlockForConfiguration];
        } else {
            NSLog(@"ERROR = %@", error);
        }
    }
}

- (void)layerAnimationWith:(CGPoint)point {
    if (focusLayer) {
        CALayer *focus = focusLayer;
        
        focusLayer.hidden = NO;
        
        [CATransaction begin];
        
        [CATransaction setDisableActions:YES];
        
        [focus setPosition:point];
        
        focus.transform = CATransform3DMakeScale(2.0f, 2.0f, 2.0f);
        
        [CATransaction commit];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)];
        animation.delegate = self;
        animation.duration = 0.3f;
        animation.repeatCount = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [focus addAnimation:animation forKey:@"animation"];
        
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self performSelector:@selector(focusLayerNormal) withObject:self afterDelay:0.5f];
}

- (void)focusLayerNormal {
    self.mjGPUImageView.userInteractionEnabled = YES;
    focusLayer.hidden = YES;
}


@end
