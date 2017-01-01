//
//  MK_GPUImageCameraManager.m
//  Oblique™
//
//     /^\˛˛˛˛˛˛˛/^\
//     /« ´ˆˆˆˆˆ` »\
//     |«´¸     ¸`»|
//     {  e     e  }
//     \    (∞)    /
//      |\ `-^-´ /|
//      |  ¨¨¨¨¨  |
//      |         |
//     /    ≈≈≈    \
//     /   ≈≈≈≈≈   \
//    /   ≈≈≈≈≈≈≈   \
//    |  ≈≈≈≈≈≈≈≈≈  |
//
//
//  by Masood Kamandy
//  © 2016 All Rights Reserved
//
//  Last updated 12/29/2016
//
//  More information at masoodkamandy@gmail.com

#import "MK_GPUImageCameraManager.h"
#import "MK_Shader.h"
#import "MK_ShaderGroup.h"
#import "MK_GPUImageCustom3Input.h"

@interface MK_GPUImageCameraManager ()

{
    MK_Shader *shaderDatabase;
}

@end

@implementation MK_GPUImageCameraManager

#pragma mark Singleton Initialization

+ (id)sharedManager {
    static dispatch_once_t onceToken;
    static MK_GPUImageCameraManager *sharedCameraManager;
    dispatch_once(&onceToken, ^{
        sharedCameraManager = [[MK_GPUImageCameraManager alloc] init];
    });
    return sharedCameraManager;
}

/* Sample code from: https://github.com/BradLarson/GPUImage/issues/233
 
 (void)viewDidLoad {
 
 [super viewDidLoad];
 
 CGRect frame = CGRectMake(20, 20, self.view.frame.size.width-40, self.view.frame.size.height-180);
 imageView = [[GPUImageView alloc] initWithFrame:frame];
 [self.view addSubview:imageView];
 
 brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
 brightnessFilter.brightness = 0;
 contrastFilter = [[GPUImageContrastFilter alloc] init];
 contrastFilter.contrast = 1;
 saturationFilter = [[GPUImageSaturationFilter alloc] init];
 saturationFilter.saturation = 1;
 
 }
 
 (void)viewWillAppear:(BOOL)animated {
 
 gpuImage = [[GPUImagePicture alloc] initWithImage:appModel.document.currentPage.image];
 
 [gpuImage addTarget:brightnessFilter];
 [brightnessFilter addTarget:contrastFilter];
 [contrastFilter addTarget:saturationFilter];
 
 [saturationFilter addTarget:imageView];
 
 [gpuImage processImage];
 }
 
 (IBAction)onSlide:(id)sender forEvent:(UIEvent *)event {
 
 switch (mode) {
 case 0:
 brightnessFilter.brightness = slider.value;
 break;
 case 1:
 contrastFilter.contrast = slider.value;
 break;
 case 2:
 saturationFilter.saturation = slider.value;
 break;
 }
 
 [gpuImage processImage];
 }
 
 (IBAction)onModeChange:(UISegmentedControl *)sender forEvent:(UIEvent *)event {
 
 mode = sender.selectedSegmentIndex;
 
 switch (mode) {
 case 0:
 slider.minimumValue = -1;
 slider.maximumValue = 1;
 slider.value = brightnessFilter.brightness;
 break;
 case 1:
 slider.minimumValue = 0;
 slider.maximumValue = 4;
 slider.value = contrastFilter.contrast;
 break;
 case 2:
 slider.minimumValue = 0;
 slider.maximumValue = 2;
 slider.value = saturationFilter.saturation;
 break;
 }
 }
 
 */

// OLD FUNCTIONING INIT

