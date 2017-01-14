//
//  ViewController.m
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

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "MK_GPUImageCameraManager.h"
#import "MK_CameraGridView.h"
#import "Common.h"

@interface ViewController ()
{
    MK_GPUImageCameraManager *cameraManager;
    
    // Grid
    MK_CameraGridView *cameraGridView;
    int numberOfGridDivisions;
    
    // Info Field
    NSString *informationFieldText;
    
    // Touch
    CGFloat photoViewWidth;
    CGFloat photoViewHeight;
    UITouch *touch;
    CGPoint touchStartingCoord;
    CGPoint normalizedTouchStartingCoord;
    CGPoint touchEndingCoord;
    CGPoint normalizedTouchEndingCoord;
    CGPoint touchPoint;
    CGPoint normalizedTouchPoint;
    CGFloat angleOfTouch;
    CGFloat distanceOfTouch;
    CGFloat xDistance;
    CGFloat yDistance;
    
    BOOL fullScreen;
    
    NSOperationQueue *queue;
}

@property (strong, nonatomic) IBOutlet GPUImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *shutterReleaseButton;
@property (weak, nonatomic) IBOutlet UIButton *filterButton;
@property (weak, nonatomic) IBOutlet UIButton *adjustmentButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraGridButton;
@property (weak, nonatomic) IBOutlet UIButton *selfieButton;
@property (weak, nonatomic) IBOutlet UIButton *flashButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@property (weak, nonatomic) IBOutlet UITextView *informationField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [self.view updateConstraints];
    [self.view layoutSubviews];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    self.revealViewController.rearViewRevealWidth = 125;
    self.revealViewController.rearViewRevealOverdraw = 0;
    self.revealViewController.frontViewShadowOpacity = 0.0;
    
    //Constraint debugging
    NSLog(@"imageView %p",_imageView);
    NSLog(@"shutterReleaseButton %p",_shutterReleaseButton);
    NSLog(@"filterButton %p",_filterButton);
    NSLog(@"adjustmentButton %p",_adjustmentButton);
    NSLog(@"cameraGridButton %p",_cameraGridButton);
    NSLog(@"selfieButton %p",_selfieButton);
    NSLog(@"flashButton %p",_flashButton);
    NSLog(@"infoButton %p",_infoButton);
    NSLog(@"informationField %p",_informationField);
    
    if ( revealViewController )
    {
        [self.filterButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // Setup for touch events and grid.
    photoViewWidth = _imageView.bounds.size.width;
    photoViewHeight = _imageView.bounds.size.height;
    
    [self startCameraUp];
    
    // Setup for cameraGridView
    numberOfGridDivisions = 1;
    cameraGridView = [[MK_CameraGridView alloc] initWithFrame:CGRectMake(0, 0, photoViewWidth, photoViewHeight)];
    cameraGridView.lineColor = [UIColor whiteColor];
    cameraGridView.lineWidth = 0.5;
    [self.imageView addSubview:cameraGridView];
    [self.imageView bringSubviewToFront:cameraGridView];
    
    fullScreen = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Camera Code: Start Up

- (void)startCameraUp {
    
    cameraManager = [MK_GPUImageCameraManager sharedManager];
    
    [_imageView addSubview:[cameraManager createCameraViewWithFrame:CGRectMake(0, 0, _imageView.bounds.size.width, _imageView.bounds.size.height)]];
    NSLog(@"self.view.bounds.size is %@", NSStringFromCGSize(self.view.bounds.size));
    NSLog(@"_imageView.bounds.size is %@", NSStringFromCGSize(_imageView.bounds.size));
    
    // Set up brightness, contrast, saturation and hue
}

#pragma mark - Shutter Release

- (IBAction)shutterRelease:(id)sender {
    
    [cameraManager captureImage];
    
    // Kind of a hack. I wish I could just queue up the shutter releases, but it doesn't seem like I can do that. I'll have to learn more about multi-threading and semaphors to really understand what's going on.
    self.shutterReleaseButton.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.shutterReleaseButton.enabled = YES;
    });
    
    [UIView animateWithDuration:.05 delay:0 options:0 animations:^{
        self.view.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished)
     {
         
         
         
         [UIView animateWithDuration:.05 delay:0 options:0 animations:^{
             self.view.backgroundColor = [UIColor blackColor];
             
         } completion: nil];
     }];
}

#pragma mark - Small Buttons

