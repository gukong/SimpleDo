//
//  UIScrollView+GKRefresh.m
//  GKRefreshAndLoadTableView
//
//  Created by gukong on 15/8/20.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "UIScrollView+GKRefresh.h"
#import <objc/runtime.h>
#import "GKIndicatorView.h"

NSString *const NOTIFICATIONNAME_REFRESHCONTROL_STATECHANGE = @"NOTIFICATIONNAME_REFRESHCONTROL_STATECHANGE";
NSString * const NOTIFICATIONKEY_REFRESHCONTROL_OLDSTATE = @"NOTIFICATIONKEY_REFRESHCONTROL_OLDSTATE";
NSString * const NOTIFICATIONKEY_REFRESHCONTROL_NEWSTATE = @"NOTIFICATIONKEY_REFRESHCONTROL_NEWSTATE";


static char UIScrollViewPullToRefreshView;
static char UIScrollViewPullToLoadMoreView;
static char UIScrollViewRefreshState;
static char UIScrollViewOriginalContentInset;
static char UIScrollViewGKRefreshControlDelegate;

static CGFloat KRefreshThreshold = 64.f;

@interface UIScrollView ()

@property (nonatomic, assign) UIEdgeInsets originalContentInset;

@end

@implementation UIScrollView (GKRefresh)

- (void)dealloc {
    if (self.canPullUpToLoadMore || self.canPullDownToRefresh) {
        [self removeObserver:self forKeyPath:@"contentOffset"];
        [self removeObserver:self forKeyPath:@"contentInset"];
    }
}

#pragma mark - setter & getter
- (void)setCanPullDownToRefresh:(BOOL)canPullDownToRefresh {
    if (self.canPullDownToRefresh != canPullDownToRefresh) {
        if (canPullDownToRefresh) {
            GKIndicatorView *refresh = [[GKIndicatorView alloc] init];
            [refresh.layer setMasksToBounds:YES];
            [refresh setFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0)];
            [refresh setBackgroundColor:[UIColor redColor]];
            [self addSubview:refresh];
            [self setPullDownIndicatorView:refresh];
            [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
        }
        else {
            [self setPullDownIndicatorView:nil];
        }
    }
}

- (BOOL)canPullDownToRefresh {
    BOOL ret = NO;
    if (self.pullDownIndicatorView) {
        ret = YES;
    }
    return ret;
}

- (void)setCanPullUpToLoadMore:(BOOL)canPullUpToLoadMore {
    if (self.canPullUpToLoadMore != canPullUpToLoadMore) {
        if (canPullUpToLoadMore) {
            GKIndicatorView *loadMore = [[GKIndicatorView alloc] init];
            [loadMore.layer setMasksToBounds:YES];
            [loadMore setFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0)];
            [loadMore setBackgroundColor:[UIColor purpleColor]];
            [self addSubview:loadMore];
            [self setPullUpIndicatorView:loadMore];
            [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
        }
        else {
            [self setPullUpIndicatorView:nil];
        }
    }
}

- (BOOL)canPullUpToLoadMore {
    BOOL ret = NO;
    if (self.pullUpIndicatorView) {
        ret = YES;
    }
    return ret;
}

- (void)setPullDownIndicatorView:(UIView *)pullDownIndicatorView {
    objc_setAssociatedObject(self, &UIScrollViewPullToRefreshView, pullDownIndicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)pullDownIndicatorView {
    return objc_getAssociatedObject(self, &UIScrollViewPullToRefreshView);
}

- (void)setPullUpIndicatorView:(UIView *)pullUpIndicatorView {
    objc_setAssociatedObject(self, &UIScrollViewPullToLoadMoreView, pullUpIndicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)pullUpIndicatorView {
    return objc_getAssociatedObject(self, &UIScrollViewPullToLoadMoreView);
}

- (void)setRefreshState:(GKRefreshState)refreshState {
    @synchronized(self) {
        GKRefreshState state = [self refreshState];
        if (state != refreshState) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATIONNAME_REFRESHCONTROL_STATECHANGE
                                                                object:nil
                                                              userInfo:@{NOTIFICATIONKEY_REFRESHCONTROL_OLDSTATE:@(state),NOTIFICATIONKEY_REFRESHCONTROL_NEWSTATE:@(refreshState)}];
        }
        objc_setAssociatedObject(self, &UIScrollViewRefreshState, @(refreshState), OBJC_ASSOCIATION_ASSIGN);
    }
}

- (GKRefreshState)refreshState {
    @synchronized(self) {
        NSNumber *number = objc_getAssociatedObject(self, &UIScrollViewRefreshState);
        GKRefreshState state = (GKRefreshState)[number intValue];
        return state;
    }
}