//- (id)init {
//    if ( self = [super init] ) {
//
//        BOOL isFront = NO;
//
//        _stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetPhoto cameraPosition:isFront?AVCaptureDevicePositionFront:AVCaptureDevicePositionBack];
//        _stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
//        _stillCamera.horizontallyMirrorFrontFacingCamera = YES;
//        _stillCamera.horizontallyMirrorRearFacingCamera = NO;
//
//        _filterChain = [[GPUImageFilterGroup alloc] init];
//
//        _brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
//        _brightness = 0.0;
//        _brightnessFilter.brightness = _brightness;
//
//        _contrastFilter = [[GPUImageContrastFilter alloc] init];
//        _contrast = 1.0;
//        _contrastFilter.contrast = _contrast;
//
//        _saturationFilter = [[GPUImageSaturationFilter alloc] init];
//        _saturation = 1.0;
//        _saturationFilter.saturation = _saturation;
//
//        _hueFilter = [[GPUImageHueFilter alloc] init];
//        _hue = 180.0;
//        _hueFilter.hue = _hue;
//
//        _mainFilter = [MK_Shader noFilter];
//
//        [_brightnessFilter addTarget:_contrastFilter];
//        [_contrastFilter addTarget:_saturationFilter];
//        [_saturationFilter addTarget:_hueFilter];
//        [_hueFilter addTarget:_mainFilter];
//
//        [(GPUImageFilterGroup *)_filterChain setInitialFilters:[NSArray arrayWithObject:_brightnessFilter]];
//        [(GPUImageFilterGroup *)_filterChain setTerminalFilter:_mainFilter];
//
//        [_stillCamera addTarget:_filterChain];
//
//        [_stillCamera startCameraCapture];
//
//    }
//    return self;
//}

- (id)init {
    if ( self = [super init] ) {
        
        BOOL isFront = NO;
        
        _stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetPhoto cameraPosition:isFront?AVCaptureDevicePositionFront:AVCaptureDevicePositionBack];
        _stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        _stillCamera.horizontallyMirrorFrontFacingCamera = YES;
        _stillCamera.horizontallyMirrorRearFacingCamera = NO;
        
        // These variables cannot be nil when you createNewFilterChain
        if (!_brightness) { _brightness = 0.25; }
        if (!_contrast) { _contrast = 1.0; }
        if (!_saturation) { _saturation = 1.0; }
        if (!_hue) { _hue = 180.0; }
        
        _filterChain = [self createNewFilterChain:@"noFilter"];
        
        [_stillCamera addTarget:_filterChain];
        
        [_stillCamera startCameraCapture];
        
    }
    return self;
}


-(void)pauseCamera{
    
    [_stillCamera pauseCameraCapture];
    
}

-(void)resumeCamera{
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        
        [_stillCamera resumeCameraCapture];
        
    }
    
}

-(GPUImageView*)createCameraViewWithFrame:(CGRect)frame{
    
    self.stillCameraPreview = [[GPUImageView alloc] initWithFrame:frame];
    self.stillCameraPreview.fillMode = kGPUImageFillModePreserveAspectRatio;
    self.stillCameraPreview.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.filterChain addTarget:self.stillCameraPreview];
    
    return self.stillCameraPreview;
}

-(void)removeCameraView:(GPUImageView *)cameraView{
    
    ///// What?
    
    [self.mainFilter removeTarget:cameraView];
    
}

#pragma mark - Camera Manipulation

- (void)captureImage
{
    if (self.mainFilter) {
        [self.stillCamera capturePhotoAsImageProcessedUpToFilter:self.mainFilter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
            NSData *dataForJPEGFile = UIImageJPEGRepresentation(processedImage, 1.0);
            
            UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:dataForJPEGFile], nil, nil, nil);
            return ;
        }];
    }
}

