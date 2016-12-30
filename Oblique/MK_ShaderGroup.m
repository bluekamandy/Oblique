//
//  MK_ShaderGroup.m
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


#import "MK_ShaderGroup.h"
#import <objc/runtime.h>

static char GPUImageFilterGroupTitleKey;
static char GPUImageFilterGroupIconNameKey;
static char GPUimageFilterGroupInformationBlockKey;
static char GPUImageFilterGroupUseLivePreviewKey;
static char GPUImageFilterGroupUsesTouchKey;
static char GPUImageFilterGroupParameterKey;
static char GPUImageFilterGroupCenterKey;

@implementation GPUImageFilterGroup (MK_addTitleAddPreview)

- (void)setTitle:(NSString *)title {
    [self willChangeValueForKey:@"GPUImageFilterGroupTitleKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupTitleKey, title, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"GPUImageFilterGroupTitleKey"];
}

- (NSString *)title {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupTitleKey);
}

- (void)setIconName:(NSString *)iconName {
    [self willChangeValueForKey:@"GPUImageFilterGroupIconNameKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupIconNameKey, iconName, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"GPUImageFilterGroupIconNameKey"];
}

- (NSString *)iconName {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupIconNameKey);
}

- (void)setInformationFormatter:(NSString *(^)(CGFloat, CGFloat, CGFloat, CGFloat, CGFloat))informationFormatter {
    [self willChangeValueForKey:@"GPUimageFilterGroupInformationBlockKey"];
    objc_setAssociatedObject(self, &GPUimageFilterGroupInformationBlockKey, informationFormatter, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"GPUimageFilterGroupInformationBlockKey"];
}

- (NSString *(^)(CGFloat, CGFloat, CGFloat, CGFloat, CGFloat))informationFormatter {
    return objc_getAssociatedObject(self, &GPUimageFilterGroupInformationBlockKey);
}

- (void)setUseLivePreviewObj:(NSNumber *)yesOrNo {
    [self willChangeValueForKey:@"GPUImageFilterGroupUseLivePreviewKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupUseLivePreviewKey, yesOrNo, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"GPUImageFilterGroupUseLivePreviewKey"];
}

- (NSNumber *)useLivePreviewObj {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupUseLivePreviewKey);
}

- (void)setUsesTouch:(NSNumber *)yesOrNo {
    [self willChangeValueForKey:@"GPUImageFilterGroupUsesTouchKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupUsesTouchKey, yesOrNo, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"GPUImageFilterGroupUsesTouchKey"];
}

- (NSNumber *)usesTouch {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupUsesTouchKey);
}


- (void)setParameterObj:(NSNumber *)parameterObj {
    [self willChangeValueForKey:@"GPUImageFilterGroupParameterKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupParameterKey, parameterObj, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"GPUImageFilterGroupParameterKey"];
}

- (NSNumber *)parameterObj {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupParameterKey);
}

- (void)setCenterObj:(NSValue *)centerObj {
    [self willChangeValueForKey:@"GPUImageFilterGroupCenterKey"];
    objc_setAssociatedObject(self, &GPUImageFilterGroupCenterKey, centerObj, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"GPUImageFilterGroupCenterKey"];
}

- (NSValue *)centerObj {
    return objc_getAssociatedObject(self, &GPUImageFilterGroupCenterKey);
}


@end
