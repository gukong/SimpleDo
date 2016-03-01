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
#import "TimePlateView.h"
#import "GKGravityView.h"

@interface RhombusCell ()<TimePlateDelegate>

@property (nonatomic, strong) ClockPlateDataItem *plateDataItem;
@property (nonatomic, strong) AnimatedWaveView *waveView;
@property (nonatomic, strong) TimePlateView *timePlateView;
@property (nonatomic, strong) GKGravityView *gravityView;
@end

@implementation RhombusCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _waveView = [[AnimatedWaveView alloc] initWithFrame:CGRectMake(0, 0, Width_V(self), Height_V(self))];
    
    _timePlateView = [[TimePlateView alloc] initWithFrame:CGRectMake(0, 0, 70.f, 20.f)];
    [_timePlateView.layer setMasksToBounds:YES];
    [_timePlateView.layer setCornerRadius:5.f];
    [_timePlateView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.1]];
    [_timePlateView setDelegate:self];
    
    _gravityView = [[GKGravityView alloc] initWithFrame:CGRectMake(0, 0, 80.f, 80.f)];
    [_gravityView setupCustomView:_timePlateView fixedAnchorDistance:60.f blurStyle:GKGravityViewCustomViewBlurStyle_BlurEffect];
}

- (void)configWithDataItem:(ClockPlateDataItem *)plateDataItem {
    _plateDataItem = plateDataItem;
    if (plateDataItem.eventItems.count > 0) {
        EventItem *eventItem = [plateDataItem.eventItems firstObject];
        if (eventItem) {
            [_timePlateView setCountDownTime:eventItem.remainingTime];
            [_timePlateView setEventContent:eventItem.content];
        }
        else {
            [_timePlateView setCountDownTime:0.f];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setBackgroundColor:[UIColor greenColor]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ClockPlate_rhombus"]];
    [imageView setFrame:self.bounds];
    [self setMaskView:imageView];
    
    if (_timePlateView.countDownTime > 0.f) {
        
        [_waveView startAnimation];
        [self addSubview:_waveView];

        [_timePlateView startCounting];
        [_gravityView setCenter:CGPointMake(self.width/2, self.height/2)];
        [self addSubview:_gravityView];
    }
    else {
        [_timePlateView startCounting];
        [_gravityView removeFromSuperview];
        [_waveView stopAnimation];
        [_waveView removeFromSuperview];
    }
}

#pragma mark - AnimatedWaveDelegate

- (void)timePlateView:(TimePlateView *)plateView residualTime:(NSTimeInterval)time {
    [_waveView setY:[self waveViewOffsetWithResidualTime:time]];
}

- (void)timePlateView:(TimePlateView *)plateView finshedCountDown:(BOOL)finished {
    [_waveView stopAnimation];
    [_waveView removeFromSuperview];
    [plateView stopCounting];
    [plateView removeFromSuperview];
}

#pragma mark - util
- (CGFloat)waveViewOffsetWithResidualTime:(double)residualTime {
    CGFloat persent = residualTime / SECONDS_IN_DAY;
    return Height_V(self) * (1-persent);
}
@end
