//
//  PageNavigationBar.h
//  SimpleDo
//
//  Created by gukong on 15/7/28.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageNavigationItem;
@protocol PageNavigationBarDelegate <UINavigationBarDelegate>

@optional
- (void)tapActionOnNavigationItem:(PageNavigationItem *)navigationItem atIndex:(NSInteger)index;

@end

@interface PageNavigationBar : UINavigationBar

@property (nonatomic, weak) id<SingleSectionDataSource> navigationBarDataSource;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) UIScrollView *associateScrollView;

@end
