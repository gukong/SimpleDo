//
//  EventItem.h
//  
//
//  Created by gukong on 15/8/4.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EventItem : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * createStamp;
@property (nonatomic, retain) NSDate * endStamp;
@property (nonatomic, retain) NSNumber * eventType;
@property (nonatomic, retain) NSDate * remindStamp;
@property (nonatomic, retain) NSDate * startStamp;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * tag;
@property (nonatomic, retain) NSString * sectionIdentifier;
@property (nonatomic, retain) NSString * eventItemId;

@end

@interface EventItem (Adapter)
@property (nonatomic, assign, readonly) NSTimeInterval remainingTime;
@property (nonatomic, strong, readonly) NSString *startTime;
@end