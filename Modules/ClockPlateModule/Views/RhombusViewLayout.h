//
//  RhombusViewLayout.h
//  PractiseDemo
//
//  Created by gukong on 15/7/15.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RhombusViewLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat interval;
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) NSInteger cellCount;

@end
