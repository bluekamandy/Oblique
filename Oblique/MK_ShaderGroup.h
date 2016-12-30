//
//  MK_ShaderGroup.h
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
//
//  Adapted from:
//  https://github.com/xx11dragon/GPUImageFiltersCamera/tree/master/Test1030

#import "GPUImageFilterGroup.h"

@interface GPUImageFilterGroup (MK_addTitleAddPreview)

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconName;

@property (copy, nonatomic) NSString *(^informationFormatter)(CGFloat xPos, CGFloat yPos, CGFloat xDistance, CGFloat yDistance, CGFloat angle);

@property (nonatomic, copy) NSNumber *useLivePreviewObj;
@property (nonatomic, copy) NSNumber *usesTouch;

@property (nonatomic, copy) NSNumber *parameterObj;

@property (nonatomic, copy) NSValue *centerObj;

@end
