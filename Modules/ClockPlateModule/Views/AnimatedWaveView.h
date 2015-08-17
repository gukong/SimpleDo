//
//  AnimatedWaveView.h
//  SimpleDo
//
//  Created by gukong on 15/7/22.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"

@class AnimatedWaveView;

@protocol AnimatedWaveDelegate <NSObject>

@optional
- (void)animatedWaveView:(AnimatedWaveView *)waveView residualTime:(NSTimeInterval)time;
- (void)animatedWaveView:(AnimatedWaveView *)waveView finshedCountDown:(BOOL)finished;

@end

@interface AnimatedWaveView : UIView

@property (nonatomic, strong) MZTimerLabel *waterLineLabel;
@property (nonatomic, assign) CGFloat flowAwayRate;
@property (nonatomic, assign) CGFloat countDownTime;
@property (nonatomic, weak) id<AnimatedWaveDelegate> delegate;

- (void)startAnimation;
- (void)stopAnimation;

@end
