//
//  BaseMutableSectionDataManager.h
//  SimpleDo
//
//  Created by gukong on 15/8/13.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMutableSectionDataManager : NSObject<MutableSectionDataSource>

@property (nonatomic, strong) NSArray *sectionItemsArray;
@property (nonatomic, weak) id<MutableSectionDelegate> delegate;

- (void)setupData;

- (void)insertDataItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath;
- (void)deleteDataItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath;
- (void)updateDataItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath;

- (void)insertSectionItem:(id)sectionItem atIndexPath:(NSIndexPath *)indexPath;
- (void)deleteSectionItem:(id)sectionItem atIndexPath:(NSIndexPath *)indexPath;
- (void)updateSectionItem:(id)sectionItem atIndexPath:(NSIndexPath *)indexPath;

@end


@interface SectionItem : BaseSingleSectionDataManager

@property (nonatomic, strong) NSString *sectionTitle;

+ (instancetype)sectionItemWithTitle:(NSString *)title;

@end