//
//  BPTappableCircularView.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/17/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPTappableCircularView.h"
#import "BPCircularTapGestureRecognizer.h"
#import <QuartzCore/QuartzCore.h>
#import "BPMath.h"

@interface BPTappableCircularView ()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, strong) BPCircularTapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) BOOL isPulsing;

@end

@implementation BPTappableCircularView

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
    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self setUpCircularMask];
    [self addSubview:self.contentView];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setUpCircularMask
{
    self.contentView.layer.mask = [CALayer layer];
    self.circularMask.backgroundColor = [[UIColor blackColor] CGColor];
    self.circularMask.position = CGPointAtCenterOfRect(self.bounds);
    self.circularMask.bounds = self.bounds;
    self.circularMask.cornerRadius = self.bounds.size.width / 2.0;
    self.circularMask.masksToBounds = NO;
}

- (CALayer *)contentLayer
{
    return self.contentView.layer;
}

- (CALayer *)circularMask
{
    return self.contentView.layer.mask;
}

- (void)setTapTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
    if (!self.tapGestureRecognizer) {
        self.tapGestureRecognizer = [[BPCircularTapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTapGestureRecognizer:)];
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Started Tap
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        // Ended Tap
        [self handleTap];
    }
}

- (void)handleTap
{
    if (self.target && [self.target respondsToSelector:self.action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.action
                          withObject:self];
#pragma clang diagnostic pop
    }
}

@end
