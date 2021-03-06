//
//  BPBreezyBubblesSimulator.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/20/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPBreezyBubblesSimulator.h"
#import "BPMath.h"
#import "BPSizer.h"

@interface BPBreezyBubblesSimulator ()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIDynamicItemBehavior *propertiesBehavior;
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
        [self setUpBubblePropertiesBehavior];
        [self setUpCollisionsBehavior];
        [self setUpWindBehavior];
        [self blow];
    }
    return self;
}

- (void)addBreezyItem:(id<UIDynamicItem>)item centeredAt:(CGPoint)center
{
    [self.propertiesBehavior addItem:item];
    [self.collisionBehavior addItem:item];
    [self.windBehavior addItem:item];
    [self attachItem:item toPoint:center];
}

- (void)removeBreezyItem:(id<UIDynamicItem>)item
{
    [self.propertiesBehavior removeItem:item];
    [self.collisionBehavior removeItem:item];
    [self.windBehavior removeItem:item];
    [self detachItem:item];
}

#pragma mark - Bubble Behaviors

- (void)setUpBubblePropertiesBehavior
{
    self.propertiesBehavior = [[UIDynamicItemBehavior alloc] initWithItems:nil];
    self.propertiesBehavior.elasticity = 0.7;
    self.propertiesBehavior.density = [BPSizer density];
    [self.animator addBehavior:self.propertiesBehavior];
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
    [self performSelector:@selector(blow) withObject:Nil afterDelay:BPRandom(1.0, 1.3)];
}

#pragma mark - Item Attachment

- (void)attachItem:(id<UIDynamicItem>)item toPoint:(CGPoint)center
{
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item
                                                                         attachedToAnchor:center];
    attachmentBehavior.damping = 0.4;
    attachmentBehavior.frequency = 0.2;
    [self.animator addBehavior:attachmentBehavior];
    [self.attachmentBehaviors setObject:attachmentBehavior forKey:item];
}

- (void)detachItem:(id<UIDynamicItem>)item
{
    UIAttachmentBehavior *attachmentBehavior = [self.attachmentBehaviors objectForKey:item];
    [self.animator removeBehavior:attachmentBehavior];
    [self.attachmentBehaviors removeObjectForKey:item];
}


@end
