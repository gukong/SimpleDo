//
//  CreateEventViewController.m
//  SimpleDo
//
//  Created by gukong on 15/9/2.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "CreateEventViewController.h"
#import "CreateEventInfoCell.h"

#pragma mark - CreateEventViewController
@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = Localized("title_create");
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:Localized("title_done") style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    [self.navigationItem setRightBarButtonItem:item];
    
    [self.tableView registerClass:[CreateEventInfoCell class] forCellReuseIdentifier:@"CreateEventInfoCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreateEventInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreateEventInfoCell"];
    return cell;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

