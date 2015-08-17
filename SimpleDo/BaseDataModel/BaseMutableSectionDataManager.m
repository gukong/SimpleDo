//
//  BaseMutableSectionDataManager.m
//  SimpleDo
//
//  Created by gukong on 15/8/13.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "BaseMutableSectionDataManager.h"

@implementation BaseMutableSectionDataManager

- (id)init {
    self = [super init];
    if (self) {
        _sectionItemsArray = @[];
        [self setupData];
    }
    return self;
}

- (void)setupData {
    
}

- (void)insertDataItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.numberOfSetions) {
        SectionItem *sectionItem = [self sectionItemAtIndex:indexPath.section];
        [sectionItem insertDataItem:dataItem atIndex:indexPath.row];
        
        if ([_delegate respondsToSelector:@selector(didInsertDataItem:atIndexPath:)]) {
            [_delegate didInsertDataItem:dataItem atIndexPath:indexPath];
        }
    }
}

- (void)deleteDataItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.numberOfSetions) {
        SectionItem *sectionItem = [self sectionItemAtIndex:indexPath.section];
        [sectionItem deleteDataItem:dataItem AtIndex:indexPath.row];
        
        if ([_delegate respondsToSelector:@selector(didDeleteDataItem:atIndexPath:)]) {
            [_delegate didDeleteDataItem:dataItem atIndexPath:indexPath];
        }
    }
}

- (void)updateDataItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.numberOfSetions) {
        SectionItem *sectionItem = [self sectionItemAtIndex:indexPath.row];
        [sectionItem updateDataItem:dataItem atIndex:indexPath.row];
        
        if ([_delegate respondsToSelector:@selector(didUpdateDataItem:atIndexPath:)]) {
            [_delegate didUpdateDataItem:dataItem atIndexPath:indexPath];
        }
    }
}


- (void)insertSectionItem:(id)sectionItem atIndexPath:(NSIndexPath *)indexPath {
    if (sectionItem && indexPath.section <= self.numberOfSetions) {
        NSMutableArray *muArray = [_sectionItemsArray mutableCopy];
        [muArray insertObject:sectionItem atIndex:indexPath.section];
        
        self.sectionItemsArray = [muArray copy];
        
        if ([_delegate respondsToSelector:@selector(didSectionChanged)]) {
            [_delegate didSectionChanged];
        }
    }
}

- (void)deleteSectionItem:(id)sectionItem atIndexPath:(NSIndexPath *)indexPath {
    if (sectionItem) {
        NSMutableArray *muArray = [_sectionItemsArray mutableCopy];
        [muArray removeObject:sectionItem];
        
        self.sectionItemsArray = [muArray copy];
        
        if ([_delegate respondsToSelector:@selector(didSectionChanged)]) {
            [_delegate didSectionChanged];
        }
    }
    else if(indexPath.section < self.numberOfSetions) {
        NSMutableArray *muArray = [_sectionItemsArray mutableCopy];
        [muArray removeObjectAtIndex:indexPath.section];
        
        self.sectionItemsArray = [muArray copy];
        
        if ([_delegate respondsToSelector:@selector(didSectionChanged)]) {
            [_delegate didSectionChanged];
        }
    }
}

- (void)updateSectionItem:(id)sectionItem atIndexPath:(NSIndexPath *)indexPath {
    if (sectionItem && indexPath.section < self.numberOfSetions) {
        NSMutableArray *muArray = [_sectionItemsArray mutableCopy];
        [muArray replaceObjectAtIndex:indexPath.section withObject:sectionItem];
        
        self.sectionItemsArray = [muArray copy];
        
        if ([_delegate respondsToSelector:@selector(didSectionChanged)]) {
            [_delegate didSectionChanged];
        }
    }
}


#pragma mark - MutableSectionDataSource
- (NSInteger)numberOfSetions {
    return _sectionItemsArray.count;
}

- (NSInteger)numberOfItemsInSection:(NSUInteger)section {
    SectionItem *item = [self sectionItemAtIndex:section];
    NSInteger number = [item numberOfItems];
    return number;
}

- (id)dataItemAtIndexPath:(NSIndexPath *)indexPath {
    id dataItem = nil;
    SectionItem *sectionItem = [self sectionItemAtIndex:indexPath.section];
    if (sectionItem) {
        dataItem = [sectionItem dataItemAtIndex:indexPath.row];
    }
    return dataItem;
}

- (SectionItem *)sectionItemAtIndex:(NSInteger)index {
    SectionItem *item = nil;
    if (index < self.numberOfSetions) {
        item = _sectionItemsArray[index];
    }
    return item;
}

@end


#pragma mark - SectionItem
@implementation SectionItem

+ (instancetype)sectionItemWithTitle:(NSString *)title {
    SectionItem *sectionItem = [[SectionItem alloc] init];
    [sectionItem setSectionTitle:title];
    return sectionItem;
}

@end