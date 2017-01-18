//
//  MK_LabelWithInsets.m
//  Oblique
//
//  Created by Masood on 1/17/17.
//  Copyright © 2017 Masood Kamandy. All rights reserved.
//

#import "MK_LabelWithInsets.h"

@implementation MK_LabelWithInsets
{
    float topInset;
    float leftInset;
    float bottomInset;
    float rightInset;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        topInset = 5;
        leftInset = 10;
        bottomInset = 5;
        rightInset = 10;
    }
    return self;
}

-(void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets myLabelInsets = {topInset, leftInset, bottomInset, rightInset};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, myLabelInsets)];
}

- (CGSize) intrinsicContentSize {
    CGSize intrinsicSuperViewContentSize = [super intrinsicContentSize] ;
    intrinsicSuperViewContentSize.height += topInset + bottomInset ;
    intrinsicSuperViewContentSize.width += leftInset + rightInset ;
    return intrinsicSuperViewContentSize ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
