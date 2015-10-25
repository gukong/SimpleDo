//
//  EventsDisplayViewController.m
//  SimpleDo
//
//  Created by gukong on 15/8/5.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "EventsDisplayViewController.h"
#import "EventDisplayDataManager.h"
#import "EventsListView.h"

@interface EventsDisplayViewController ()

@property (nonatomic, strong) EventDisplayDataManager *dataManager;
@property (nonatomic, strong) EventsListView *eventsListView;

@end

@implementation EventsDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupDataModle {
    NSArray *willDisplayEventTypes = @[@(EventType_IM_EM),@(EventType_IM_NEM),@(EventType_NIM_EM),@(EventType_NIM_NEM)];
    _dataManager = [[EventDisplayDataManager alloc] initTodayEventlistWithEventTypes:willDisplayEventTypes delegate:nil];
}

- (void)setupViews {
    _eventsListView = [[EventsListView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, Width_V(self.view), Height_V(self.view)-NavigationBarHeight)];
    [_eventsListView setDataManager:_dataManager];
    [_eventsListView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_eventsListView];
}


@end
