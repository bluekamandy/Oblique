//
//  MK_Shader.m
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

#import "MK_Shader.h"
#import "MK_ShaderGroup.h"
#import "MK_GPUImageCustom3Input.h"
#import "Common.h"

@implementation MK_Shader

#pragma mark - Class Methods

// Reset
+ (GPUImageFilterGroup *) noFilter {
    GPUImageFilter *filter = [[MK_GPUImageCustom3Input alloc] init];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *) group setInitialFilters:[NSArray arrayWithObject: filter]];
    [(GPUImageFilterGroup *) group setTerminalFilter:filter];
    group.title = @"No Filter";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}

// Filter Presets

+ (GPUImageFilterGroup *)rainbow {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Rainbow"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Rainbow";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        
        NSString *string = [NSString stringWithFormat:@""];
        return string;
        
    };
    
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
}


+ (GPUImageFilterGroup *)colorCompress {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Color_Compress"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Color Compress";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        
        //        CGFloat newX = map(xPos, 0.0, 1.0, 0.0, 20.0);
        //
        //        NSString *string = [NSString stringWithFormat:@"X: %1.2f", newX];
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
}


+ (GPUImageFilterGroup *)rgbSeparation {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_RGB_Separation"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"RGB Separation";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        
        //        NSString *string = [NSString stringWithFormat:@"X: %1.2f Y: %1.2f", xPos, yPos];
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
}


+ (GPUImageFilterGroup *)noiseWarp {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_NoiseWarp"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Noise Warp";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
}

+ (GPUImageFilterGroup *)mrPerlin {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_MrPerlin"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Mr Perlin";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        
        //        NSString *string = [NSString stringWithFormat:@"X: %1.2f Y: %1.2f", xPos, yPos];
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
}



+ (GPUImageFilterGroup *)colorCycleFilter {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_ColorCycle"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Color Cycle";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        
        //        CGFloat red = fmod(xPos, 1);
        //        CGFloat green = fmod(yPos, 1);
        //        CGFloat blue = fmod(xPos/yPos, 1);
        //
        //        NSString *string = [NSString stringWithFormat:@"R +%1.2f  G +%1.2f  B +%1.2f", red, green, blue];
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
}

+ (GPUImageFilterGroup *)grid {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_GridImage"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Grid";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        
        CGFloat x = floor(xPos * 20.0);
        
        NSString *string = [NSString stringWithFormat:@"%1.0f x %1.0f Grid", x, x];
        return string;
    };
    
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
}

+ (GPUImageFilterGroup *)tunnel {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Tunnel"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Tunnel";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        //        CGFloat newX = map(xPos, 0.0, 1.0, 0.0, 20.0);
        //        // Reversed the numbers so it makes more sense to the user
        //        NSString *string = [NSString stringWithFormat:@"X:+%1.2f", newX];
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
    
}

+ (GPUImageFilterGroup *)waves {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Waves" timerOn:YES ];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Waves";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        //        NSString *string = [NSString stringWithFormat:@"X: %1.2f  Y: %1.2f", xPos, yPos];
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
    
}

+ (GPUImageFilterGroup *)shear {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Shear"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Shear";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        //        NSString *string = [NSString stringWithFormat:@"X: %1.2f  Y: %1.2f", xPos, yPos];
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
    
}

+ (GPUImageFilterGroup *)stretch {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Stretch"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Stretch";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        //        NSString *string = [NSString stringWithFormat:@"X: %1.2f  Y: %1.2f", xPos, yPos];
        NSString *string = [NSString stringWithFormat:@""];
        return string;
    };
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
    
}


+ (GPUImageFilterGroup *)polarStripes {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Polar"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Polar Stripes";
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}

+ (GPUImageFilterGroup *)verticalStripes {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_VerticalStripes"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"V Stripes";
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
    
}

+ (GPUImageFilterGroup *)horizontalStripes {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_HorizontalStripes"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"H Stripes";
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}

+ (GPUImageFilterGroup *)verticalMirror {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_VerticalMirror"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"V Mirror";
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}

+ (GPUImageFilterGroup *)horizontalMirror {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_HorizontalMirror"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"H Mirror";
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}

+ (GPUImageFilterGroup *)overMirror {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_overMirror"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"overMirror";
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}


+ (GPUImageFilterGroup *)fourScope {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_4Scope"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"4 Scope";
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}


+ (GPUImageFilterGroup *)fourSplit {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_4Split"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"4 Split";
    group.informationFormatter = ^(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle) {
        CGFloat remappedX = map(xPos, 0., 1., -0.01, .5);
        NSString *string = [NSString stringWithFormat:@"X:+%1.2f", remappedX];
        return string;
    };
    
    group.useLivePreviewObj = [NSNumber numberWithBool:YES];
    group.usesTouch = [NSNumber numberWithBool:YES];
    group.iconName = @"Polygon";
    return group;
}


