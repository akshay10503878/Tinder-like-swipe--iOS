//
//  UIViewX.m
//  FloatingMenu
//
//  Created by akshay bansal on 10/25/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import "UIViewX.h"

@implementation UIViewX


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.startColor     = [UIColor whiteColor];
        self.midColor       = [UIColor whiteColor];
        self.endColor       = [UIColor whiteColor];
        self.borderWidth    = 2;
        self.cornerRadious  = 10;
        self.isHorizontal   = NO;
        
        [self customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [self customInit];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}


- (void)prepareForInterfaceBuilder {
    
    [self customInit];
}

- (void)customInit {
    
    
    self.layer.cornerRadius = self.cornerRadious;
    self.layer.borderWidth = self.borderWidth;
    
    if (self.cornerRadious > 0) {
        self.layer.masksToBounds = YES;
    }
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    gradient.colors = [NSArray arrayWithObjects:(id)[self.startColor CGColor],(id)[self.midColor CGColor], (id)[self.endColor CGColor], nil];
    gradient.endPoint = (self.isHorizontal) ? CGPointMake(1, 0) : CGPointMake(0, 1);
    [self.layer insertSublayer:gradient atIndex:0];
    
}

@end