- (IBAction)toggleFilters:(id)sender {
    
    [self.filterButton setSelected:!self.filterButton.selected];
    
    CGAffineTransform scale = CGAffineTransformMakeScale((self.view.bounds.size.width - 125)/self.view.bounds.size.width, (self.view.layer.bounds.size.width - 125)/self.view.layer.bounds.size.width);
    CGAffineTransform translate = CGAffineTransformMakeTranslation(-62.5, 0);
    
    if ([self.filterButton isSelected]) {
        
        self.imageView.layer.affineTransform = CGAffineTransformConcat(scale, translate);
    }
    
    if (![self.filterButton isSelected]) {
        self.imageView.layer.affineTransform = CGAffineTransformIdentity;
        //        self.imageView.frame = self.imageView.frame;
        
        
        
    }
    
}

- (IBAction)toggleAdjustments:(id)sender {
    
    [self toggleVisibilityOfButtons];
    
}



- (IBAction)toggleSelfie:(id)sender {
    
    UIView *blackScreen = [[UIView alloc] initWithFrame: CGRectMake(0, 0, photoViewWidth, photoViewHeight)];
    [blackScreen setBackgroundColor:[UIColor blackColor]];
    [self.imageView addSubview:blackScreen];
    [self.imageView bringSubviewToFront:blackScreen];
    
    if (cameraManager.stillCamera.cameraPosition == AVCaptureDevicePositionBack) {
        [cameraManager toggleSelfieCamera];
        [self.selfieButton setSelected:YES];
        self.flashButton.alpha = !self.flashButton.alpha;
        [UIView transitionWithView:self.imageView
                          duration:.5
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               [blackScreen setAlpha:1.0f];
                           }
                        completion:^(BOOL finished){
                            [UIView animateWithDuration:.5
                                                  delay:.1
                                                options:UIViewAnimationOptionCurveEaseOut
                                             animations:^{
                                                 [blackScreen setAlpha:0.0f];
                                             }
                                             completion:^(BOOL finished){
                                                 [blackScreen removeFromSuperview];
                                             }];
                        }];
    } else if (cameraManager.stillCamera.cameraPosition == AVCaptureDevicePositionFront) {
        [cameraManager toggleSelfieCamera];
        [self.selfieButton setSelected:NO];
        self.flashButton.alpha = !self.flashButton.alpha;
        
        [UIView transitionWithView:self.imageView
                          duration:.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                               [blackScreen setAlpha:1.0f];
                           }
                        completion:^(BOOL finished){
                            [UIView animateWithDuration:.5
                                                  delay: .1
                                                options:UIViewAnimationOptionCurveEaseOut
                                             animations:^{
                                                 [blackScreen setAlpha:0.0f];
                                                 
                                             }
                                             completion:^(BOOL finished){
                                                 [blackScreen removeFromSuperview];
                                             }];
                        }];
    }
    
    blackScreen = nil;
    
}

- (IBAction)toggleGrid:(id)sender {
    if (numberOfGridDivisions == 1) {
        
        // Split view into quarters.
        cameraGridView.numberOfColumns = numberOfGridDivisions;
        cameraGridView.numberOfRows = numberOfGridDivisions;
        [cameraGridView setHidden:NO];
        [self.cameraGridButton setSelected:YES];
        [cameraGridView setNeedsDisplay];
        numberOfGridDivisions++;
        
    } else if (numberOfGridDivisions > 1 && numberOfGridDivisions <= 3) {
        
        // Split into 9, then 16
        cameraGridView.numberOfColumns = numberOfGridDivisions;
        cameraGridView.numberOfRows = numberOfGridDivisions;
        [cameraGridView setNeedsDisplay];
        [self.cameraGridButton setSelected:YES];
        numberOfGridDivisions++;
        
    } else {
        
        // Turn grid back off.
        numberOfGridDivisions = 1;
        [cameraGridView setNeedsDisplay];
        [cameraGridView setHidden:YES];
        [self.cameraGridButton setSelected:NO];
    }
    
}

- (IBAction)toggleFlash:(id)sender {
    
    if (cameraManager.stillCamera.inputCamera.flashActive == NO) {
        [cameraManager turnFlashOn];
        [self.flashButton setSelected:YES];
        
    } else if (cameraManager.stillCamera.inputCamera.flashActive == YES) {
        [cameraManager turnFlashOff];
        [self.flashButton setSelected:NO];
        
    }
    
}

