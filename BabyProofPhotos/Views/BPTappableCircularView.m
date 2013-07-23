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
    self.contentView = [UIView new];
    self.contentView.frame = self.bounds;
    self.contentView.layer.cornerRadius = self.bounds.size.width / 2.0;
    self.contentView.layer.masksToBounds = YES;
    [self addSubview:self.contentView];
    self.backgroundColor = [UIColor clearColor];
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
        [self startPulsing];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self stopPulsing];
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

- (void)startPulsing
{
    self.isPulsing = YES;
    [self pulse];
}

- (void)stopPulsing
{
    self.isPulsing = NO;
}

- (void)pulse
{
    if (self.isPulsing) {
        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentView.transform = CGAffineTransformMakeScale(1.07, 1.07);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn animations:^{
                self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                [self pulse];
            }];
        }];
    }
}

@end
