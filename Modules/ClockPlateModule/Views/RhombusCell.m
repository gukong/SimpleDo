//
//  RhombusCell.m
//  PractiseDemo
//
//  Created by gukong on 15/7/15.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "RhombusCell.h"
#import "AnimatedWaveView.h"
#import "EventItem.h"
#import "ClockPlateDataManager.h"

@interface RhombusCell ()<AnimatedWaveDelegate>

@property (nonatomic, strong) NSMutableArray *waveViewsArray;
@property (nonatomic, strong) ClockPlateDataItem *plateDataItem;

@end

@implementation RhombusCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _waveViewsArray = [[NSMutableArray alloc] init];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    for (int i = 0; i < MaxCountOfWaveViews; i ++) {
        AnimatedWaveView *waveView = [[AnimatedWaveView alloc] initWithFrame:CGRectMake(0, 0, Width_V(self), Height_V(self))];
        [waveView setDelegate:self];
        [_waveViewsArray addObject:waveView];
    }
}

- (void)configWithDataItem:(ClockPlateDataItem *)plateDataItem {
    _plateDataItem = plateDataItem;
    for (int i = 0; i < MaxCountOfWaveViews && i < plateDataItem.eventItems.count && i < _waveViewsArray.count; i ++) {
        EventItem *eventItem = [plateDataItem.eventItems objectAtIndex:i];
        AnimatedWaveView *waveView = [_waveViewsArray objectAtIndex:i];
        if (eventItem) {
            [waveView setCountDownTime:eventItem.remainingTime];
        }
        else {
            [waveView setCountDownTime:0.f];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setBackgroundColor:[UIColor greenColor]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ClockPlate_rhombus"]];
    [imageView setFrame:self.bounds];
    [self setMaskView:imageView];
    
    for (AnimatedWaveView *waveView in _waveViewsArray) {
        if (waveView.countDownTime > 0.f) {
            [waveView startAnimation];
            [self addSubview:waveView];
        }
        else {
            [waveView stopAnimation];
            [waveView removeFromSuperview];
        }
    }
}

#pragma mark - AnimatedWaveDelegate

- (void)animatedWaveView:(AnimatedWaveView *)waveView residualTime:(NSTimeInterval)time {
    [waveView setY:[self waveViewOffsetWithResidualTime:time]];
}

- (void)animatedWaveView:(AnimatedWaveView *)waveView finshedCountDown:(BOOL)finished {
    [waveView stopAnimation];
    [waveView removeFromSuperview];
}

#pragma mark - util
- (CGFloat)waveViewOffsetWithResidualTime:(double)residualTime {
    CGFloat persent = residualTime / SECONDS_IN_DAY;
    return Height_V(self) * (1-persent);
}
@end
