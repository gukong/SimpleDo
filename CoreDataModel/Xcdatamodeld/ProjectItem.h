//
//  ProjectItem.h
//  SimpleDo
//
//  Created by gukong on 15/6/19.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface ProjectItem : NSManagedObject

@property (nonatomic, retain) NSNumber * createStamp;
@property (nonatomic, retain) id members;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *principal;

@end
