//
//  PageDataItem.m
//  SimpleDo
//
//  Created by gukong on 15/7/29.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "PageDataItem.h"
#import "ClockPlateViewController.h"
#import "EventsDisplayViewController.h"

@interface PageDataItem()
@end

@implementation PageDataItem

- (instancetype)initWithPageType:(PageType)type {
    self = [super init];
    if (self) {
        _pageType = type;
        [self setup];
    }
    return self;
}

- (void)setup {
    switch (_pageType) {
        case PageType_WaveRhombus:
            _viewController = [[ClockPlateViewController alloc] init];
            _navigationItem = [[PageNavigationItem alloc] init];
            break;
        case PageType_AllEventItems:
            _viewController = [[EventsDisplayViewController alloc] init];
            _navigationItem = [[PageNavigationItem alloc] init];
    }
}

@end