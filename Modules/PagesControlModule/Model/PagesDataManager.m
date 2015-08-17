//
//  PagesDataManager.m
//  SimpleDo
//
//  Created by gukong on 15/7/28.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "PagesDataManager.h"
#import "PageDataItem.h"

@interface PagesDataManager ()

@end

@implementation PagesDataManager

- (void)setupData {
    PageDataItem *dataItem1 = [[PageDataItem alloc] initWithPageType:PageType_AllEventItems];
    [self appendDataItem:dataItem1];
    
    PageDataItem *dataItem = [[PageDataItem alloc] initWithPageType:PageType_WaveRhombus];
    [self appendDataItem:dataItem];
}

@end