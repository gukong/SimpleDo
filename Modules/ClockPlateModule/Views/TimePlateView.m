//
//  TimePlateView.m
//  SimpleDo
//
//  Created by gukong on 15/11/29.
//  Copyright © 2015年 gukong. All rights reserved.
//

#import "TimePlateView.h"
#import "MZTimerLabel.h"

@interface TimePlateView ()<MZTimerLabelDelegate> {
    int oldTime;
}
@property (nonatomic, strong) MZTimerLabel *waterLineLabel;
@property (nonatomic, strong) UILabel *eventLabel;
@end


@implementation TimePlateView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        oldTime = 0;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {    
    _waterLineLabel = [[MZTimerLabel alloc] init];
    [_waterLineLabel setDelegate:self];
    [_waterLineLabel setTimeFormat:@"HH:mm:ss"];
    [_waterLineLabel setTimerType:MZTimerLabelTypeTimer];
    [_waterLineLabel setFont:[UIFont systemFontOfSize:10.f]];
    [_waterLineLabel sizeToFit];
    [_waterLineLabel setCenter:CGPointMake(self.width/2, self.height/4)];
    [self addSubview:_waterLineLabel];
    
    _eventLabel = [[UILabel alloc] init];
    [_eventLabel setFont:FontWithSize(8.f)];
    [_eventLabel setBounds:CGRectMake(0, 0, self.width, 10.f)];
    [_eventLabel setCenter:CGPointMake(self.width/2, self.height*3/4)];
    [_eventLabel setLineBreakMode:NSLineBreakByClipping];
    [self addSubview:_eventLabel];
}

- (void)setEventContent:(NSString *)eventContent {
    [_eventLabel setText:eventContent];
}

- (void)startCounting {
    [_waterLineLabel setCountDownTime:_countDownTime];
    [_waterLineLabel start];
}

- (void)stopCounting {
    [_waterLineLabel pause];
}

#pragma mark - MZTimerLabelDelegate

-(void)timerLabel:(MZTimerLabel*)timerLabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType {
    
    /**
     *  call back each second
     */
    if (oldTime == (int)time) {
        //do nothing
    }
    else if (!isnan(time)) {
        oldTime = (int)time;
        if ([_delegate respondsToSelector:@selector(timePlateView:residualTime:)]) {
            [_delegate timePlateView:self residualTime:time];
        }
    }
}

-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime {
    if ([_delegate respondsToSelector:@selector(timePlateView:finshedCountDown:)]) {
        [_delegate timePlateView:self finshedCountDown:YES];
    }
}
@end
