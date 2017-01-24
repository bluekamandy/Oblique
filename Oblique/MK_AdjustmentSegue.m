//
//  MK_DismissSegue.m
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
//  Last updated 12/31/2016
//
//  More information at masoodkamandy@gmail.com

#import "MK_AdjustmentSegue.h"
#import "ViewController.h"

@implementation MK_AdjustmentSegue

-(void)perform{
    UIViewController *sourceViewController = (UIViewController *) self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *) self.destinationViewController;
    
    [sourceViewController.view addSubview:destinationViewController.view];
    [destinationViewController.view setFrame:sourceViewController.view.window.frame];
    [destinationViewController.view setTransform:CGAffineTransformMakeTranslation(0, sourceViewController.view.frame.size.height)];
    [destinationViewController.view setAlpha:1.0];
    
    [UIView animateWithDuration:0.125
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [destinationViewController.view setTransform:CGAffineTransformMakeTranslation(0, 0)];
                         [destinationViewController.view setAlpha:1.0];
                     }
                     completion:^(BOOL finished){
                        [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];
                     }];}

@end
