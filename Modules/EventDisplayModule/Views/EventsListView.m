//
//  EventsListView.m
//  SimpleDo
//
//  Created by gukong on 15/8/5.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "EventsListView.h"
#import "EventDisplayDataManager.h"
#import "UIScrollView+GKRefresh.h"
#import "EventTableViewCell.h"

@interface EventsListView ()<UITableViewDataSource, NSFetchedResultsControllerDelegate, GKRefreshControlDelegate>

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
    _eventTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    [_eventTableView setDataSource:self];
    [_eventTableView setContentInset:UIEdgeInsetsMake(64.f, 0, 0, 0)];
    [_eventTableView setCanPullDownToRefresh:YES];
    [_eventTableView setRefreshControlDelegate:self];
    [_eventTableView registerClass:[EventTableViewCell class] forCellReuseIdentifier:@"EventTableViewCell"];
    [self addSubview:_eventTableView];
}

- (void)setDataManager:(EventDisplayDataManager *)dataManager {
    _dataManager = dataManager;
    [dataManager setFetchedDelegate:self];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataManager numberOfSetions];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataManager numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventItem *eventItem = [_dataManager dataItemAtIndexPath:indexPath];
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventTableViewCell"];
    [cell configWithEventItem:eventItem];
    return cell;
}

#pragma mark - GKRefreshControlDelegate

- (void)startPullDownLoading:(UIScrollView *)scrollView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_eventTableView stopLoadingView];
    });
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
}


@end
