//
//  EventsListView.h
//  SimpleDo
//
//  Created by gukong on 15/8/5.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventDisplayDataManager,RefreshControlTableView;

@interface EventsListView : UIView<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, readonly) RefreshControlTableView *eventTableView;
@property (nonatomic, weak) EventDisplayDataManager *dataManager;

@end
