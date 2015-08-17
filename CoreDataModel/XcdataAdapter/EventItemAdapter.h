//
//  EventItemAdapter.h
//  SimpleDo
//
//  Created by gukong on 15/6/20.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventItem.h"
#import "ProjectItem.h"
#import "PersonItem.h"

@interface EventItemAdapter : NSObject

@property (nonatomic, strong, readonly) NSString *year;
@property (nonatomic, strong, readonly) NSString *month;
@property (nonatomic, strong, readonly) NSString *day;
@property (nonatomic, strong, readonly) NSString *date;

@property (nonatomic, strong) NSString *eventItemId;
@property (nonatomic, assign) NSInteger createStamp;
@property (nonatomic, assign) NSInteger startStamp;
@property (nonatomic, assign) NSInteger endStamp;
@property (nonatomic, assign) NSInteger remindStamp;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) ProjectItem *projectItem;
@property (nonatomic, strong) PersonItem *personItem;


- (id)initWithEventItem:(EventItem *)eventItem;
- (void)saveToDisk;

@end
