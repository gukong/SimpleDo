//
//  ClockPlateViewController.m
//  SimpleDo
//
//  Created by gukong on 15/7/12.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "ClockPlateViewController.h"
#import "ClockPlateView.h"

@interface ClockPlateViewController ()

@property (nonatomic, strong) ClockPlateView *clockPlateView;

@end

@implementation ClockPlateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setTitle:NSLocalizedString(@"DO", nil)];
    [self setupViews];
}

- (void)setupViews {
    _clockPlateView = [[ClockPlateView alloc] initWithFrame:CGRectMake(0, 0, Width_V(self.view) * 0.86f, Width_V(self.view) * 0.86f)];
    [_clockPlateView setCenter:CGPointMake(Width_V(self.view)/2, Height_V(self.view)/2)];
    [self.view addSubview:_clockPlateView];
}

@end
