//
//  ClockPlateView.m
//  SimpleDo
//
//  Created by gukong on 15/7/12.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "ClockPlateView.h"
#import "RhombusViewLayout.h"
#import "RhombusCell.h"
#import "ClockPlateDataManager.h"

@interface ClockPlateView ()<UICollectionViewDataSource, UICollectionViewDelegate> {
}

@property (nonatomic, strong) UICollectionView *rhombusCollection;

@end

@implementation ClockPlateView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    RhombusViewLayout *viewlayout = [[RhombusViewLayout alloc] init];
    [viewlayout setItemSize:CGSizeMake(140.f, 140.f)];
    
    _rhombusCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Width_V(self), Width_V(self))
                                            collectionViewLayout:viewlayout];
    [_rhombusCollection setBackgroundColor:[UIColor purpleColor]];
    [_rhombusCollection setDataSource:self];
    [_rhombusCollection registerClass:[RhombusCell class] forCellWithReuseIdentifier:@"RhombusCell"];
    [self addSubview:_rhombusCollection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return EventType_SUM;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RhombusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RhombusCell" forIndexPath:indexPath];
    ClockPlateDataItem *dataItem = [_dataManager dataItemAtIndex:indexPath.item];
    [cell configWithDataItem:dataItem];
    return cell;
}

@end
