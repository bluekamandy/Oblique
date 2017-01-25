//
//  MK_FilterViewCell.m
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

#import "MK_FilterViewCell.h"
#import "MK_GPUImageCameraManager.h"
#import "MK_GPUImageCustom3Input.h"
#import "MK_ShaderGroup.h"
#import "MK_Shader.h"

@interface MK_FilterViewCell ()
{
    MK_GPUImageCameraManager *sharedCameraManager;
}


@end

@implementation MK_FilterViewCell

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        sharedCameraManager = [MK_GPUImageCameraManager sharedManager];
        
        _filterView = [[GPUImageView alloc] initWithFrame:CGRectMake(20, 15, 85, 85)];
        
        _filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
        [self.contentView addSubview:_filterView];
        
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    if (!tableWidth) {
        tableWidth = 125;
    }
    frame.size.width = tableWidth;
    [super setFrame:frame];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [sharedCameraManager.stillCamera removeTarget:self.filterGroup];
    
    
}

- (void)setHighlighted:(BOOL)highlighted {
    NSLog(@"setHighlighted custom override");
    if (highlighted) {
        self.filterView.layer.borderColor = [UIColor yellowColor].CGColor;
        self.filterView.layer.borderWidth = 5.0f;
    } else {
        self.filterView.layer.borderColor = [UIColor clearColor].CGColor;
        self.filterView.layer.borderWidth = 0.0f;
        
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.filterView.layer.borderColor = [UIColor yellowColor].CGColor;
        self.filterView.layer.borderWidth = 5.0f;
        
    } else {
        self.filterView.layer.borderColor = [UIColor clearColor].CGColor;
        self.filterView.layer.borderWidth = 0.0f;
        
    }
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.filterView.layer.borderColor = [UIColor yellowColor].CGColor;
        self.filterView.layer.borderWidth = 5.0f;
        
    } else {
        self.filterView.layer.borderColor = [UIColor clearColor].CGColor;
        self.filterView.layer.borderWidth = 0.0f;
        
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        self.filterView.layer.borderColor = [UIColor yellowColor].CGColor;
        self.filterView.layer.borderWidth = 5.0f;
        
    } else {
        self.filterView.layer.borderColor = [UIColor clearColor].CGColor;
        self.filterView.layer.borderWidth = 0.0f;
        
    }
    
}

@end
