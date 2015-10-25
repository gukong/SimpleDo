//
//  EventTableViewCell.h
//  SimpleDo
//
//  Created by gukong on 15/8/30.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventItem;

@interface EventTableViewCell : UITableViewCell
- (void)configWithEventItem:(EventItem *)eventItem;
@end