// Image Adjustment Filters (NOT CURRENTLY USED)

+ (GPUImageFilterGroup *)brightness {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Brightness"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Brightness";
    group.useLivePreviewObj = [NSNumber numberWithBool:NO];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}

+ (GPUImageFilterGroup *)contrast {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Contrast"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Contrast";
    group.useLivePreviewObj = [NSNumber numberWithBool:NO];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
    
}

+ (GPUImageFilterGroup *)saturation {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Saturation"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Saturation";
    group.useLivePreviewObj = [NSNumber numberWithBool:NO];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
    
}

+ (GPUImageFilterGroup *)hue {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Hue"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Hue";
    group.useLivePreviewObj = [NSNumber numberWithBool:NO];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
    
}

+ (GPUImageFilterGroup *)invert {
    MK_GPUImageCustom3Input *filter = [[MK_GPUImageCustom3Input alloc] initWithFragmentShaderFromFile:@"MK_FShader_Invert"];
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Invert";
    group.useLivePreviewObj = [NSNumber numberWithBool:NO];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}


+ (GPUImageFilterGroup *)sharpness {
    GPUImageSharpenFilter *filter = [[GPUImageSharpenFilter alloc] init];
    filter.sharpness = 25.0;
    GPUImageFilterGroup *group = [[GPUImageFilterGroup alloc] init];
    [(GPUImageFilterGroup *)group setInitialFilters:[NSArray arrayWithObject:filter]];
    [(GPUImageFilterGroup *)group setTerminalFilter:filter];
    group.title = @"Sharpness";
    group.useLivePreviewObj = [NSNumber numberWithBool:NO];
    group.usesTouch = [NSNumber numberWithBool:NO];
    group.iconName = @"Polygon";
    return group;
}

// Tools
+ (GPUImageFilterGroup *)addFilter:(GPUImageFilterGroup *)newFilter toCurrentFilter:(GPUImageFilterGroup *)currentFilter{
    GPUImageFilterGroup *replacementFilterGroup = [[GPUImageFilterGroup alloc] init];
    for (id GPUImageFilter in currentFilter.initialFilters) {
        [replacementFilterGroup addFilter:GPUImageFilter];
    }
    for (id GPUImageFilter in newFilter.initialFilters) {
        [replacementFilterGroup addFilter:GPUImageFilter];
    }
    [replacementFilterGroup setTerminalFilter:[newFilter.initialFilters objectAtIndex:newFilter.filterCount]];
    
    return replacementFilterGroup;
}

+ (GPUImageFilterGroup *)removeFilter:(GPUImageFilterGroup *)filterToRemove fromCurrentFilter:(GPUImageFilterGroup *)currentFilter {
    
    GPUImageFilterGroup *replacementFilterGroup = [[GPUImageFilterGroup alloc] init];
    
    for (id currentFilterIndex in currentFilter.initialFilters) {
        for (id filterToRemoveIndex in filterToRemove.initialFilters) {
            if (currentFilterIndex != filterToRemoveIndex) {
                [replacementFilterGroup addFilter:currentFilterIndex];
            }
        }
    }
    
    [replacementFilterGroup setTerminalFilter:[replacementFilterGroup.initialFilters objectAtIndex:replacementFilterGroup.filterCount]];
    
    return replacementFilterGroup;
    
}

#pragma mark - Initializer

- (id)init {
    
    self = [super init];
    
    _filtersAvailable = @{@"Filter-Free" : @[@"noFilter"],
                          @"Interactive" :     @[@"grid",
                                                 @"stretch",
                                                 @"shear",
                                                 @"waves",
                                                 @"tunnel",
                                                 @"fourSplit",
                                                 @"rainbow",
                                                 @"colorCompress",
                                                 @"rgbSeparation",
                                                 @"colorCycleFilter",
                                                 @"mrPerlin",
                                                 @"noiseWarp"],
                          @"Non-Interactive" : @[@"horizontalMirror",
                                                 @"verticalMirror",
                                                 @"fourScope",
                                                 @"overMirror",
                                                 @"verticalStripes",
                                                 @"horizontalStripes",
                                                 @"polarStripes"]
                          };
    
    _filterSectionTitles = [[_filtersAvailable allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    //    NSLog(@"This is the order of the titles: %@", [_filtersAvailable allKeys]);
    
    
    //    _adjustmentsAvailable = [NSArray arrayWithObjects:
    //                             @"brightness",
    //                             @"contrast",
    //                             @"saturation",
    //                             @"hue",
    //                             @"sharpness",
    //                             nil];
    
    return self;
}

@end
