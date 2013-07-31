//
//  BPBreezyBubblesSimulator.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/20/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPBreezyBubblesSimulator : NSObject

- (id)initWithReferenceFrame:(UIView *)referenceFrame;

- (void)addBreezyItem:(id<UIDynamicItem>)item centeredAt:(CGPoint)center;
- (void)pushBreezyItem:(id<UIDynamicItem>)item withForce:(CGSize)force andSnapToPoint:(CGPoint)point;

@end
