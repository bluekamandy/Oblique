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
    NSMutableArray *adjustmentsPrivate;
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
        
        BOOL isFront = NO;
        
        _stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetPhoto cameraPosition:isFront?AVCaptureDevicePositionFront:AVCaptureDevicePositionBack];
        _stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
        _stillCamera.horizontallyMirrorFrontFacingCamera = YES;
        _stillCamera.horizontallyMirrorRearFacingCamera = NO;
        
        self.mainFilter = [MK_Shader noFilter];
        
        [_stillCamera addTarget:self.mainFilter];
        
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
    
    [self.mainFilter addTarget:self.stillCameraPreview];
    
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
            NSData *dataForJPEGFile = UIImageJPEGRepresentation(processedImage, 0.8);
            
            UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:dataForJPEGFile], nil, nil, nil);
            return ;
        }];
    }
}

- (void)changeToFilter:(NSString *)filterName
{
    if (self.mainFilter){
        [self.stillCamera removeTarget:self.mainFilter];
    } else {
        self.mainFilter = [[GPUImageFilterGroup alloc] init];
        NSLog(@"Initializing main filter in changeToFilter");
    }
    
    SEL s = NSSelectorFromString(filterName);
    self.mainFilter = [MK_Shader performSelector:s];
    
    [_stillCamera addTarget:self.mainFilter];
    [self.mainFilter addTarget:self.stillCameraPreview];
    [self.stillCamera startCameraCapture];
    
    self.selectedFilter = self.mainFilter;
    NSLog(@"Selected filter is %@", self.mainFilter.title);
}

- (void)toggleAdjustment:(NSString *)adjustmentName
{
//    //    // Take all adjustments away. We have to rebuild the filter chain every time.
//    //    if (self.adjustments) {
//    //        [self pauseCamera];
//    //        for (id individualAdjustment in self.adjustments) {
//    //            [self.stillCamera removeTarget:individualAdjustment];
//    //        }
//    //        [self resumeCamera];
//    //    }
//    
//    // Get the new adjustment from storage.
//    SEL s = NSSelectorFromString(adjustmentName);
//    GPUImageFilterGroup *newAdjustment = [MK_Shader performSelector:s];
//    
//    // If it doesn't exist, create a new mutable array.
//    if (!adjustmentsPrivate) {
//        adjustmentsPrivate = [NSMutableArray arrayWithObject:newAdjustment];
//    }
//    
//    NSLog(@"Starting adjustment for loop");
//    for (GPUImageFilterGroup *adj in adjustmentsPrivate) {
//        if (adj.iconName == newAdjustment.iconName) {
//            NSUInteger adjustmentToRemoveIndex = [adjustmentsPrivate indexOfObject:adjustmentName];
//            [adjustmentsPrivate removeObject:adjustmentName];
//            self.selectedFilter = [adjustmentsPrivate objectAtIndex:adjustmentToRemoveIndex--];
//            NSLog(@"Removing %@", adjustmentName);
//        } else {
//            [adjustmentsPrivate addObject:newAdjustment];
//            NSLog(@"Adding %@", adjustmentName);
//        }
//        
//    }
//    
//    
//    
//    // Set selected filter for touch adjustment.
//    self.selectedFilter = newAdjustment;
//    NSLog(@"Selected filter is %@", newAdjustment.title);
//    
//    // Assign/reassign the adjustment NSArray.
//    self.adjustments = [adjustmentsPrivate copy];
//    
//    // Enumerate and add all of the filters in the array to the camera.
//    [self pauseCamera];
//    for (id individualAdjustment in self.adjustments) {
//        [self.stillCamera addTarget:individualAdjustment];
//        [individualAdjustment addTarget:self.stillCameraPreview];
//    }
//    [self resumeCamera];
    
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
