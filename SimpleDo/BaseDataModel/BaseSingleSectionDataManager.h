//
//  BaseSingleSectionDataManager.h
//  SimpleDo
//
//  Created by gukong on 15/8/13.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseSingleSectionDataManager : NSObject<SingleSectionDataSource>

@property (nonatomic, strong) NSArray *dataItemsArray;
@property (nonatomic, weak) id<SingleSectionDelegate> delegate;

- (void)setupData;

- (void)appendDataItem:(id)dataItem;
- (void)insertDataItem:(id)dataItem atIndex:(NSUInteger)index;
- (void)deleteDataItem:(id)dataItem AtIndex:(NSUInteger)index;
- (void)updateDataItem:(id)dataItem atIndex:(NSUInteger)index;

@end
