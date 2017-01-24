//
//  MK_AdjustmentViewController.m
//  Oblique
//
//  Created by Masood on 1/1/17.
//  Copyright © 2017 Masood Kamandy. All rights reserved.
//

#import "MK_AdjustmentViewController.h"
#import "MK_GPUImageCameraManager.h"

@interface MK_AdjustmentViewController ()
{
    MK_GPUImageCameraManager *sharedCameraManager;
}

@property (weak, nonatomic) IBOutlet UISwitch *toneMapSwitch;
@property (weak, nonatomic) IBOutlet UILabel *toneMapLabel;

@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;

@property (weak, nonatomic) IBOutlet UISlider *contrastSlider;
@property (weak, nonatomic) IBOutlet UILabel *contrastLabel;

@property (weak, nonatomic) IBOutlet UISlider *colorTemperatureSlider;
@property (weak, nonatomic) IBOutlet UILabel *colorTemperatureLabel;

@property (weak, nonatomic) IBOutlet UISlider *tintSlider;
@property (weak, nonatomic) IBOutlet UILabel *tintLabel;

@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UILabel *saturationLabel;

@property (weak, nonatomic) IBOutlet UISlider *hueSlider;
@property (weak, nonatomic) IBOutlet UILabel *hueLabel;

@property (weak, nonatomic) IBOutlet UISwitch *invertSwitch;
@property (weak, nonatomic) IBOutlet UILabel *invertLabel;

@property (weak, nonatomic) IBOutlet UISwitch *equalizeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *equalizeLabel;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@end

@implementation MK_AdjustmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAllControlsVisible) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    sharedCameraManager = [MK_GPUImageCameraManager sharedManager];
    
    self.toneMapSwitch.on = sharedCameraManager.toneMapValue;
    
    self.brightnessSlider.value = sharedCameraManager.brightness;
    self.brightnessLabel.text = [NSString stringWithFormat:@"BRIGHTNESS %+.02f", sharedCameraManager.brightness];
    
    self.contrastSlider.value = sharedCameraManager.contrast;
    self.contrastLabel.text = [NSString stringWithFormat:@"CONTRAST %+.02f", sharedCameraManager.contrast];
    
    self.colorTemperatureSlider.value = sharedCameraManager.temperature;
    self.colorTemperatureLabel.text = [NSString stringWithFormat:@"TEMPERATURE"];
    
    self.tintSlider.value = sharedCameraManager.tint;
    self.tintLabel.text = [NSString stringWithFormat:@"TINT %+.00f", sharedCameraManager.tint];
    
    self.saturationSlider.value = sharedCameraManager.saturation;
    self.saturationLabel.text = [NSString stringWithFormat:@"SATURATION %+.02f", sharedCameraManager.saturation];
    
    self.hueSlider.value = sharedCameraManager.hue;
    self.hueLabel.text = [NSString stringWithFormat:@"HUE %.02f", sharedCameraManager.hue];
    
    self.invertSwitch.on = sharedCameraManager.invert;
    
    self.equalizeSwitch.on = sharedCameraManager.equalize;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Handle Animation of Fades

- (void)fadeControlsExcept:(id)currentSlider toAlpha:(CGFloat)newAlpha {
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.equalizeSwitch.alpha = newAlpha;
                         self.equalizeLabel.alpha = newAlpha;
                         self.toneMapSwitch.alpha = newAlpha;
                         self.toneMapLabel.alpha = newAlpha;
                         
                         if (currentSlider != self.brightnessSlider) {
                             self.brightnessSlider.alpha = newAlpha;
                             self.brightnessLabel.alpha = newAlpha;
                         }
                         
                         if (currentSlider != self.contrastSlider) {
                             self.contrastSlider.alpha = newAlpha;
                             self.contrastLabel.alpha = newAlpha;
                         }
                         
                         if (currentSlider != self.colorTemperatureSlider) {
                             self.colorTemperatureSlider.alpha = newAlpha;
                             self.colorTemperatureLabel.alpha = newAlpha;
                         }
                         
                         if (currentSlider != self.tintSlider) {
                             self.tintSlider.alpha = newAlpha;
                             self.tintLabel.alpha = newAlpha;
                         }
                         
                         if (currentSlider != self.saturationSlider) {
                             self.saturationSlider.alpha = newAlpha;
                             self.saturationLabel.alpha = newAlpha;
                         }
                         
                         if (currentSlider != self.hueSlider) {
                             self.hueSlider.alpha = newAlpha;
                             self.hueLabel.alpha = newAlpha;
                         }
                         
                         self.invertSwitch.alpha = newAlpha;
                         self.invertLabel.alpha = newAlpha;
                         self.resetButton.alpha = newAlpha;
                         self.exitButton.alpha = newAlpha;
                         
                     } completion:nil
     ];
    
}

- (void)setAllControlsVisible {
    
    CGFloat newAlpha = 1.0;
    self.equalizeSwitch.alpha = newAlpha;
    self.equalizeLabel.alpha = newAlpha;
    self.toneMapSwitch.alpha = newAlpha;
    self.toneMapLabel.alpha = newAlpha;
    self.brightnessSlider.alpha = newAlpha;
    self.brightnessLabel.alpha = newAlpha;
    self.contrastSlider.alpha = newAlpha;
    self.contrastLabel.alpha = newAlpha;
    self.colorTemperatureSlider.alpha = newAlpha;
    self.colorTemperatureLabel.alpha = newAlpha;
    self.tintSlider.alpha = newAlpha;
    self.tintLabel.alpha = newAlpha;
    self.saturationSlider.alpha = newAlpha;
    self.saturationLabel.alpha = newAlpha;
    self.hueSlider.alpha = newAlpha;
    self.hueLabel.alpha = newAlpha;
    self.invertSwitch.alpha = newAlpha;
    self.invertLabel.alpha = newAlpha;
    self.resetButton.alpha = newAlpha;
    self.exitButton.alpha = newAlpha;
}

