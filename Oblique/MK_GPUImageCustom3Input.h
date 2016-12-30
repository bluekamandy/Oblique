//
//  MK_GPUImageCustom3Input.h
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

#import "GPUImageFilter.h"
#import <GPUImage/GPUImage.h>

@interface MK_GPUImageCustom3Input : GPUImageFilter 
{
    GLint parameterUniform;
    GLint centerUniform;
    GLint timeUniform;
}

// 3 properties. One is a custom parameter. One is a touch coordinate. One is a read-only time interval.
@property(readwrite, nonatomic) CGFloat parameter;
@property(readwrite, nonatomic) CGPoint center;

- (id)initWithFragmentShaderFromFile:(NSString *)fragmentShaderFilename timerOn:(BOOL)timer;

@end
