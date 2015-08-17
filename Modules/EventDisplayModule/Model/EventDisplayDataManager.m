//
//  EventDisplayDataManager.m
//  SimpleDo
//
//  Created by gukong on 15/8/1.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "EventDisplayDataManager.h"
#import "EventItem.h"

@interface EventDisplayDataManager ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedController;

@end

@implementation EventDisplayDataManager

- (instancetype)initTodayEventlistWithEventTypes:(NSArray *)eventTypes {
    self = [super init];
    if (self) {
        [self setupDataWithEventTypes:eventTypes];
    }
    return self;
}

- (void)setupDataWithEventTypes:(NSArray *)eventTypes {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventType IN %@",eventTypes];
    _fetchedController = [EventItem MR_fetchAllGroupedBy:@"sectionIdentifier"
                                           withPredicate:predicate
                                                sortedBy:@"createStamp"
                                               ascending:YES
                                                delegate:self
                                               inContext:[NSManagedObjectContext MR_defaultContext]];
    
    [_fetchedController performFetch:nil];
    
}

#pragma mark -BaseMVCDataSourceProtocol

- (NSInteger)numberOfDataItemsInSection:(NSInteger)section {
    NSInteger num = 0;
    if ([_fetchedController.sections count] > 0) {
        NSObject<NSFetchedResultsSectionInfo> *sectionData = [_fetchedController.sections objectAtIndex:section];
        num = sectionData.numberOfObjects;
    }
    return num;
}

- (NSInteger)numberOfSections {
    return [_fetchedController.sections count];
}

- (id)dataItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_fetchedController objectAtIndexPath:indexPath];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
}

- (NSString *)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName {
    return sectionName;
}
@end


#pragma mark -

@interface EventDisplaySection()

@property (nonatomic, strong, readwrite) NSMutableArray *dataItems;

@end

@implementation EventDisplaySection

- (instancetype)initWithItemObjects:(NSArray *)objects {
    self  = [super init];
    if (self) {
        _dataItems = [[NSMutableArray alloc] init];
        [self setupWithObjects:objects];
    }
    return self;
}

- (void)setupWithObjects:(NSArray *)objects {
    @synchronized(self) {
        for (EventItem *eventItem in objects) {
            EventItemAdapter *itemAdapter = [[EventItemAdapter alloc] initWithEventItem:eventItem];
            [_dataItems addObject:itemAdapter];
        }
    }
}

- (void)addDataItemsObject:(EventItemAdapter *)object {
    @synchronized(self) {
        [_dataItems addObject:object];
    }
}

- (void)removeDataItemsObject:(EventItemAdapter *)object {
    @synchronized(self) {
        [_dataItems removeObject:object];
    }
}

- (void)insertObject:(EventItemAdapter *)object inDataItemsAtIndex:(NSUInteger)index {
    @synchronized(self) {
        [_dataItems insertObject:object atIndex:index];
    }
}

- (EventItemAdapter*)dataItemAtIndex:(NSInteger)index {
    @synchronized(self) {
        return [_dataItems objectAtIndex:index];
    }
}

- (NSInteger)countInSection {
    @synchronized(self) {
        return _dataItems.count;
    }
}

@end

