//
//  CreateEventViewController.m
//  SimpleDo
//
//  Created by gukong on 15/9/2.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "CreateEventViewController.h"

#pragma mark - CreateEventViewController
@interface CreateEventViewController ()

@property (nonatomic, strong) UIScrollView *rootContentView;

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

