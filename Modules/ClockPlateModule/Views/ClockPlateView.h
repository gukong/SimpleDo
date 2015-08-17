//
//  ClockPlateView.h
//  SimpleDo
//
//  Created by gukong on 15/7/12.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClockPlateDataManager;

@interface ClockPlateView : UIView

@property (nonatomic, assign) CGFloat radian;
@property (nonatomic, weak) ClockPlateDataManager *dataManager;

@end
