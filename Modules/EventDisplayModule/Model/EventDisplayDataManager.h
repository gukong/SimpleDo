//
//  EventDisplayDataManager.h
//  SimpleDo
//
//  Created by gukong on 15/8/1.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "EventItemAdapter.h"

@protocol EventTableDataSource <MutableSectionDataSource>

@end

@interface EventDisplayDataManager : BaseMutableSectionDataManager<EventTableDataSource>

- (instancetype)initTodayEventlistWithEventTypes:(NSArray *)eventTypes;

@end


@interface EventDisplaySection : NSObject

/**
 *  collection with EventItemAdapter
 */
@property (nonatomic, strong, readonly) NSMutableArray *dataItems;

/**
 *  initailize
 *
 *  @param objects EventItem
 *
 */
- (instancetype)initWithItemObjects:(NSArray *)objects;

- (void)addDataItemsObject:(EventItemAdapter *)object;
- (void)removeDataItemsObject:(EventItemAdapter *)object;
- (void)insertObject:(EventItemAdapter *)object inDataItemsAtIndex:(NSUInteger)index;

/**
 *  get dataItem in section at index
 *
 *  @param index itemData index in section
 *
 *  @return EventItemAdapter
 */
- (EventItemAdapter*)dataItemAtIndex:(NSInteger)index;

- (NSInteger)countInSection;

@end