//
//  EventItem.m
//  
//
//  Created by gukong on 15/8/4.
//
//

#import "EventItem.h"

@interface EventItem ()
@property (nonatomic) NSDate *primitiveStartStamp;
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
@dynamic primitiveStartStamp;
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
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[self startStamp]];
        tmp = [NSString stringWithFormat:@"%d %d %d", (int)components.day, (int)components.month, (int)components.year];
        [self willChangeValueForKey:@"sectionIdentifier"];
        [self setPrimitiveSectionIdentifier:tmp];
        [self didChangeValueForKey:@"sectionIdentifier"];
    }
    return tmp;
}

#pragma mark - Time stamp setter
- (void)setStartStamp:(NSDate *)startStamp {
    [self willChangeValueForKey:@"startStamp"];
    [self setPrimitiveStartStamp:startStamp];
    [self didChangeValueForKey:@"startStamp"];
    
    [self willChangeValueForKey:@"sectionIdentifier"];
    [self setPrimitiveSectionIdentifier:nil];
    [self didChangeValueForKey:@"sectionIdentifier"];
}

#pragma mark - Key path dependencies

+ (NSSet *)keyPathsForValuesAffectingSectionIdentifier
{
    // If the value of timeStamp changes, the section identifier may change as well.
    return [NSSet setWithObject:@"createStamp"];
}
@end