#pragma mark - Sliders in Adjustment Menu

- (IBAction)toneMapSwitchChanged:(id)sender {
    sharedCameraManager.toneMapValue = [(UISwitch *)sender isOn];
}

- (IBAction)brightnessSliderChanged:(id)sender {
    sharedCameraManager.brightness = [(UISlider *)sender value];
    self.brightnessLabel.text = [NSString stringWithFormat:@"BRIGHTNESS %+.02f", sharedCameraManager.brightness];
}

- (IBAction)brightnessDidStartDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:0.1];
    NSLog(@"Fade Out");
}

- (IBAction)brightnessDidFinishDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:1.0];
    NSLog(@"Fade In");
}

- (IBAction)contrastSliderChanged:(id)sender {
    sharedCameraManager.contrast = [(UISlider *)sender value];
    self.contrastLabel.text = [NSString stringWithFormat:@"CONTRAST %+.02f", sharedCameraManager.contrast];
}

- (IBAction)contrastDidStartDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:0.1];
}

- (IBAction)contrastDidFinishDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:1.0];
}

- (IBAction)temperatureSliderChanged:(id)sender {
    sharedCameraManager.temperature = [(UISlider *)sender value];
    self.colorTemperatureLabel.text = [NSString stringWithFormat:@"TEMPERATURE %+.00f K", sharedCameraManager.temperature - 5000.f];
}

- (IBAction)temparatureDidStartDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:0.1];
}

- (IBAction)tempratureDidFinishDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:1.0];
}

- (IBAction)tintSliderChanged:(id)sender {
    sharedCameraManager.tint = [(UISlider *)sender value];
    self.tintLabel.text = [NSString stringWithFormat:@"TINT %+.00f", sharedCameraManager.tint];
}

- (IBAction)tintDidStartDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:0.1];
}

- (IBAction)tintDidFinishDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:1.0];
}

- (IBAction)saturationSliderChanged:(id)sender {
    sharedCameraManager.saturation = [(UISlider *)sender value];
    self.saturationLabel.text = [NSString stringWithFormat:@"SATURATION %+.02f", sharedCameraManager.saturation];
}

- (IBAction)saturationDidStartDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:0.1];
}

- (IBAction)saturationDidFinishDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:1.0];
}

- (IBAction)hueSliderChanged:(id)sender {
    sharedCameraManager.hue = [(UISlider *)sender value];
    self.hueLabel.text = [NSString stringWithFormat:@"HUE %.02f", sharedCameraManager.hue];
}
- (IBAction)hueDidStartDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:0.1];
}

- (IBAction)hueDidFinishDragging:(id)sender {
    [self fadeControlsExcept:sender toAlpha:1.0];
}

- (IBAction)invertSwitchChanged:(id)sender {
    sharedCameraManager.invert = [(UISwitch *)sender isOn];
}

- (IBAction)equalizeSwitchChanged:(id)sender {
    sharedCameraManager.equalize = [(UISwitch *)sender isOn];
}

- (IBAction)resetToDefaults:(id)sender {
    [sharedCameraManager resetAdjustmentsToDefaults];
    
    [UIView animateWithDuration:.25 animations:^{
        [self.brightnessSlider setValue:BRIGHTNESS_DEFAULT animated:YES];
        self.brightnessLabel.text = [NSString stringWithFormat:@"BRIGHTNESS %+.02f", sharedCameraManager.brightness];
        
        [self.contrastSlider setValue:CONTRAST_DEFAULT animated:YES];
        self.contrastLabel.text = [NSString stringWithFormat:@"CONTRAST %+.02f", sharedCameraManager.contrast];
        
        [self.colorTemperatureSlider setValue:TEMPERATURE_DEFAULT animated:YES];
        self.colorTemperatureLabel.text = [NSString stringWithFormat:@"TEMPERATURE"];
        
        [self.tintSlider setValue:TINT_DEFAULT animated:YES];
        self.tintLabel.text = [NSString stringWithFormat:@"TINT %+.00f", sharedCameraManager.tint];
        
        [self.saturationSlider setValue:SATURATION_DEFAULT animated:YES];
        self.saturationLabel.text = [NSString stringWithFormat:@"SATURATION %+.02f", sharedCameraManager.saturation];
        
        [self.hueSlider setValue:HUE_DEFAULT animated:YES];
        self.hueLabel.text = [NSString stringWithFormat:@"HUE %.02f", sharedCameraManager.hue];
        
        [self.invertSwitch setOn:INVERT_DEFAULT animated:YES];
        [self.equalizeSwitch setOn:EQUALIZE_DEFAULT animated:YES];
        [self.toneMapSwitch setOn:TONEMAP_DEFAULT animated:YES];
    }];
}

- (IBAction)exitAdjustments:(id)sender {
    [UIView animateWithDuration:0.75
                          delay:0.0
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         [self.view setTransform:CGAffineTransformMakeTranslation(0, -self.view.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         [self dismissViewControllerAnimated:NO completion:nil];
                     }
     ];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
