//
//  ClockPlateDataManager.m
//  SimpleDo
//
//  Created by gukong on 15/6/20.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "ClockPlateDataManager.h"
#import <CoreData/NSFetchedResultsController.h>
#import <CoreData/NSFetchRequest.h>
#import "EventItem.h"
#import "EventItemStore.h"

#pragma mark - ClockPlateDataManager
@interface ClockPlateDataManager ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedController;
@property (nonatomic, strong) NSMutableSet *eventTypesSetInChangedObjects;

@end

@implementation ClockPlateDataManager

#pragma mark - initializes method

- (void)setupData {
    _eventTypesSetInChangedObjects = [[NSMutableSet alloc] init];
    [self setupFetchedController];
    [self setupDataSource];
}

- (void)setupFetchedController {

//    EventItem *item = [EventItem MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
//    [item setStartStamp:@([[NSDate date] timeIntervalSince1970] + 50000)];
//    [item setEventType:@(EventType_NIM_NEM)];
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    _fetchedController = [EventItem MR_fetchAllSortedBy:@"startStamp"
                                              ascending:YES
                                          withPredicate:[NSPredicate predicateWithValue:YES]
                                                groupBy:nil
                                               delegate:self
                                              inContext:[NSManagedObjectContext MR_defaultContext]];
    [_fetchedController setDelegate:self];
    NSError *error = nil;
    [_fetchedController performFetch:&error];
    if (error) {
        abort();
    }
}

- (void)setupDataSource {
    
    ClockPlateDataItem *plateItem0 = [[ClockPlateDataItem alloc] initWithType:EventType_IM_EM];
    ClockPlateDataItem *plateItem1 = [[ClockPlateDataItem alloc] initWithType:EventType_IM_NEM];
    ClockPlateDataItem *plateItem2 = [[ClockPlateDataItem alloc] initWithType:EventType_NIM_EM];
    ClockPlateDataItem *plateItem3 = [[ClockPlateDataItem alloc] initWithType:EventType_NIM_NEM];
    
    self.dataItemsArray = @[plateItem0, plateItem1, plateItem2, plateItem3];
}

#pragma mark - public method
- (ClockPlateDataItem *)eventItemWithEventType:(EventType)eventType {
    return nil;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(EventItem *)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    [_eventTypesSetInChangedObjects addObject:anObject.eventType];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    for (NSNumber *eventType in _eventTypesSetInChangedObjects) {
        ClockPlateDataItem *plateItem = [self dataItemAtIndex:eventType.integerValue];
        [plateItem reFetchImminentEvents];
        if ([self.delegate respondsToSelector:@selector(didUpdateDataItem:atIndex:)]) {
            [self.delegate didUpdateDataItem:plateItem atIndex:eventType.integerValue];
        }
    }
}

@end

/**
 Class ClockPlateDataItem
 */
#pragma mark - ClockPlateDataItem

@implementation ClockPlateDataItem

- (id)initWithType:(EventType)eventType {
    self = [super init];
    if (self) {
        _eventType = eventType;
        [self reFetchImminentEvents];
    }
    return self;
}

- (void)reFetchImminentEvents {
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startStamp" ascending:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(eventType = %@) && startStamp > %@ && startStamp < %@",@(_eventType),@(nowTime),@(nowTime+SECONDS_IN_DAY)];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EventItem"];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = @[firstDescriptor];
    fetchRequest.fetchLimit = MaxCountOfWaveViews;

//    _eventItems = [EventItemStore fetchObjectsWithRequest:fetchRequest];
}

@end