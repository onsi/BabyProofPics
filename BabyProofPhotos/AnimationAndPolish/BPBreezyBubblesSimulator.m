//
//  BPBreezyBubblesSimulator.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/20/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPBreezyBubblesSimulator.h"
#import "BPMath.h"

@interface BPBreezyBubblesSimulator ()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIPushBehavior *windBehavior;

@end

@implementation BPBreezyBubblesSimulator

- (id)initWithReferenceFrame:(UIView *)referenceFrame views:(NSArray *)views
{
    self = [super init];
    if (self) {
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:referenceFrame];
        [self setUpBubbleElasticity:views];
        [self setUpCollisions:views];
        [self setUpAttachments:views];
        [self startWind:views];
        [self blow];
    }
    return self;
}

- (void)setUpBubbleElasticity:(NSArray *)views
{
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:views];
    itemBehavior.elasticity = 0.7;
    [self.animator addBehavior:itemBehavior];
}

- (void)setUpCollisions:(NSArray *)views
{
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:views];
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(-100, -100, -100, -100)];
    [self.animator addBehavior:collisionBehavior];
}

- (void)setUpAttachments:(NSArray *)views
{
    for (UIView *view in views) {
        UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:view.center];
        attachmentBehavior.damping = 0.7;
        attachmentBehavior.frequency = 0.2;
        [self.animator addBehavior:attachmentBehavior];
    }
}

- (void)startWind:(NSArray *)views
{
    self.windBehavior = [[UIPushBehavior alloc] initWithItems:views mode:UIPushBehaviorModeContinuous];
    [self.animator addBehavior:self.windBehavior];
}

- (void)blow
{
    self.windBehavior.magnitude = BPRandom(8.0,11.0);
    self.windBehavior.angle = BPRandom(0, 2 * M_PI);
    [self performSelector:@selector(blow) withObject:Nil afterDelay:BPRandom(3.0, 3.3)];
}

@end
