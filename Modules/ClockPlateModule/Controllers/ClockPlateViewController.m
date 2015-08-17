//
//  ClockPlateViewController.m
//  SimpleDo
//
//  Created by gukong on 15/7/12.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "ClockPlateViewController.h"
#import "ClockPlateView.h"
#import "ClockPlateDataManager.h"

@interface ClockPlateViewController ()

@property (nonatomic, strong) ClockPlateView *clockPlateView;
@property (nonatomic, strong) ClockPlateDataManager *dataManager;

@end

@implementation ClockPlateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:NSLocalizedString(@"DO", nil)];
}

- (void)setupDataModle{
    _dataManager = [[ClockPlateDataManager alloc] init];
}

- (void)setupViews {
    _clockPlateView = [[ClockPlateView alloc] initWithFrame:CGRectMake(0, 0, Width_V(self.view), Width_V(self.view))];
    [_clockPlateView setDataManager:_dataManager];
    [_clockPlateView setCenter:CGPointMake(Width_V(self.view)/2, Height_V(self.view)/2)];
    [self.view addSubview:_clockPlateView];
}

@end