- (void)setOriginalContentInset:(UIEdgeInsets)originalContentInset {
    @synchronized(self) {
        NSValue *value = nil;
        if (!UIEdgeInsetsEqualToEdgeInsets(originalContentInset, UIEdgeInsetsZero)) {
            value = [NSValue valueWithUIEdgeInsets:originalContentInset];
        }
        objc_setAssociatedObject(self, &UIScrollViewOriginalContentInset, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIEdgeInsets)originalContentInset {
    @synchronized(self) {
        NSValue *value = objc_getAssociatedObject(self, &UIScrollViewOriginalContentInset);
        UIEdgeInsets inset = [value UIEdgeInsetsValue];
        if (value == nil) {
            inset = self.contentInset;
        }
        return inset;
    }
}

- (void)setRefreshControlDelegate:(id<GKRefreshControlDelegate>)refreshControlDelegate {
    objc_setAssociatedObject(self, &UIScrollViewGKRefreshControlDelegate, refreshControlDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<GKRefreshControlDelegate>)refreshControlDelegate {
    return objc_getAssociatedObject(self, &UIScrollViewGKRefreshControlDelegate);
}

#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGFloat pullDownOffset = -(self.contentOffset.y + self.originalContentInset.top);
        if (pullDownOffset >= 0) {
            [self judgePullDownStateWithOffset:pullDownOffset];
        }
        else if (self.contentSize.height > CGRectGetHeight(self.bounds) && self.contentOffset.y >= (self.contentSize.height - CGRectGetHeight(self.bounds) + self.originalContentInset.bottom)) {
            CGFloat pullUpOffset = self.contentOffset.y - (self.contentSize.height+self.originalContentInset.bottom - CGRectGetHeight(self.bounds));
            [self judgePullUpStateWithOffset:pullUpOffset];
        }
    }
    else if ([keyPath isEqualToString:@"contentInset"]) {
        CGFloat indicatorHeight = self.refreshState == GKRefreshState_PullDown_Refreshing ? KRefreshThreshold : 0;
        UIView *view = self.pullDownIndicatorView;
        [UIView transitionWithView:view duration:0.36f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [view setFrame:CGRectMake(0, -indicatorHeight, CGRectGetWidth(self.bounds), indicatorHeight)];
        } completion:nil];
    }
}

- (void)judgePullDownStateWithOffset:(CGFloat)pullDownOffset {
    [self.pullDownIndicatorView setFrame:CGRectMake(0, -pullDownOffset, CGRectGetWidth(self.bounds), pullDownOffset)];
    [self.pullDownIndicatorView setNeedsDisplay];
    
    GKRefreshState state = self.refreshState;
    if (self.dragging == NO && state == GKRefreshState_PullDown_ReadyRefresh && pullDownOffset > KRefreshThreshold) {
        [self startPullDownLoading];
    }
    else if (state != GKRefreshState_PullDown_Refreshing && state != GKRefreshState_PullUp_Refreshing) {
        if (pullDownOffset <= 0) {
            [self setRefreshState:GKRefreshState_None];
        }
        else if (pullDownOffset > 0 && pullDownOffset < KRefreshThreshold) {
            [self setRefreshState:GKRefreshState_PullDown_NotReady];
        }
        else if (pullDownOffset >= KRefreshThreshold) {
            [self setRefreshState:GKRefreshState_PullDown_ReadyRefresh];
        }
    }
}

- (void)judgePullUpStateWithOffset:(CGFloat)pullUpOffset {
    
    [self.pullUpIndicatorView setFrame:CGRectMake(0, self.contentSize.height, CGRectGetWidth(self.bounds), pullUpOffset)];
    [self.pullUpIndicatorView setNeedsDisplay];
    
    GKRefreshState state = self.refreshState;
    if (self.dragging == NO && state == GKRefreshState_PullUp_ReadyRefresh && pullUpOffset > KRefreshThreshold) {
        [self startPullUpLoading];
    }
    else if (state != GKRefreshState_PullDown_Refreshing && state != GKRefreshState_PullUp_Refreshing) {
        if (pullUpOffset <= 0) {
            [self setRefreshState:GKRefreshState_None];
        }
        else if (pullUpOffset > 0 && pullUpOffset < KRefreshThreshold) {
            [self setRefreshState:GKRefreshState_PullUp_NotReady];
        }
        else if (pullUpOffset >= KRefreshThreshold) {
            [self setRefreshState:GKRefreshState_PullUp_ReadyRefresh];
        }
    }
}


#pragma mark -

- (void)startPullDownLoading {
    
    [self setRefreshState:GKRefreshState_PullDown_Refreshing];
    [self setOriginalContentInset:self.contentInset];

    UIEdgeInsets newInsets = self.contentInset;
    newInsets.top = newInsets.top + KRefreshThreshold;
    CGPoint contentOffset = self.contentOffset;
    
    [UIView animateWithDuration:0 animations:^(void) {
        self.contentInset = newInsets;
        self.contentOffset = contentOffset;
    }];
    
    if ([self.refreshControlDelegate respondsToSelector:@selector(startPullDownLoading:)]) {
        [self.refreshControlDelegate startPullDownLoading:self];
    }
}

- (void)startPullUpLoading {
    [self setRefreshState:GKRefreshState_PullUp_Refreshing];
    [self setOriginalContentInset:self.contentInset];

    UIEdgeInsets newInsets = self.contentInset;
    newInsets.bottom = newInsets.bottom + KRefreshThreshold;
    CGPoint contentOffset = self.contentOffset;
    
    [UIView animateWithDuration:0 animations:^(void) {
        self.contentInset = newInsets;
        self.contentOffset = contentOffset;
    }];
    
    if ([self.refreshControlDelegate respondsToSelector:@selector(startPullUpLoading:)]) {
        [self.refreshControlDelegate startPullUpLoading:self];
    }
}

- (void)stopLoadingView {
    [self setRefreshState:GKRefreshState_None];
    /**
     *  下面会把 contentInset 设置成初值
     *  因为没有动画效果，会造成 GKIndicatorView 高度突变
     *  removeObserver 为解决 GKIndicatorView 高度突变措施之一
     */
    [self removeObserver:self forKeyPath:@"contentOffset"];
    [UIView animateWithDuration:0.36 animations:^{
        /**
         *  这里没有动画效果,依靠 contentInset 的 observer 给 GKIndicatorView 做动画高度变化
         */
        
        /**
         *  禁止手势，防止动画之后，GKIndicatorView 高度突变
         */
        [self.panGestureRecognizer setEnabled:NO];
        [self setContentInset:self.originalContentInset];
    } completion:^(BOOL finished) {
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self.panGestureRecognizer setEnabled:YES];
        [self setOriginalContentInset:UIEdgeInsetsZero];
    }];
}
@end