//
//  EventItemStore.m
//  SimpleDo
//
//  Created by gukong on 15/7/22.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "EventItemStore.h"

@implementation EventItemStore

+ (EventItem *)createEventItem {
    NSString *entityName = [NSStringFromClass([EventItem class]) componentsSeparatedByString:@"."].lastObject;
    EventItem *item = (EventItem *)[BaseManagedObjectStore createEntityWithName:entityName];
    return item;
}

@end
