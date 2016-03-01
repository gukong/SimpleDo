//
//  TimePlateView.h
//  SimpleDo
//
//  Created by gukong on 15/11/29.
//  Copyright © 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimePlateView;

@protocol TimePlateDelegate <NSObject>

@optional
- (void)timePlateView:(TimePlateView *)plateView residualTime:(NSTimeInterval)time;
- (void)timePlateView:(TimePlateView *)plateView finshedCountDown:(BOOL)finished;

@end

@interface TimePlateView : UIView

@property (nonatomic, assign) CGFloat countDownTime;
@property (nonatomic, weak) id<TimePlateDelegate> delegate;
@property (nonatomic, strong) NSString *eventContent;

- (void)startCounting;
- (void)stopCounting;
@end
