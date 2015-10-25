//
//  UIScrollView+GKRefresh.h
//  GKRefreshAndLoadTableView
//
//  Created by gukong on 15/8/20.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, GKRefreshState) {
    GKRefreshState_None = 0,
    GKRefreshState_PullDown_NotReady,
    GKRefreshState_PullDown_ReadyRefresh,
    GKRefreshState_PullDown_Refreshing,
    GKRefreshState_PullUp_NotReady,
    GKRefreshState_PullUp_ReadyRefresh,
    GKRefreshState_PullUp_Refreshing,
};

extern NSString * const NOTIFICATIONNAME_REFRESHCONTROL_STATECHANGE;
extern NSString * const NOTIFICATIONKEY_REFRESHCONTROL_OLDSTATE;
extern NSString * const NOTIFICATIONKEY_REFRESHCONTROL_NEWSTATE;


#pragma mark - GKRefreshControlDelegate
@protocol GKRefreshControlDelegate <NSObject>

@optional
- (void)startPullDownLoading:(UIScrollView *)scrollView;
- (void)startPullUpLoading:(UIScrollView *)scrollView;

@end

#pragma mark - UIScrollView (GKRefresh)
@interface UIScrollView (GKRefresh)

@property (nonatomic, assign) BOOL canPullDownToRefresh;
@property (nonatomic, assign) BOOL canPullUpToLoadMore;
@property (nonatomic, assign) GKRefreshState refreshState;
@property (nonatomic, weak) id<GKRefreshControlDelegate> refreshControlDelegate;

@property (nonatomic, strong) UIView *pullDownIndicatorView;
@property (nonatomic, strong) UIView *pullUpIndicatorView;


- (void)stopLoadingView;

@end