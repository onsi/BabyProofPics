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
    self.layer.cornerRadius = self.bounds.size.width / 2.0;
    self.layer.masksToBounds = YES;
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
    if (self.target && [self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action
                          withObject:self];
    }
}

@end
