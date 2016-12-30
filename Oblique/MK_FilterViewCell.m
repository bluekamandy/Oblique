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

@property (nonatomic , strong) MK_Hexagon *hexView;
@property (nonatomic , strong) UIImageView *previewView;
@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation MK_FilterViewCell

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        sharedCameraManager = [MK_GPUImageCameraManager sharedManager];
        
        NSLog(@"initWithCoder : Cell"); // Only called 7 times so I'm assuming this is just called for visible cells.
//        _hexView = [[MK_Hexagon alloc] initWithFrame:CGRectMake(12.5, 12.5, 88.5, 88.5)];
        _filterView = [[GPUImageView alloc] initWithFrame:CGRectMake(15, 15, 85, 85)];
        _filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
//        [_hexView addSubview:_filterView];
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

- (void)setState:(UIControlState)state {
    
}

@end
