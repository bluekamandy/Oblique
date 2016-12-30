//
//  MK_PausableTimer.h
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
//
//  CSPausibleTimer
//  https://github.com/codeslaw/CSPausibleTimer
//
//  Created by Chris Shaheen on 3/28/13.
//  Copyright (c) 2013 Codeslaw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MK_PausableTimer : NSObject

//Timer Info
@property (nonatomic) NSTimeInterval timeInterval;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;
@property (nonatomic) id userInfo;
@property (nonatomic) BOOL repeats;

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isPaused;

+(MK_PausableTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats;

-(void)pause;
-(void)start;

@end
