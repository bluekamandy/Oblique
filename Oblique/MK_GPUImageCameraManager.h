//
//  MK_GPUImageCameraManager.h
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

#import <Foundation/Foundation.h>
#import <GPUImage/GPUImage.h>
#import "MK_GPUImageCustom3Input.h"

extern const float BRIGHTNESS_DEFAULT;
extern const float CONTRAST_DEFAULT;
extern const float SATURATION_DEFAULT;
extern const float HUE_DEFAULT;
extern const float INVERT_DEFAULT;

@interface MK_GPUImageCameraManager : NSObject

@property (nonatomic) GPUImageStillCamera *stillCamera;
@property (nonatomic) GPUImageView *stillCameraPreview;
@property (nonatomic) GPUImageFilterGroup *mainFilter;
@property (nonatomic) GPUImageFilterGroup *filterChain;
@property (nonatomic) GPUImageBrightnessFilter *brightnessFilter;
@property (nonatomic) GPUImageContrastFilter *contrastFilter;
@property (nonatomic) GPUImageSaturationFilter *saturationFilter;
@property (nonatomic) GPUImageFilterGroup *invertFilter;
@property (nonatomic) GPUImageHueFilter *hueFilter;

// Brightness ranges from -1.0 to 1.0, with 0.0 as the normal level
@property (nonatomic) float brightness;
// Contrast ranges from 0.0 to 4.0 (max contrast), with 1.0 as the normal level
@property (nonatomic) float contrast;
// Saturation ranges from 0.0 (fully desaturated) to 2.0 (max saturation), with 1.0 as the normal level
@property (nonatomic) float saturation;
// Hue ranges from 0.0 (normal hue) to 180.0 (opposite hue). Max is 360.
@property (nonatomic) float hue;
// 1.0 is ON 0.0 is OFF
@property (nonatomic) BOOL invert;

+ (id)sharedManager;

- (GPUImageView*)createCameraViewWithFrame:(CGRect)frame;
- (void)turnFlashOn;
- (void)turnFlashOff;
- (void)toggleSelfieCamera;
- (void)removeCameraView:(GPUImageView*)cameraView;
- (void)changeToFilter:(NSString *)filterName;
- (void)resetAdjustmentsToDefaults;
- (NSString *)changeFilterParameterUsingXPos:(CGFloat)xPos yPos:(CGFloat)yPos xDistance:(CGFloat)xDistance yDistance:(CGFloat)yDistance angle:(CGFloat)angle;
- (void)captureImage;

-(void)pauseCamera;
-(void)resumeCamera;

@end
