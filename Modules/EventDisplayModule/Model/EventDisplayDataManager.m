//
//  EventDisplayDataManager.m
//  SimpleDo
//
//  Created by gukong on 15/8/1.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "EventDisplayDataManager.h"
#import "EventItem.h"

@interface EventDisplayDataManager ()

@end

@implementation EventDisplayDataManager

- (instancetype)initTodayEventlistWithEventTypes:(NSArray *)eventTypes delegate:(id<NSFetchedResultsControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        [self setupDataWithEventTypes:eventTypes delegate:delegate];
    }
    return self;
}

- (void)setupDataWithEventTypes:(NSArray *)eventTypes delegate:(id<NSFetchedResultsControllerDelegate>)delegate {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventType IN %@",eventTypes];
    self.fetchedController = [EventItem MR_fetchAllGroupedBy:@"sectionIdentifier"
                                           withPredicate:predicate
                                                sortedBy:@"startStamp"
                                               ascending:YES
                                                delegate:delegate
                                               inContext:[NSManagedObjectContext MR_defaultContext]];
    
    [self performFetch:nil];
}

@end

