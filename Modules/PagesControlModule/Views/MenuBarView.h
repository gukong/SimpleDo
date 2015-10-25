//
//  MenuBarView.h
//  SimpleDo
//
//  Created by gukong on 15/9/2.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuBarView;

@protocol MenuBarViewDelegate <NSObject>

- (void)createNewEvent:(MenuBarView *)menuBarView;

@end

@interface MenuBarView : UIView

@property (nonatomic, weak) id<MenuBarViewDelegate> delegate;

@end
