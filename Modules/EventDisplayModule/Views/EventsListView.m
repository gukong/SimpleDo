//
//  EventsListView.m
//  SimpleDo
//
//  Created by gukong on 15/8/5.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "EventsListView.h"
#import "RefreshControlTableView.h"
#import "EventDisplayDataManager.h"
#import "EventItemAdapter.h"

@interface EventsListView ()<UITableViewDataSource>

@end

@implementation EventsListView

- (id)init {
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [_eventTableView setFrame:self.bounds];
}

- (void)setupViews {
    _eventTableView = [[RefreshControlTableView alloc] initWithFrame:self.bounds];
    [_eventTableView setDataSource:self];
    [_eventTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self addSubview:_eventTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataManager numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    [cell.textLabel setText:@""];
    return cell;
}


@end
