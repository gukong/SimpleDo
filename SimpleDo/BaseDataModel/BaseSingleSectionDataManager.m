//
//  BaseSingleSectionDataManager.m
//  SimpleDo
//
//  Created by gukong on 15/8/13.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "BaseSingleSectionDataManager.h"

@implementation BaseSingleSectionDataManager

- (id)init {
    self = [super init];
    if (self) {
        _dataItemsArray = @[];
        [self setupData];
    }
    return self;
}

#pragma mark - public method

- (void)setupData {
    
}

- (void)appendDataItem:(id)dataItem {
    if (dataItem) {
        NSMutableArray *muArray = [_dataItemsArray mutableCopy];
        [muArray addObject:dataItem];
        
        TODO("这里是否为NSArray，需要验证");
        self.dataItemsArray = [muArray copy];
        if ([_delegate respondsToSelector:@selector(didInsertDataItem:atIndex:)]) {
            [_delegate didInsertDataItem:dataItem atIndex:_dataItemsArray.count-1];
        }
    }
}

- (void)insertDataItem:(id)dataItem atIndex:(NSUInteger)index {
    if (dataItem && index <= self.numberOfItems) {
        NSMutableArray *muArray = [_dataItemsArray mutableCopy];
        [muArray insertObject:dataItem atIndex:index];
        
        TODO("验证 index = count 的情况");
        self.dataItemsArray = [muArray copy];
        if ([_delegate respondsToSelector:@selector(didInsertDataItem:atIndex:)]) {
            [_delegate didInsertDataItem:dataItem atIndex:index];
        }
    }
}

- (void)deleteDataItem:(id)dataItem AtIndex:(NSUInteger)index {
    
    if (dataItem) {
        
        NSInteger temIndex = [_dataItemsArray indexOfObject:dataItem];
        
        NSMutableArray *muArray = [_dataItemsArray mutableCopy];
        [muArray removeObject:dataItem];
        
        self.dataItemsArray = [muArray copy];
        
        if ([_delegate respondsToSelector:@selector(didDeleteDataItem:atIndex:)]) {
            [_delegate didDeleteDataItem:dataItem atIndex:temIndex];
        }
    }
    else if (index < self.numberOfItems) {
        NSMutableArray *muArray = [_dataItemsArray mutableCopy];
        [muArray removeObjectAtIndex:index];
        
        self.dataItemsArray = [muArray copy];
        
        if ([_delegate respondsToSelector:@selector(didDeleteDataItem:atIndex:)]) {
            [_delegate didDeleteDataItem:dataItem atIndex:index];
        }
    }
}

- (void)updateDataItem:(id)dataItem atIndex:(NSUInteger)index {
    if (dataItem && index < self.numberOfItems) {
        NSMutableArray *muArray = [_dataItemsArray mutableCopy];
        [muArray replaceObjectAtIndex:index withObject:dataItem];
        
        self.dataItemsArray = [muArray copy];
        
        if ([_delegate respondsToSelector:@selector(didUpdateDataItem:atIndex:)]) {
            [_delegate didUpdateDataItem:dataItem atIndex:index];
        }
    }
}

#pragma mark - SingleSectionDataSource
- (NSInteger)numberOfItems {
    return _dataItemsArray.count;
}

- (id)dataItemAtIndex:(NSUInteger)index {
    id dataItem = nil;
    if (index < self.numberOfItems) {
        dataItem = _dataItemsArray[index];
    }
    return dataItem;
}


@end
