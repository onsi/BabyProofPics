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
@property (nonatomic, strong) UIDynamicItemBehavior *elasticityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIPushBehavior *windBehavior;

@property (nonatomic, strong) NSMapTable *attachmentBehaviors;

@end

@implementation BPBreezyBubblesSimulator

- (id)initWithReferenceFrame:(UIView *)referenceFrame
{
    self = [super init];
    if (self) {
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:referenceFrame];
        self.attachmentBehaviors = [NSMapTable weakToStrongObjectsMapTable];
        [self setUpBubbleElasticityBehavior];
        [self setUpCollisionsBehavior];
        [self setUpWindBehavior];
        [self blow];
    }
    return self;
}

- (void)addBreezyItem:(id<UIDynamicItem>)item centeredAt:(CGPoint)center
{
    [self.elasticityBehavior addItem:item];
    [self.collisionBehavior addItem:item];
    [self.windBehavior addItem:item];
    
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item
                                                                         attachedToAnchor:center];
    attachmentBehavior.damping = 0.7;
    attachmentBehavior.frequency = 0.2;
    [self.animator addBehavior:attachmentBehavior];
    [self.attachmentBehaviors setObject:attachmentBehavior forKey:item];
}

- (void)setUpBubbleElasticityBehavior
{
    self.elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:nil];
    self.elasticityBehavior.elasticity = 0.7;
    [self.animator addBehavior:self.elasticityBehavior];
}

- (void)setUpCollisionsBehavior
{
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:nil];
    self.collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(-100, -100, -100, -100)];
    [self.animator addBehavior:self.collisionBehavior];
}

- (void)setUpWindBehavior
{
    self.windBehavior = [[UIPushBehavior alloc] initWithItems:nil mode:UIPushBehaviorModeContinuous];
    [self.animator addBehavior:self.windBehavior];
}

- (void)blow
{
    self.windBehavior.magnitude = BPRandom(8.0,11.0);
    self.windBehavior.angle = BPRandom(0, 2 * M_PI);
    [self performSelector:@selector(blow) withObject:Nil afterDelay:BPRandom(3.0, 3.3)];
}

@end
