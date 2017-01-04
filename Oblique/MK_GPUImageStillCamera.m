//
//  MK_GPUImageStillCamera.m
//  Oblique
//
//  Created by Masood on 1/4/17.
//  Copyright © 2017 Masood Kamandy. All rights reserved.
//

#import "MK_GPUImageStillCamera.h"
#import <AVFoundation/AVCaptureOutput.h>

@interface MK_GPUImageStillCamera ()
{
    AVCapturePhotoOutput *photoOutput;
    AVCapturePhotoSettings *photoSettings;
}

// Methods calling this are responsible for calling dispatch_semaphore_signal(frameRenderingSemaphore) somewhere inside the block
- (void)capturePhotoProcessedUpToFilter:(GPUImageOutput<GPUImageInput> *)finalFilterInChain withImageOnGPUHandler:(void (^)(NSError *error))block;

@end

@implementation MK_GPUImageStillCamera{
    BOOL requiresFrontCameraTextureCacheCorruptionWorkaround;
}

- (id)initWithSessionPreset:(NSString *)sessionPreset cameraPosition:(AVCaptureDevicePosition)cameraPosition;
{
    if (!(self = [super initWithSessionPreset:sessionPreset cameraPosition:cameraPosition]))
    {
        return nil;
    }
    
    /* Detect iOS version < 6 which require a texture cache corruption workaround */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    requiresFrontCameraTextureCacheCorruptionWorkaround = [[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] == NSOrderedAscending;
#pragma clang diagnostic pop
    
    [self.captureSession beginConfiguration];
    
    photoOutput = [[AVCapturePhotoOutput alloc] init];
    
    // Having a still photo input set to BGRA and video to YUV doesn't work well, so since I don't have YUV resizing for iPhone 4 yet, kick back to BGRA for that device
    //    if (captureAsYUV && [GPUImageContext supportsFastTextureUpload])
    if (captureAsYUV && [GPUImageContext deviceSupportsRedTextures])
    {
        BOOL supportsFullYUVRange = NO;
        NSArray *supportedPixelFormats = photoOutput.availablePhotoPixelFormatTypes;
        for (NSNumber *currentPixelFormat in supportedPixelFormats)
        {
            if ([currentPixelFormat intValue] == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
            {
                supportsFullYUVRange = YES;
            }
        }
        
        if (supportsFullYUVRange)
        {
            photoOutput = [photoSettings p]
        }
        else
        {
            [photoOutput setOutputSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
        }
    }
    else
    {
        captureAsYUV = NO;
        [photoOutput setOutputSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
        [videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    }
    
    [self.captureSession addOutput:photoOutput];
    
    [self.captureSession commitConfiguration];
    
    self.jpegCompressionQuality = 0.8;
    
    return self;
}


@end
