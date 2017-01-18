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
#import <AssetsLibrary/AssetsLibrary.h>
#import "GPUImageContext.h"

const BOOL TONEMAP_DEFAULT = NO;
const float BRIGHTNESS_DEFAULT = 0.0;
const float CONTRAST_DEFAULT = 1.0;
const float SATURATION_DEFAULT = 1.0;
const float HUE_DEFAULT = 0.0;
const BOOL INVERT_DEFAULT = NO;
const BOOL EQUALIZE_DEFAULT = NO;
const float TEMPERATURE_DEFAULT = 5000;
const float TINT_DEFAULT = 0.0;

@interface MK_GPUImageCameraManager ()

{
    MK_Shader *shaderDatabase;
    CGPoint touchChanges;
    CGFloat touchXPos;
    CGFloat touchYPos;
    dispatch_queue_t sharedContextQueue;
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

- (id)init {
    if ( self = [super init] ) {
        
        sharedContextQueue = [GPUImageContext sharedContextQueue];
        
        BOOL isFront = NO;
        
        self.stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetPhoto cameraPosition:isFront?AVCaptureDevicePositionFront:AVCaptureDevicePositionBack];
        self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        self.stillCamera.horizontallyMirrorFrontFacingCamera = YES;
        self.stillCamera.horizontallyMirrorRearFacingCamera = NO;
        
        if (!_filterName) { _filterName = @"noFilter"; }
        
        // These variables cannot be nil when you createNewFilterChain
        if (!_toneMapValue) { _toneMapValue = TONEMAP_DEFAULT; }
        if (!_brightness) { _brightness = BRIGHTNESS_DEFAULT; }
        if (!_contrast) { _contrast = CONTRAST_DEFAULT; }
        if (!_temperature) { _temperature = TEMPERATURE_DEFAULT; }
        if (!_tint) { _tint = TINT_DEFAULT; }
        if (!_saturation) { _saturation = SATURATION_DEFAULT; }
        if (!_hue) { _hue = HUE_DEFAULT; }
        if (!_invert) { _invert = INVERT_DEFAULT; }
        if (!_equalize) { _equalize = EQUALIZE_DEFAULT; }
        NSLog(@"Equalize is starting up as %d", _equalize);
        touchChanges = CGPointMake(0,0);
        
        _filterChain = [self createNewFilterChain:@"noFilter" equalizationOn:_equalize];
        
        [self.stillCamera addTarget:_filterChain];
        
        [self.stillCamera startCameraCapture];
        
    }
    return self;
}


-(void)pauseCamera{
    
    [self.stillCamera pauseCameraCapture];
    
}

-(void)resumeCamera{
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        
        [self.stillCamera resumeCameraCapture];
        
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
    
    [self.filterChain removeTarget:cameraView];
    
}

#pragma mark - Camera Manipulation

- (void)captureImage
{
    // Trying to use semaphor to prevent camera from seizing up.
    //        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //
    //        [self.stillCamera capturePhotoAsImageProcessedUpToFilter:self.filterChain withCompletionHandler:^(UIImage *processedImage, NSError *error) {
    //
    //            // Uncomment to do JPEG files.
    //            NSData *dataForJPEGFile = UIImageJPEGRepresentation(processedImage, 1.0);
    //            UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:dataForJPEGFile], nil, nil, nil);
    //
    //            // Uncomment to do PNG files. (Much slower, loss-less.)
    //            //                NSData *dataForPNGFile = UIImagePNGRepresentation(processedImage);
    //            //                UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:dataForPNGFile], nil, nil, nil);
    //            dispatch_semaphore_signal(sema);
    //            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    //
    //            return;
    //        }];
    //        }
    //
    
    
    if (self.filterChain) {
        //        [self.stillCamera pauseCameraCapture];
            [self.stillCamera capturePhotoAsImageProcessedUpToFilter:self.filterChain.terminalFilter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
                //            [self.stillCamera pauseCameraCapture];
                // Uncomment to do JPEG files.
                
                NSData *dataForJPEGFile = UIImageJPEGRepresentation(processedImage, 0.8);
                UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:dataForJPEGFile], nil, nil, nil);
                
//                UIImageWriteToSavedPhotosAlbum(processedImage, self, nil, nil);
                
                // Uncomment to do PNG files. (Much slower, loss-less.)
                //                NSData *dataForPNGFile = UIImagePNGRepresentation(processedImage);
                //                UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:dataForPNGFile], nil, nil, nil);
                //            [self.stillCamera resumeCameraCapture];
                
                return;
            }];
    }
    
    
    
}

