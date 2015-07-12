//
//  ClockPlateCollectionCell.m
//  SimpleDo
//
//  Created by gukong on 15/7/12.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "ClockPlateCollectionCell.h"

@interface ClockPlateCollectionCell ()<UICollectionViewDataSource> {
    CGFloat eventItemHeight;
}

@property (nonatomic, strong) UICollectionView *eventListView;

@end

@implementation ClockPlateCollectionCell

- (void)dealloc {
    [_clockPlateView removeObserver:self forKeyPath:@"radian"];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        eventItemHeight = 14.f;
        [self setupViews];
    }
    return self;
}

#pragma mark -

- (void)setupViews {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(Width_V(self)*0.95, eventItemHeight)];
    [flowLayout setMinimumLineSpacing:2.f];
    
    _eventListView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Width_V(self)*0.95, eventItemHeight * 3 + 4) collectionViewLayout:flowLayout];
    [_eventListView setCenter:CGPointMake(Width_V(self)/2, Height_V(self)/2)];
    [_eventListView setDataSource:self];
    [_eventListView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_eventListView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_eventListView];
}

#pragma mark -

- (void)setClockPlateView:(ClockPlateView *)clockPlateView {
    _clockPlateView= clockPlateView;
    [_clockPlateView addObserver:self forKeyPath:@"radian" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    [cell setBackgroundColor:UIColorFromRGBA(0xD3DEC3, 0.35f)];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius:7.5f];
    
    UILabel *lable = [[UILabel alloc] init];
    [lable setText:@"Today eat boot an foot list architecture"];
    [lable setFont:[UIFont systemFontOfSize:11.5f]];
    [lable sizeToFit];
    [cell addSubview:lable];
    
    return cell;
}

#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSNumber *value = [change objectForKey:@"new"];
    [_eventListView setTransform:CGAffineTransformMakeRotation(2 * M_PI - value.floatValue)];
}


@end
