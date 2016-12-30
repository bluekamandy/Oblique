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

@interface MK_GPUImageCameraManager : NSObject

@property (nonatomic) GPUImageStillCamera *stillCamera;
@property (nonatomic) GPUImageView *stillCameraPreview;
@property (nonatomic) GPUImageFilterGroup *mainFilter;
@property (nonatomic) GPUImageFilterGroup *selectedFilter;
@property (nonatomic) NSArray *adjustments;
@property (nonatomic) NSArray *targets;

+ (id)sharedManager;

- (GPUImageView*)createCameraViewWithFrame:(CGRect)frame;
- (void)turnFlashOn;
- (void)turnFlashOff;
- (void)toggleSelfieCamera;
- (void)removeCameraView:(GPUImageView*)cameraView;
- (void)changeToFilter:(NSString *)filterName;
- (void)toggleAdjustment:(NSString *)adjustmentName;
- (NSString *)changeFilterParameterUsingXPos:(CGFloat)xPos yPos:(CGFloat)yPos xDistance:(CGFloat)xDistance yDistance:(CGFloat)yDistance angle:(CGFloat)angle;
- (void)captureImage;

-(void)pauseCamera;
-(void)resumeCamera;

@end
