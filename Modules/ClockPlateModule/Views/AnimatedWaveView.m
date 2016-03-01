//
//  AnimatedWaveView.m
//  SimpleDo
//
//  Created by gukong on 15/7/22.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "AnimatedWaveView.h"

@interface AnimatedWaveView ()<MZTimerLabelDelegate> {
    int oldTime;
}

@property (nonatomic, strong) UIImageView *waveView;

@end

@implementation AnimatedWaveView

- (void)dealloc {
    [_waveView.layer removeAllAnimations];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        oldTime = 0;
        _flowAwayRate = 1;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _waveView = [[UIImageView alloc] init];
    [_waveView setImage:[UIImage imageNamed:@"fb_wave"]];
    [_waveView sizeToFit];
    [_waveView setFrame:CGRectMake(- (Width_V(_waveView) - Width_V(self)), 0, Width_V(_waveView), Height_V(_waveView))];
    [_waveView setAlpha:0.8];
    [self addSubview:_waveView];
}

- (void)startAnimation {
    [self animationForView:_waveView];
}

- (void)stopAnimation {
    [_waveView.layer removeAllAnimations];
}

- (void)animationForView:(UIView *)aniView {
    CGFloat unitLength = Width_V(aniView)/3;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    [animation setFromValue:@(aniView.center.x)];
    [animation setToValue:@(aniView.center.x + unitLength * 2)];
    [animation setDuration:12.f];
    [animation setRemovedOnCompletion:YES];
    [animation setRepeatCount:CGFLOAT_MAX];
    [aniView.layer addAnimation:animation forKey:@"Rhombus"];
}

@end
