//
//  EventItemStore.h
//  SimpleDo
//
//  Created by gukong on 15/7/22.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "BaseManagedObjectStore.h"
#import "EventItem.h"

@interface EventItemStore : BaseManagedObjectStore

/**
 *  新建一个 EventItem
 */
+ (EventItem *)createEventItem;

@end
