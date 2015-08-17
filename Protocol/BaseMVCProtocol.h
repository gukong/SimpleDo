//
//  BaseMVCProtocol.h
//  SimpleDo
//
//  Created by gukong on 15/7/28.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>



#pragma mark - SingleSectionDataSource
@protocol SingleSectionDataSource <NSObject>

@required
- (NSInteger)numberOfItems;
- (id)dataItemAtIndex:(NSUInteger)index;

@end

@protocol SingleSectionDelegate <NSObject>

@optional
- (void)didInsertDataItem:(id)dataItem atIndex:(NSUInteger)index;
- (void)didDeleteDataItem:(id)dataItem atIndex:(NSUInteger)index;
- (void)didUpdateDataItem:(id)dataItem atIndex:(NSUInteger)index;

@end


#pragma mark - MutableSectionDataSource
@protocol MutableSectionDataSource <NSObject>

@required
- (NSInteger)numberOfSetions;
- (NSInteger)numberOfItemsInSection:(NSUInteger)section;
- (id)dataItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MutableSectionDelegate <NSObject>

@optional
- (void)didInsertDataItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath;
- (void)didDeleteDataItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath;
- (void)didUpdateDataItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath;

- (void)didSectionChanged;
@end
