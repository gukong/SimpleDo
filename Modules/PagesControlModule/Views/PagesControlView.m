//
//  PagesControlView.m
//  SimpleDo
//
//  Created by gukong on 15/7/27.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "PagesControlView.h"
#import "PageDataItem.h"

@interface PagesControlView()<UICollectionViewDataSource, UICollectionViewDelegate>
{

}

@end

@implementation PagesControlView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout rootViewController:(UIViewController *)viewController {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _rootViewController = viewController;
        [self setup];
    }
    return self;
}

- (void)setup {
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self setDelegate:self];
    [self setDataSource:self];
    [self setPagingEnabled:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_controlViewDataSource numberOfItems];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    PageDataItem *dataItem = [_controlViewDataSource dataItemAtIndex:indexPath.item];
    [_rootViewController addChildViewController:dataItem.viewController];
    [dataItem.viewController.view setFrame:cell.bounds];
    [cell.contentView addSubview:dataItem.viewController.view];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_controlViewDelegate respondsToSelector:@selector(controlViewDidScroll:)]) {
        [_controlViewDelegate controlViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger oldPage = _currentPage;
    _currentPage = self.contentOffset.x / Width_V(self);
    if (_currentPage != oldPage && [_controlViewDelegate respondsToSelector:@selector(controlView:fromPage:toPage:)]) {
        [_controlViewDelegate controlView:self fromPage:oldPage toPage:_currentPage];
    }
}

- (void)scrollToPage:(NSInteger)page {
    CGPoint offset = CGPointMake(Width_V(self)*page, 0);
    [self setContentOffset:offset animated:YES];
}


@end
