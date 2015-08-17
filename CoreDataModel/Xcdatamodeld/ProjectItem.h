//
//  ProjectItem.h
//  
//
//  Created by gukong on 15/8/4.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PersonItem;

@interface ProjectItem : NSManagedObject

@property (nonatomic, retain) NSDate * createStamp;
@property (nonatomic, retain) id members;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) PersonItem *principal;

@end
