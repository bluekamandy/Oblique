//
//  MKCameraGridView.h
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

#import <UIKit/UIKit.h>


@interface MK_CameraGridView : UIView


// The line width of a line. Default value is 1.0.
@property (nonatomic, assign) CGFloat lineWidth;

// The line color of a line. Default is white.
@property (nonatomic, assign) UIColor *lineColor;

//The number of the grid's columns
@property (nonatomic, assign) NSUInteger numberOfColumns;

// The number of the grid's rows
@property (nonatomic, assign) NSUInteger numberOfRows;

@end
