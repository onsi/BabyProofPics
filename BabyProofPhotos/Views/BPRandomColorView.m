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
    self.colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor]];
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
