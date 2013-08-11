//
//  BPSizer.m
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 8/10/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import "BPSizer.h"

@implementation BPSizer

+ (CGSize)screenSize
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return CGSizeMake(screenSize.height, screenSize.width);
}

+ (CGFloat)aspectRatio
{
    return self.screenSize.width / self.screenSize.height;
}

+ (CGFloat)density
{
    return powf(768.0 / self.screenSize.height, 2.0);
}

+ (CGSize)videoFeedBubbleSize
{
    CGSize screenSize = self.screenSize;
    return CGSizeMake(screenSize.height * 0.5, screenSize.height * 0.5);
}

+ (CGPoint)videoFeedBubbleCenter
{
    CGSize screenSize = self.screenSize;
    return CGPointMake(screenSize.width * 0.7, screenSize.height * 0.5);
}

@end