// Trying to discard the NSData portion.
//        if (self.filterChain) {
//            [_stillCamera capturePhotoAsImageProcessedUpToFilter:self.filterChain withCompletionHandler:^(UIImage *processedImage, NSError *error) {
//                ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//                [library writeImageToSavedPhotosAlbum:processedImage.CGImage
//                                             metadata:nil
//                                      completionBlock:^(NSURL *assetURL, NSError *error){
//                                          if (!error) {
//                                              NSLog(@"success");
//                                          } else {
//                                              NSLog(@"failed");
//                                          }
//                                      }
//                 ];
//            }];
//        }

//        [self.stillCamera pauseCameraCapture];
//        __weak typeof(self)weakSelf = self;
//        [self.stillCamera capturePhotoAsImageProcessedUpToFilter:self.stillCamera.targets.lastObject
//                                      withCompletionHandler:^(UIImage *processedImage, NSError *error)
//         {
//             UIImageWriteToSavedPhotosAlbum(processedImage, nil, nil, nil);
//             [weakSelf.stillCamera resumeCameraCapture];
//         }];


//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//    if([self respondsToSelector: @selector(saveComplete)]) {
//        [self performSelector:@selector(saveComplete)];
//    }
//}


-(GPUImageFilterGroup *)createNewFilterChain:(NSString *)filterName {
    
    GPUImageFilterGroup *newFilterChain = [[GPUImageFilterGroup alloc] init];
    
    self.filterName = filterName;
    
    NSLog(@"Setting non-equalized filter to %@", filterName);
    
    SEL s = NSSelectorFromString(filterName);
    self.mainFilter = [MK_Shader performSelector:s];
    
    self.toneMap = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_ToneMap"];
    self.toneMap.parameter = self.toneMapValue;
    
    self.brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    self.brightnessFilter.brightness = self.brightness;
    
    self.contrastFilter = [[GPUImageContrastFilter alloc] init];
    self.contrastFilter.contrast = self.contrast;
    
    self.temperatureFilter = [[GPUImageWhiteBalanceFilter alloc] init];
    self.temperatureFilter.temperature = self.temperature;
    self.temperatureFilter.tint = self.tint;
    
    self.saturationFilter = [[GPUImageSaturationFilter alloc] init];
    self.saturationFilter.saturation = self.saturation;
    
    self.hueFilter = [[GPUImageHueFilter alloc] init];
    self.hueFilter.hue = self.hue;
    
    self.invertFilter = [MK_Shader invert];
    self.invert = self.invert;
    
    [self.mainFilter addTarget:self.toneMap];
    [self.toneMap addTarget:self.brightnessFilter];
    [self.brightnessFilter addTarget:self.contrastFilter];
    [self.contrastFilter addTarget:self.temperatureFilter];
    [self.temperatureFilter addTarget:self.saturationFilter];
    [self.saturationFilter addTarget:self.hueFilter];
    [self.hueFilter addTarget:self.invertFilter];
    
    [(GPUImageFilterGroup *)newFilterChain setInitialFilters:[NSArray arrayWithObject:self.mainFilter]];
    [(GPUImageFilterGroup *)newFilterChain setTerminalFilter:self.invertFilter];
    
    if ((touchChanges.x != 0) && (touchChanges.y != 0)) {
        [self updateTouch];
    }
    
    return newFilterChain;
}

-(GPUImageFilterGroup *)createNewFilterChain:(NSString *)filterName equalizationOn:(BOOL)equal {
    
    GPUImageFilterGroup *newFilterChain;
    
    if (equal) {
        
        newFilterChain = [[GPUImageFilterGroup alloc] init];
        
        self.filterName = filterName;
        NSLog(@"Setting equalized filter to %@", filterName);
        
        SEL s = NSSelectorFromString(filterName);
        self.mainFilter = [MK_Shader performSelector:s];
        
        self.equalizationFilter = [[GPUImageHistogramEqualizationFilter alloc] initWithHistogramType:kGPUImageHistogramLuminance];
        self.equalizationFilter.downsamplingFactor = 4.0; // 1 and 2 reduce performance quite a bit. Going up to 4.
        
        self.toneMap = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_ToneMap"];
        self.toneMap.parameter = self.toneMapValue;
        
        self.brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
        self.brightnessFilter.brightness = self.brightness;
        
        self.contrastFilter = [[GPUImageContrastFilter alloc] init];
        self.contrastFilter.contrast = self.contrast;
        
        self.temperatureFilter = [[GPUImageWhiteBalanceFilter alloc] init];
        self.temperatureFilter.temperature = self.temperature;
        self.temperatureFilter.tint = self.tint;
        
        self.saturationFilter = [[GPUImageSaturationFilter alloc] init];
        self.saturationFilter.saturation = self.saturation;
        
        self.hueFilter = [[GPUImageHueFilter alloc] init];
        self.hueFilter.hue = self.hue;
        
        self.invertFilter = [MK_Shader invert];
        self.invert = self.invert; // Need to call the setter.
        
        [self.mainFilter addTarget:self.equalizationFilter];
        [self.equalizationFilter addTarget:self.toneMap];
        [self.toneMap addTarget:self.brightnessFilter];
        [self.brightnessFilter addTarget:self.contrastFilter];
        [self.contrastFilter addTarget:self.temperatureFilter];
        [self.temperatureFilter addTarget:self.saturationFilter];
        [self.saturationFilter addTarget:self.hueFilter];
        [self.hueFilter addTarget:self.invertFilter];
        
        [(GPUImageFilterGroup *)newFilterChain setInitialFilters:[NSArray arrayWithObject:self.mainFilter]];
        [(GPUImageFilterGroup *)newFilterChain setTerminalFilter:self.invertFilter];
        
        if ((touchChanges.x != 0) && (touchChanges.y != 0)) {
            [self updateTouch];
        }
        
    } else {
        newFilterChain = [self createNewFilterChain:filterName];
    }
    
    return newFilterChain;
}


