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

@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UITextView *brightnessTextView;

@property (weak, nonatomic) IBOutlet UISlider *contrastSlider;
@property (weak, nonatomic) IBOutlet UITextView *contrastTextView;

@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UITextView *saturationTextView;

@property (weak, nonatomic) IBOutlet UISlider *hueSlider;
@property (weak, nonatomic) IBOutlet UITextView *hueTextView;

@property (weak, nonatomic) IBOutlet UISwitch *invertSwitch;

@end

@implementation MK_AdjustmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sharedCameraManager = [MK_GPUImageCameraManager sharedManager];
    
    self.brightnessSlider.value = sharedCameraManager.brightness;
    self.brightnessTextView.text = [NSString stringWithFormat:@"BRIGHTNESS %+.02f", sharedCameraManager.brightness];
    
    self.contrastSlider.value = sharedCameraManager.contrast;
    self.contrastTextView.text = [NSString stringWithFormat:@"CONTRAST %+.02f", sharedCameraManager.contrast];
    
    self.saturationSlider.value = sharedCameraManager.saturation;
    self.saturationTextView.text = [NSString stringWithFormat:@"SATURATION %+.02f", sharedCameraManager.saturation];
    
    self.hueSlider.value = sharedCameraManager.hue;
    self.hueTextView.text = [NSString stringWithFormat:@"HUE %.02f", sharedCameraManager.hue];
    
    self.invertSwitch.on = sharedCameraManager.invert;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sliders in Adjustment Menu

- (IBAction)brightnessSliderChanged:(id)sender {
    sharedCameraManager.brightness = [(UISlider *)sender value];
    self.brightnessTextView.text = [NSString stringWithFormat:@"BRIGHTNESS %+.02f", sharedCameraManager.brightness];
}

- (IBAction)contrastSliderChanged:(id)sender {
    sharedCameraManager.contrast = [(UISlider *)sender value];
    self.contrastTextView.text = [NSString stringWithFormat:@"CONTRAST %+.02f", sharedCameraManager.contrast];
    
}

- (IBAction)saturationSliderChanged:(id)sender {
    sharedCameraManager.saturation = [(UISlider *)sender value];
    self.saturationTextView.text = [NSString stringWithFormat:@"SATURATION %+.02f", sharedCameraManager.saturation];
    
}

- (IBAction)hueSliderChanged:(id)sender {
    sharedCameraManager.hue = [(UISlider *)sender value];
    self.hueTextView.text = [NSString stringWithFormat:@"HUE %.02f", sharedCameraManager.hue];
    
}
- (IBAction)invertSwitchChanged:(id)sender {
    sharedCameraManager.invert = [(UISwitch *)sender isOn];
}

- (IBAction)resetToDefaults:(id)sender {
    [sharedCameraManager resetAdjustmentsToDefaults];
    [UIView animateWithDuration:.25 animations:^{
        [self.brightnessSlider setValue:BRIGHTNESS_DEFAULT animated:YES];
        self.brightnessTextView.text = [NSString stringWithFormat:@"BRIGHTNESS %+.02f", sharedCameraManager.brightness];
    }];
    [UIView animateWithDuration:.25 animations:^{
        [self.contrastSlider setValue:CONTRAST_DEFAULT animated:YES];
        self.contrastTextView.text = [NSString stringWithFormat:@"CONTRAST %+.02f", sharedCameraManager.contrast];
    }];
    [UIView animateWithDuration:.25 animations:^{
        [self.saturationSlider setValue:SATURATION_DEFAULT animated:YES];
        self.saturationTextView.text = [NSString stringWithFormat:@"SATURATION %+.02f", sharedCameraManager.saturation];
    }];
    [UIView animateWithDuration:.25 animations:^{
        [self.hueSlider setValue:HUE_DEFAULT animated:YES];
        self.hueTextView.text = [NSString stringWithFormat:@"HUE %.02f", sharedCameraManager.hue];
    }];
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
