//
//  PagesControlView.h
//  SimpleDo
//
//  Created by gukong on 15/7/27.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "BaseCollectionView.h"

@class PagesControlView;

#pragma mark - PagesControlDataSource
@protocol PagesControlDelegate <NSObject>

@optional
- (void)controlViewDidScroll:(PagesControlView *)controlView;
- (void)controlView:(PagesControlView *)controlView fromPage:(NSInteger)fromPage toPage:(NSInteger)toPage;

@end

#pragma mark - PagesControlView
@interface PagesControlView : BaseCollectionView

@property (nonatomic, weak) id<SingleSectionDataSource> controlViewDataSource;
@property (nonatomic, weak) id<PagesControlDelegate> controlViewDelegate;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) UIViewController *rootViewController;

- (id)init UNAVAILABLE_ATTRIBUTE;
- (id)initWithCoder:(NSCoder *)aDecoder UNAVAILABLE_ATTRIBUTE;
- (id)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout UNAVAILABLE_ATTRIBUTE;

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout rootViewController:(UIViewController *)viewController;

- (void)scrollToPage:(NSInteger)page;

@end
