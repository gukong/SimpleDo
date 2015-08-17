//
//  ClockPlateDataManager.h
//  SimpleDo
//
//  Created by gukong on 15/6/20.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClockPlateDataItem;

#pragma mark - ClockPlateDataManager
@interface ClockPlateDataManager : BaseSingleSectionDataManager

/**
 *  data source of collectionView
 */
- (ClockPlateDataItem *)eventItemWithEventType:(EventType)eventType;

@end


#pragma mark - ClockPlateDataItem
@interface ClockPlateDataItem : NSObject

/**
 *  @[EventItem]
 */
@property (nonatomic, strong, readonly) NSArray *eventItems;
@property (nonatomic, assign, readonly) EventType eventType;


- (id)initWithType:(EventType)eventType;

/**
 *  using self eventType
 */
- (void)reFetchImminentEvents;
@end