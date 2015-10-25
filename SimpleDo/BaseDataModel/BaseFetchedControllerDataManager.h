//
//  BaseFetchedControllerDataManager.h
//  SimpleDo
//
//  Created by gukong on 15/8/19.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseFetchedControllerDataManager : NSObject<MutableSectionDataSource>

@property (nonatomic, strong) NSFetchedResultsController *fetchedController;
@property (nonatomic, weak) id<NSFetchedResultsControllerDelegate> fetchedDelegate;

- (id)initWithFetchedController:(NSFetchedResultsController *)fetchedController;
- (BOOL)performFetch:(NSError **)error;

@end
