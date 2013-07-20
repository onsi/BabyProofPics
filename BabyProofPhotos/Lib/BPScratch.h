//
//  BPScratch.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/19/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPScratch : NSObject

+ (void)logTouches:(NSSet *)touches andEvent:(UIEvent *)event inView:(UIView *)view withMessage:(NSString *)message;

@end
