//
//  MK_Shader.h
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

@class MK_GPUImageCustom3Input;


@interface MK_Shader : NSObject
    
    {
        MK_GPUImageCustom3Input *filter;
        GPUImageFilter *noFilter;
    }
    
    @property (nonatomic, readonly, strong) NSArray *filtersAvailable;
    @property (nonatomic, readonly, strong) NSArray *adjustmentsAvailable;
    @property (nonatomic, readonly, strong) NSString *filterName; // name of filter
    @property (nonatomic, readonly, strong) NSString *shaderFileName;
    @property (nonatomic) BOOL needsTimer;
    
    // FILTER METHODS: Presets and tools
    
    // Reset
+ (GPUImageFilterGroup *)noFilter;
    
    // Presets
+ (GPUImageFilterGroup *)noiseWarp;
+ (GPUImageFilterGroup *)mrPerlin;
+ (GPUImageFilterGroup *)colorCycleFilter;
+ (GPUImageFilterGroup *)grid;
+ (GPUImageFilterGroup *)tunnel;
+ (GPUImageFilterGroup *)waves;
+ (GPUImageFilterGroup *)shear;
+ (GPUImageFilterGroup *)stretch;
+ (GPUImageFilterGroup *)polarStripes;
+ (GPUImageFilterGroup *)verticalStripes;
+ (GPUImageFilterGroup *)horizontalStripes;
+ (GPUImageFilterGroup *)verticalMirror;
+ (GPUImageFilterGroup *)horizontalMirror;
+ (GPUImageFilterGroup *)overMirror;
+ (GPUImageFilterGroup *)fourScope;
+ (GPUImageFilterGroup *)fourSplit;
    
    // Image Adjustment Filters
+ (GPUImageFilterGroup *)brightness;
+ (GPUImageFilterGroup *)contrast;
+ (GPUImageFilterGroup *)saturation;
+ (GPUImageFilterGroup *)hue;
+ (GPUImageFilterGroup *)invert;
+ (GPUImageFilterGroup *)sharpness;
    
    // Tools
+ (GPUImageFilterGroup *)addFilter:(GPUImageFilterGroup *)newFilter toCurrentFilter:(GPUImageFilterGroup *)currentFilter;
    
+ (GPUImageFilterGroup *)removeFilter:(GPUImageFilterGroup *)filterToRemove fromCurrentFilter:(GPUImageFilterGroup *)currentFilter;
    
    
    @end
