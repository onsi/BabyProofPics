//
//  BPRandomColorView.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 8/7/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPRandomColorView.h"
#import "BPAnimationSupport.h"

@interface BPRandomColorView ()

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) NSUInteger currentColorIndex;
@property (nonatomic, assign) NSTimeInterval delay;
@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation BPRandomColorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup
{
    self.delay = 2.0;
    self.duration = 3.0;
    self.colors = @[
                    [UIColor colorWithRed:238/255.0 green:233/255.0 blue:233/255.0 alpha:1.0],
                    [UIColor colorWithRed:248/255.0 green:248/255.0 blue:255/255.0 alpha:1.0],
                    [UIColor colorWithRed:253/255.0 green:245/255.0 blue:230/255.0 alpha:1.0],
                    [UIColor colorWithRed:240/255.0 green:255/255.0 blue:240/255.0 alpha:1.0],
                    [UIColor colorWithRed:240/255.0 green:255/255.0 blue:255/255.0 alpha:1.0],
                    [UIColor colorWithRed:240/255.0 green:248/255.0 blue:255/255.0 alpha:1.0],
                    [UIColor colorWithRed:255/255.0 green:240/255.0 blue:245/255.0 alpha:1.0],
                    [UIColor colorWithRed:255/255.0 green:228/255.0 blue:225/255.0 alpha:1.0],
                    [UIColor colorWithRed:255/255.0 green:250/255.0 blue:205/255.0 alpha:1.0],
                    [UIColor colorWithRed:255/255.0 green:255/255.0 blue:240/255.0 alpha:1.0]
                    ];
    self.currentColorIndex = 0;

    self.layer.backgroundColor = [self.colors[self.currentColorIndex] CGColor];
    [self performSelector:@selector(changeColor) withObject:nil afterDelay:self.delay];
}

- (void)changeColor
{
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setDisableActions:YES];
    
    [BPAnimationSupport animateLayer:self.layer keyPath:@"backgroundColor" toValue:(id)self.nextRandomColor.CGColor withDuration:3.0 delay:0];
    
    [CATransaction commit];
    
    [self performSelector:@selector(changeColor) withObject:nil afterDelay:self.duration + self.delay];
}

- (UIColor *)nextRandomColor
{
    while (YES) {
        NSUInteger candidateIndex = arc4random_uniform(self.colors.count);
        if (candidateIndex != self.currentColorIndex) {
            self.currentColorIndex = candidateIndex;
            return self.colors[self.currentColorIndex];
        }
    }
}

@end