- (void)toggleVisibilityOfButtons {
    fullScreen = !fullScreen;
    [self fullScreenCamera:fullScreen];
    self.adjustmentButton.alpha = !self.adjustmentButton.alpha;
    self.filterButton.alpha = !self.filterButton.alpha;
    self.shutterReleaseButton.alpha = !self.shutterReleaseButton.alpha;
    self.selfieButton.alpha = !self.selfieButton.alpha;
    self.cameraGridButton.alpha = !self.cameraGridButton.alpha;
    if (!(cameraManager.stillCamera.cameraPosition == AVCaptureDevicePositionFront)) {
        self.flashButton.alpha = !self.flashButton.alpha;
    }
    self.infoButton.alpha = !self.infoButton.alpha;
}

- (void)fullScreenCamera:(BOOL)on {
    if (on) {
        [UIView animateWithDuration:.125 delay:0 options:0 animations:^{
            CGAffineTransform scale = CGAffineTransformMakeScale(
                                                                 (self.view.bounds.size.height/self.imageView.bounds.size.height),
                                                                 (self.view.bounds.size.height/self.imageView.bounds.size.height));
            CGAffineTransform translate = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height/2 - self.imageView.bounds.size.height/2 - 40);
            self.imageView.layer.affineTransform = CGAffineTransformConcat(scale, translate);
            NSLog(@"%f", self.imageView.frame.origin.y);
        } completion:nil ];
    } else {
        [UIView animateWithDuration:.125 delay:0 options:0 animations:^{
            self.imageView.layer.affineTransform = CGAffineTransformIdentity;
        }completion:nil];
    }
}


#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    touch = [[event allTouches] anyObject];
    touchStartingCoord = [touch locationInView:_imageView];
    
    normalizedTouchStartingCoord.x = touchStartingCoord.x / photoViewWidth;
    normalizedTouchStartingCoord.y = touchStartingCoord.y / photoViewHeight;
    
    //    NSLog(@"touchStartingCoord = %@", NSStringFromCGPoint(touchStartingCoord));
    //    NSLog(@"normalizedTouchStartingCoord = %@", NSStringFromCGPoint(normalizedTouchStartingCoord));
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    if (cameraManager.mainFilter) {
        // touch = [[event allTouches] anyObject];
        touchPoint = [touch locationInView:_imageView];
        
        // Normalize touch coordinates so that adjustments are consistent across devices
        normalizedTouchPoint.x = touchPoint.x / photoViewWidth;
        normalizedTouchPoint.y = touchPoint.y / photoViewHeight;
        
        // Make sure touch is inside _imageView.
        if (normalizedTouchPoint.x >= 0 && normalizedTouchPoint.x <= 1.0 && normalizedTouchPoint.y >= 0.0 && normalizedTouchPoint.y <= 1.0)
        {
            distanceOfTouch = distanceBetween(normalizedTouchStartingCoord, normalizedTouchPoint); // AKA hypoteneuse
            xDistance = normalizedTouchPoint.x - normalizedTouchStartingCoord.x;
            yDistance = normalizedTouchPoint.y - normalizedTouchStartingCoord.y;
            angleOfTouch = -atan2(yDistance, xDistance); // Negative because the coordinate system is reversed but I'd like it to be relative to the user.
            informationFieldText = [cameraManager changeFilterParameterUsingXPos:normalizedTouchPoint.x yPos:normalizedTouchPoint.y xDistance:xDistance yDistance:yDistance angle:angleOfTouch];
        }
        
        [self.informationField setText:informationFieldText];
        
        //        [UIView animateWithDuration:.25 animations:^{
        //            [self.informationField setAlpha:1.0];
        //        } completion:^(BOOL finished){
        //            [self.informationField setAlpha:0.0];
        //        }];
        
        
    }
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    touchEndingCoord = [touch locationInView:_imageView];
    
    normalizedTouchEndingCoord.x = touchEndingCoord.x / photoViewWidth;
    normalizedTouchEndingCoord.y = touchEndingCoord.y / photoViewHeight;
    
    NSLog(@"touchEndingCoord = %@", NSStringFromCGPoint(touchEndingCoord));
    NSLog(@"normalizedTouchEndingCoord = %@", NSStringFromCGPoint(normalizedTouchEndingCoord));
    NSLog(@"distanceOfTouch is %f", distanceOfTouch);
    NSLog(@"xDistance = %f and yDistance = %f", xDistance, yDistance);
    NSLog(@"angleOfTouch = %.2f", angleOfTouch);
    informationFieldText = @"";
    [self.informationField setText:informationFieldText];
}


@end
