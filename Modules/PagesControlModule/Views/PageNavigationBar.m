//
//  PageNavigationBar.m
//  SimpleDo
//
//  Created by gukong on 15/7/28.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "PageNavigationBar.h"
#import "PageDataItem.h"

@interface PageNavigationBar ()<UICollectionViewDataSource, UICollectionViewDelegate> {
    CGFloat navigationItemInterval;
}

@property (nonatomic, strong) BaseCollectionView *itemsCollectionView;

@end

@implementation PageNavigationBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect frame = CGRectMake(0, statusBarHeight, Width_V(self), Height_V(self)-statusBarHeight);
    navigationItemInterval = (Width_V(self)/2 - NavigationItemSize*2);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(NavigationItemSize, NavigationItemSize)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumLineSpacing:navigationItemInterval];
    
    _itemsCollectionView = [[BaseCollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    [_itemsCollectionView setBackgroundColor:UIColorFromRGBA(0x123876, 0.5)];
    [_itemsCollectionView setDataSource:self];
    [_itemsCollectionView setDelegate:self];
    [_itemsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_itemsCollectionView setContentInset:UIEdgeInsetsMake(0, (Width_V(self) - NavigationItemSize) / 2, 0, (Width_V(self) - NavigationItemSize) / 2)];
    [_itemsCollectionView setScrollEnabled:NO];
    [self addSubview:_itemsCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_navigationBarDataSource numberOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell"
                                                                           forIndexPath:indexPath];
    PageDataItem *item = [_navigationBarDataSource dataItemAtIndex:indexPath.item];
    [item.navigationItem setFrame:cell.bounds];
    [item.navigationItem setBackgroundColor:UIColorFromRGBA(0x452960, 0.2)];
    [item.navigationItem setUserInteractionEnabled:NO];
    [cell addSubview:item.navigationItem];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tapActionOnNavigationItem:atIndex:)]) {
        PageDataItem *item = [_navigationBarDataSource dataItemAtIndex:indexPath.item];
        [((id<PageNavigationBarDelegate>)self.delegate) tapActionOnNavigationItem:item.navigationItem atIndex:indexPath.item];
    }
}

- (void)setAssociateScrollView:(UIScrollView *)associateScrollView {
    _associateScrollView = associateScrollView;
    self.KVOController = [FBKVOController controllerWithObserver:self];
    [self.KVOController observe:associateScrollView keyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(PageNavigationBar *observer, UICollectionView *object, NSDictionary *change) {
        CGPoint associateOffset = [(NSValue *)[change objectForKey:@"new"] CGPointValue];
        [self scrollNavigationItemWithPageOffset:associateOffset];
        [self updateCurrentIndexWithPageOffset:associateOffset];
    }];
}

- (void)scrollNavigationItemWithPageOffset:(CGPoint)associateOffset {
    CGFloat ratio = (navigationItemInterval + NavigationItemSize) / Width_V(_associateScrollView);
    CGPoint offset = CGPointMake(associateOffset.x * ratio - _itemsCollectionView.contentInset.left, associateOffset.y);
    [_itemsCollectionView setContentOffset:offset animated:NO];
}

- (void)updateCurrentIndexWithPageOffset:(CGPoint)associateOffset {
    _currentIndex = associateOffset.x / Width_V(_associateScrollView);
}


@end
