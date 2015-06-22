//
//  EventItem.h
//  SimpleDo
//
//  Created by gukong on 15/6/19.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EventItem : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * createStamp;
@property (nonatomic, retain) NSNumber * endStamp;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSNumber * remindStamp;
@property (nonatomic, retain) NSNumber * startStamp;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * tag;

@end
