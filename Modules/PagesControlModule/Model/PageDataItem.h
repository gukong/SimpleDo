//
//  PageDataItem.h
//  SimpleDo
//
//  Created by gukong on 15/7/29.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageNavigationItem.h"

typedef NS_ENUM(NSInteger, PageType) {
    PageType_WaveRhombus = 0,
    PageType_AllEventItems
};
@interface PageDataItem : NSObject

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) PageNavigationItem *navigationItem;
@property (nonatomic, assign) PageType pageType;

- (id)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithPageType:(PageType)type;

@end