-(GPUImageFilterGroup *)createNewFilterChain:(NSString *)filterName {
    
    GPUImageFilterGroup *newFilterChain = [[GPUImageFilterGroup alloc] init];
    
    self.brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    self.brightnessFilter.brightness = self.brightness;
    
    self.contrastFilter = [[GPUImageContrastFilter alloc] init];
    self.contrastFilter.contrast = self.contrast;
    
    self.saturationFilter = [[GPUImageSaturationFilter alloc] init];
    self.saturationFilter.saturation = self.saturation;
    
    self.hueFilter = [[GPUImageHueFilter alloc] init];
    self.hueFilter.hue = self.hue;
    
    if (self.mainFilter){
        [self.stillCamera removeTarget:self.mainFilter];
    } else {
        self.mainFilter = [[GPUImageFilterGroup alloc] init];
        NSLog(@"Initializing main filter in changeToFilter");
    }
    
    SEL s = NSSelectorFromString(filterName);
    self.mainFilter = [MK_Shader performSelector:s];
    
    [self.brightnessFilter addTarget:self.contrastFilter];
    [self.contrastFilter addTarget:self.saturationFilter];
    [self.saturationFilter addTarget:self.hueFilter];
    [self.hueFilter addTarget:self.mainFilter];
    
    [(GPUImageFilterGroup *)newFilterChain setInitialFilters:[NSArray arrayWithObject:self.brightnessFilter]];
    [(GPUImageFilterGroup *)newFilterChain setTerminalFilter:self.mainFilter];
    
    return newFilterChain;
}


- (void)changeToFilter:(NSString *)filterName
{
    if (self.filterChain) {
        [self.stillCamera removeTarget:self.filterChain];
        NSLog(@"Removing target self.filterChain");
        NSLog (@"%@", self.filterChain.targets);
    }
    self.filterChain = [self createNewFilterChain:filterName];
    NSLog(@"Creating self.filterChain");
    
    [_stillCamera addTarget:self.filterChain];
    [self.filterChain addTarget:self.stillCameraPreview];
    [self.stillCamera startCameraCapture];

    
    NSLog(@"Selected filter is %@", self.mainFilter.title);
}

- (void)toggleAdjustment:(NSString *)adjustmentName
{
}


// Add adjustment filter
// Information field is entirely formated here.


- (NSString *)changeFilterParameterUsingXPos:(CGFloat)xPos yPos:(CGFloat)yPos xDistance:(CGFloat)xDistance yDistance:(CGFloat)yDistance angle:(CGFloat)angle
{
    NSString *informationField;
    if (self.mainFilter.usesTouch == [NSNumber numberWithBool:NO]){
        informationField = nil;
    } else {
        //self.mainFilter.centerObj = [NSValue valueWithCGPoint:xAndYChanges];
        MK_GPUImageCustom3Input *myFilterToChange = (MK_GPUImageCustom3Input *)self.mainFilter.terminalFilter;
        // Have to copy it and then copy it back because you can't access the myFilterToChange.center's CGPoint structure directly and I don't want to use CGPoints.
        CGPoint touchChanges = myFilterToChange.center;
        touchChanges.x = xPos;
        touchChanges.y = yPos;
        
        myFilterToChange.center = touchChanges;
        informationField = self.mainFilter.informationFormatter(xPos, yPos, xDistance, yDistance, angle);
    }
    return informationField;
}

#pragma mark - Setters for Brightness, Contrast, Saturation and Hue

- (void)setBrightness:(float)brightness {
    _brightness = brightness;
    self.brightnessFilter.brightness = brightness;
}

- (void)setContrast:(float)contrast {
    _contrast = contrast;
    self.contrastFilter.contrast = contrast;
}

- (void)setSaturation:(float)saturation {
    _saturation = saturation;
    self.saturationFilter.saturation = saturation;
}

- (void)setHue:(float)hue {
    _hue = hue;
    self.hueFilter.hue = hue;
}


- (void)turnFlashOn {
    [self.stillCamera.inputCamera lockForConfiguration:nil];
    [self.stillCamera.inputCamera setFlashMode:AVCaptureFlashModeOn];
    [self.stillCamera.inputCamera unlockForConfiguration];
}

- (void)turnFlashOff {
    [self.stillCamera.inputCamera lockForConfiguration:nil];
    [self.stillCamera.inputCamera setFlashMode:AVCaptureFlashModeOff];
    [self.stillCamera.inputCamera unlockForConfiguration];
}

- (void)toggleSelfieCamera {
    [self pauseCamera];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.stillCamera rotateCamera];
        
    });
    [self resumeCamera];
    
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
