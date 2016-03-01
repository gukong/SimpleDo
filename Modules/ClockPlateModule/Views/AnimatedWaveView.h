//
//  AnimatedWaveView.h
//  SimpleDo
//
//  Created by gukong on 15/7/22.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"

@interface AnimatedWaveView : UIView

@property (nonatomic, assign) CGFloat flowAwayRate;

- (void)startAnimation;
- (void)stopAnimation;

@end
