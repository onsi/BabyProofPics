//
//  BPFullScreenVideoFeedViewController.h
//  BabyProofPhotos
//
//  Created by Onsi Fakhouri on 7/17/13.
//  Copyright (c) 2013 Onsi Fakhouri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPFullScreenVideoFeedViewController : UIViewController

- (void)installVideoFeedLayer:(CALayer *)layer;
- (CALayer *)removeVideoFeedLayer;

@end
