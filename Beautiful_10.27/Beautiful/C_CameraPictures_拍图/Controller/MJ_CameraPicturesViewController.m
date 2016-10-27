//
//  MJ_CameraPicturesViewController.m
//  Beautiful
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 最美的你. All rights reserved.
//

#import "MJ_CameraPicturesViewController.h"
#import "MJ_CameraPictureCollectionViewCell.h"
// 当前图片
#import "MJ_CurrentPictureViewController.h"

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
//拍照之后跳转的Vc;
//@property (nonatomic, strong) MJ_CheckViewController *checkVC;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSwitch = YES;
    self.isEffect = YES;
    self.delay = 0;
    
    //效果图片的数组
    self.imageArray = @[@"filter_food_171", @"filter_food_302",@"filter_food_569", @"filter_food_570", @"filter_food_571", @"filter_general_194", @"filter_general_303", @"filter_general_427", @"filter_general_557", @"filter_general_574", @"filter_meirong_baixi", @"filter_meirong_hongrun", @"filter_meirong_lengyan", @"filter_meirong_menghuan", @"filter_meirong_qingxi", @"filter_meirong_qingxin", @"filter_meirong_rounen", @"filter_meirong_tianmei", @"filter_meirong_yangguang", @"filter_meirong_ziran", @"filter_objects_173", @"filter_objects_175", @"filter_objects_474", @"filter_objects_476", @"filter_objects_572", @"filter_portrait_116", @"filter_portrait_124", @"filter_portrait_149", @"filter_portrait_161", @"filter_portrait_357", @"filter_portrait_477", @"filter_portrait_553", @"filter_portrait_558", @"filter_scenery_180", @"filter_scenery_426", @"filter_scenery_549", @"filter_scenery_556", @"filter_scenery_573"];
    
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
    
    [_collectionView registerClass:[MJ_CameraPictureCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_CameraPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = COLOR;
    cell.imageName = _imageArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.item);
    [_mjCamera removeTarget:_mjFilter];
    
    if (indexPath.item == 0) {
        //原画
        _mjFilter = [[GPUImageFilter alloc] init];
    } else if (indexPath.item == 1) {
        //伸展失真 哈哈镜
        _mjFilter = [[GPUImageStretchDistortionFilter alloc] init];
    } else if (indexPath.item == 2) {
        //凹面镜
        _mjFilter = [[GPUImagePinchDistortionFilter alloc] init];
    } else if (indexPath.item == 3) {
        //水晶球效果
        _mjFilter = [[GPUImageGlassSphereFilter alloc] init];
    } else if (indexPath.item == 4) {
        //浮雕效果
        _mjFilter = [[GPUImageEmbossFilter alloc] init];
    } else if (indexPath.item == 5) {
        //点染,图像黑白化
        _mjFilter = [[GPUImageHalftoneFilter alloc] init];
    } else if (indexPath.item == 6) {
        //素描
        _mjFilter = [[GPUImageSketchFilter alloc] init];
    } else if (indexPath.item == 7) {
        //卡通效果
        _mjFilter = [[GPUImageToonFilter alloc] init];
    } else  {
        //水粉模糊效果
        _mjFilter = [[GPUImageKuwaharaFilter alloc] init];
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
    
    // 返回按钮
    MJ_Button *backButton = [MJ_Button buttonWithFrame:CGRectMake(topView.bounds.size.width * 0.04, topView.bounds.size.height * 0.5, topView.bounds.size.width * 0.06, topView.bounds.size.height * 0.38) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"返回"] color:nil addBlock:^(MJ_Button *button) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    //        backButton.backgroundColor = [UIColor purpleColor];
    [topView addSubview:backButton];
    
    //    闪光灯
    UIButton *buttonOfFillLight = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOfFillLight.frame = CGRectMake(topView.frame.size.width * 0.72, backButton.frame.origin.y, backButton.frame.size.width, backButton.frame.size.height);
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
    MJ_Button *buttonOfRotating = [MJ_Button buttonWithFrame:CGRectMake(buttonOfFillLight.frame.size.width * 2.3 + buttonOfFillLight.frame.origin.x, buttonOfFillLight.frame.origin.y, buttonOfFillLight.frame.size.width, buttonOfFillLight.frame.size.height) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"切换摄像头_空"] color:[UIColor greenColor] addBlock:^(MJ_Button *button) {
        
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
    
    // 当前图片
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(buttomView.bounds.size.width * 0.07, buttomView.bounds.size.height * 0.3, buttomView.bounds.size.width * 0.07, buttomView.bounds.size.width * 0.07)];
    [self getLastPhoto];
    _photoImageView.backgroundColor = [UIColor clearColor];
    [buttomView addSubview:_photoImageView];
    _photoImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.photoImageView addGestureRecognizer:tap];
    
    // 拍照
    MJ_Button *buttonOfPat = [MJ_Button buttonWithFrame:CGRectMake(buttomView.bounds.size.width / 2 - buttomView.bounds.size.width * 0.09, buttomView.bounds.size.height * 0.02, buttomView.bounds.size.width * 0.18, buttomView.bounds.size.width * 0.18) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"share_instagram_normal"] color:COLOR addBlock:^(MJ_Button *button) {
        
        if (_mjCamera.inputCamera.position == AVCaptureDevicePositionBack && _isSwitch == YES) {
            [_mjCamera.inputCamera lockForConfiguration:nil];
            [_mjCamera.inputCamera setTorchMode:AVCaptureTorchModeOn];
            [_mjCamera.inputCamera unlockForConfiguration];
            
        }
        
        [_mjCamera capturePhotoAsJPEGProcessedUpToFilter:_mjFilter withCompletionHandler:^(NSData *processedJPEG, NSError *error) {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeImageDataToSavedPhotosAlbum:processedJPEG metadata:_mjCamera.currentCaptureMetadata completionBlock:^(NSURL *assetURL, NSError *error) {
                if (error) {
                    NSLog(@"ERROR: the image failed to be written");
                }
                else {
                    NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
                    
                    if (_mjCamera.inputCamera.position == AVCaptureDevicePositionBack && _isSwitch == YES) {
                        [_mjCamera.inputCamera lockForConfiguration:nil];
                        [_mjCamera.inputCamera setTorchMode:AVCaptureTorchModeOff];
                        [_mjCamera.inputCamera unlockForConfiguration];
                    }
                    
                }
                
            }];
            
        }];
        
    }];
    [buttomView addSubview:buttonOfPat];

    // 特效
    MJ_Button *buttonOfEffect = [MJ_Button buttonWithFrame:CGRectMake(buttomView.bounds.size.width * 0.85, buttomView.bounds.size.height * 0.3, buttomView.bounds.size.width * 0.07, buttomView.bounds.size.width * 0.07) type:UIButtonTypeCustom title:nil image:[UIImage imageNamed:@"video_effecticon"] color:nil addBlock:^(MJ_Button *button) {
        if (_isEffect == YES) {
            self.collectionView.frame = CGRectMake(0, self.view.frame.size.height - buttomView.frame.size.height - 100, self.view.frame.size.width, 100);
            _isEffect = NO;
        } else {
            
            self.collectionView.frame = CGRectMake(0, 0, 0, 0);
            
            _isEffect = YES;
        }
        

    }];
    buttonOfEffect.layer.cornerRadius = buttomView.bounds.size.width * 0.07 / 2;
    [buttomView addSubview:buttonOfEffect];
    
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    MJ_CurrentPictureViewController *currentPictureVC = [[MJ_CurrentPictureViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:currentPictureVC];
    currentPictureVC.image = _photoImageView.image;
    [self presentViewController:navigation animated:YES completion:nil];
    
}



//获取相册的最后一张照片
- (void)getLastPhoto {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                ALAssetRepresentation *representation = [result defaultRepresentation];
                UIImage *lastPhoto = [UIImage imageWithCGImage:[representation fullScreenImage]];
                *stop = YES;
                self.photoImageView.image = lastPhoto;
                //相册为空的时候
                if (lastPhoto == nil) {
                    self.photoImageView.image = [UIImage imageNamed:@""];
                }
            }
            
        }];
        
        
    } failureBlock:^(NSError *error) {
        
    }];
    
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
