//
//  EventItem.m
//  
//
//  Created by gukong on 15/8/4.
//
//

#import "EventItem.h"

@interface EventItem ()
@property (nonatomic) NSDate *primitiveCreateStamp;
@property (nonatomic) NSString *primitiveSectionIdentifier;
@end

@implementation EventItem

@dynamic content;
@dynamic createStamp;
@dynamic endStamp;
@dynamic eventType;
@dynamic remindStamp;
@dynamic startStamp;
@dynamic status;
@dynamic tag;
@dynamic sectionIdentifier;
@dynamic primitiveCreateStamp;
@dynamic primitiveSectionIdentifier;
@dynamic eventItemId;

#pragma mark - Transient properties
- (NSString *)sectionIdentifier {
    [self willAccessValueForKey:@"sectionIdentifier"];
    NSString *tmp = [self primitiveSectionIdentifier];
    [self didAccessValueForKey:@"sectionIdentifier"];
    
    if (!tmp)
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[self createStamp]];
        tmp = [NSString stringWithFormat:@"%d %d %d", (int)components.day, (int)components.month, (int)components.year];
        [self setPrimitiveSectionIdentifier:tmp];
    }
    return tmp;
}

#pragma mark - Time stamp setter
- (void)setCreateStamp:(NSDate *)createStamp {
    [self willChangeValueForKey:@"createStamp"];
    [self setPrimitiveCreateStamp:createStamp];
    [self didChangeValueForKey:@"createStamp"];
    
    [self setPrimitiveSectionIdentifier:nil];

}

#pragma mark - Key path dependencies

+ (NSSet *)keyPathsForValuesAffectingSectionIdentifier
{
    // If the value of timeStamp changes, the section identifier may change as well.
    return [NSSet setWithObject:@"createStamp"];
}

- (NSTimeInterval)remainingTime {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval remainingTime = [self.startStamp timeIntervalSince1970] - time;
    return remainingTime;
}
@end
