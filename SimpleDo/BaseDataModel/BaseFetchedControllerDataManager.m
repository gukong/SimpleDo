//
//  BaseFetchedControllerDataManager.m
//  SimpleDo
//
//  Created by gukong on 15/8/19.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "BaseFetchedControllerDataManager.h"

@implementation BaseFetchedControllerDataManager

- (id)initWithFetchedController:(NSFetchedResultsController *)fetchedController {
    self = [super init];
    if (self) {
        _fetchedController = fetchedController;
    }
    return self;
}

- (BOOL)performFetch:(NSError **)error {
    return [_fetchedController performFetch:error];
}

- (void)setFetchedDelegate:(id<NSFetchedResultsControllerDelegate>)fetchedDelegate {
    [_fetchedController setDelegate:fetchedDelegate];
}

- (id<NSFetchedResultsControllerDelegate>)fetchedDelegate {
    return _fetchedController.delegate;
}

#pragma mark - MutableSectionDataSource

- (NSInteger)numberOfSetions {
    return _fetchedController.sections.count;
}

- (NSInteger)numberOfItemsInSection:(NSUInteger)section {
    NSInteger count = 0;
    if (section < [self numberOfSetions]) {
        id<NSFetchedResultsSectionInfo> sectionInfo = _fetchedController.sections[section];
        count = [sectionInfo numberOfObjects];
    }
    return count;
}

- (id)dataItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_fetchedController objectAtIndexPath:indexPath];
}

@end