- (void)changeToFilter:(NSString *)filterName
{
    if (self.filterChain) {
        [self.stillCamera removeTarget:self.filterChain];
        self.filterChain = nil;
        NSLog(@"Removing target self.filterChain");
        NSLog (@"%@", self.filterChain.targets);
    }
    self.filterChain = [self createNewFilterChain:filterName equalizationOn:self.equalize];
    NSLog(@"%@", self.filterChain);
    
    [self.stillCamera addTarget:self.filterChain];
    [self.filterChain addTarget:self.stillCameraPreview];
    [self.stillCamera startCameraCapture];
    
    
    NSLog(@"Selected filter is %@", self.mainFilter.title);
}

- (void)resetAdjustmentsToDefaults {
    self.toneMapValue = TONEMAP_DEFAULT;
    self.brightness = BRIGHTNESS_DEFAULT;
    self.contrast = CONTRAST_DEFAULT;
    self.saturation = SATURATION_DEFAULT;
    self.hue = HUE_DEFAULT;
    self.invert = INVERT_DEFAULT;
    self.equalize = EQUALIZE_DEFAULT;
    self.temperature = TEMPERATURE_DEFAULT;
    self.tint = TINT_DEFAULT;
}

// Information field is entirely formated here.

- (NSString *)changeFilterParameterUsingXPos:(CGFloat)xPos yPos:(CGFloat)yPos xDistance:(CGFloat)xDistance yDistance:(CGFloat)yDistance angle:(CGFloat)angle
{
    NSString *informationField;
    touchXPos = xPos;
    touchYPos = yPos;
    if (self.mainFilter.usesTouch == [NSNumber numberWithBool:NO]){
        informationField = nil;
    } else {
        [self updateTouch];
        informationField = self.mainFilter.informationFormatter(xPos, yPos, xDistance, yDistance, angle);
    }
    return informationField;
}

- (void)updateTouch {
    
    MK_GPUImageCustom3Input *myFilterToChange = (MK_GPUImageCustom3Input *)self.mainFilter.terminalFilter;
    // Have to copy it and then copy it back because you can't access the myFilterToChange.center's CGPoint structure directly and I don't want to use CGPoints.
    touchChanges = myFilterToChange.center;
    touchChanges.x = touchXPos;
    touchChanges.y = touchYPos;
    
    myFilterToChange.center = touchChanges;
    
}

#pragma mark - Setters for Brightness, Contrast, Saturation and Hue

- (void)setToneMapValue:(BOOL)toneMapValue {
    _toneMapValue = toneMapValue;
    if (toneMapValue) {
        self.toneMap.parameter = 1.0;
    } else {
        self.toneMap.parameter = 0.0;
    }
    
}

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

-(void)setTemperature:(float)temperature {
    _temperature = temperature;
    self.temperatureFilter.temperature = temperature;
}

-(void)setTint:(float)tint {
    _tint = tint;
    self.temperatureFilter.tint = tint;
}

- (void)setInvert:(BOOL)invert {
    _invert = invert;
    MK_GPUImageCustom3Input *invertSet = (MK_GPUImageCustom3Input *)self.invertFilter.terminalFilter;
    if (invert) {
        invertSet.parameter = 1.0;
    } else {
        invertSet.parameter = 0.0;
    }
}

- (void)setEqualize:(BOOL)equalize {
    _equalize = equalize;
    [self changeToFilter:self.filterName];
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
