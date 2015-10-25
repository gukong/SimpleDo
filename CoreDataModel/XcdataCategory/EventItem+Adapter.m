//
//  EventItem+Adapter.m
//  SimpleDo
//
//  Created by gukong on 15/8/30.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "EventItem.h"
#import <objc/runtime.h>

static char EventAdapterRemainingTime;
static char EventAdapterStartTime;

@implementation EventItem (Adapter)

- (void)setRemainingTime:(NSTimeInterval)remainingTime {
    objc_setAssociatedObject(self, &EventAdapterRemainingTime, @(remainingTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)remainingTime {
    NSTimeInterval remainingTime = 0;
    NSNumber *num = objc_getAssociatedObject(self, &EventAdapterRemainingTime);
    if (num == nil) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        remainingTime = [self.startStamp timeIntervalSince1970] - time;
        [self setRemainingTime:remainingTime];
    }
    else {
        remainingTime = [num doubleValue];
    }
    return remainingTime;
}

- (void)setStartTime:(NSString *)startTime {
    objc_setAssociatedObject(self, &EventAdapterStartTime, startTime, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)startTime {
    NSString *startTime = @"";
    NSString *cacheStr = objc_getAssociatedObject(self, &EventAdapterStartTime);
    if (cacheStr == nil) {
        startTime = [self.startStamp formattedDateWithFormat:@"HH:mm"];
        [self setStartTime:startTime];
    }
    else {
        startTime = cacheStr;
    }
    return startTime;
}

@end