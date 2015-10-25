//
//  EventDisplayDataManager.h
//  SimpleDo
//
//  Created by gukong on 15/8/1.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "BaseFetchedControllerDataManager.h"

@interface EventDisplayDataManager : BaseFetchedControllerDataManager

- (instancetype)initTodayEventlistWithEventTypes:(NSArray *)eventTypes delegate:(id<NSFetchedResultsControllerDelegate>)delegate;

@end