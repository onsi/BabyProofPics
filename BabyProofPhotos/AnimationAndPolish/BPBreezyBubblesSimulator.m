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
@property (nonatomic, strong) NSMapTable *snapBehaviors;

@end

@implementation BPBreezyBubblesSimulator

- (id)initWithReferenceFrame:(UIView *)referenceFrame
{
    self = [super init];
    if (self) {
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:referenceFrame];
        self.attachmentBehaviors = [NSMapTable weakToStrongObjectsMapTable];
        self.snapBehaviors = [NSMapTable weakToStrongObjectsMapTable];
        [self setUpBubbleElasticityBehavior];
        [self setUpCollisionsBehavior];
        [self setUpWindBehavior];
        [self blow];
    }
    return self;
}

- (void)addBreezyItem:(id<UIDynamicItem>)item centeredAt:(CGPoint)center
{
    [self unsnapItem:item];

    [self.elasticityBehavior addItem:item];
    [self.collisionBehavior addItem:item];
    [self.windBehavior addItem:item];
    [self attachItem:item toPoint:center];
}

- (void)pushBreezyItem:(id<UIDynamicItem>)item withForce:(CGSize)force andSnapToPoint:(CGPoint)point
{
    [self.collisionBehavior removeItem:item];
    [self.windBehavior removeItem:item];
    [self detachItem:item];
    
    [self pushItem:item withForce:force];
    [self snapItem:item toPoint:point];
}

#pragma mark - Behaviors

- (void)setUpBubbleElasticityBehavior
{
    self.elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:nil];
    self.elasticityBehavior.elasticity = 0.7;
    self.elasticityBehavior.allowsRotation = NO;
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

- (void)attachItem:(id<UIDynamicItem>)item toPoint:(CGPoint)center
{
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item
                                                                         attachedToAnchor:center];
    attachmentBehavior.damping = 0.7;
    attachmentBehavior.frequency = 0.7;
    [self.animator addBehavior:attachmentBehavior];
    [self.attachmentBehaviors setObject:attachmentBehavior forKey:item];
}

- (void)detachItem:(id<UIDynamicItem>)item
{
    UIAttachmentBehavior *attachmentBehavior = [self.attachmentBehaviors objectForKey:item];
    [self.animator removeBehavior:attachmentBehavior];
    [self.attachmentBehaviors removeObjectForKey:item];
}

- (void)snapItem:(id<UIDynamicItem>)item toPoint:(CGPoint)point
{
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:item snapToPoint:point];
    snapBehavior.damping = 0.2;
    [self.animator addBehavior:snapBehavior];
    [self.snapBehaviors setObject:snapBehavior forKey:item];
}

- (void)unsnapItem:(id<UIDynamicItem>)item
{
    UISnapBehavior *snapBehavior = [self.snapBehaviors objectForKey:item];
    [self.animator removeBehavior:snapBehavior];
    [self.snapBehaviors removeObjectForKey:item];
}

- (void)pushItem:(id<UIDynamicItem>)item withForce:(CGSize)force
{
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[item] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = force;
    [self.animator addBehavior:pushBehavior];
}

@end
