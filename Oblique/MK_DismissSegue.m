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

#import "MK_DismissSegue.h"
#import "ViewController.h"

@implementation MK_DismissSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    
    [(ViewController *)sourceViewController.presentingViewController.childViewControllers[1] toggleVisibilityOfButtons];

    
    [UIView animateWithDuration:0.125
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.sourceViewController.view setTransform:CGAffineTransformMakeTranslation(0, self.sourceViewController.view.frame.size.height)];
                     }
                     completion:^(BOOL finished){

                         [(ViewController *)sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];

                     }
     ];
}


@end
