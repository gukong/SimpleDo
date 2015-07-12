//
//  ClockPlateView.m
//  SimpleDo
//
//  Created by gukong on 15/7/12.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "ClockPlateView.h"
#import "ClockPlateCollectionCell.h"

@interface ClockPlateView ()<UICollectionViewDataSource, UICollectionViewDelegate> {
    CGFloat interval;
    CGFloat currentAngle;
}

@property (nonatomic, strong) UICollectionView *clockCollectioniView;
@property (nonatomic, strong) NSTimer *rotateTimer;

@end

@implementation ClockPlateView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        interval = 5.f;
        currentAngle = 0.f;
        [self setupViews];
        [self setupTimer];
    }
    return self;
}

- (void)setupViews {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((Width_V(self)-interval) / 2, (Height_V(self)-interval)/2)];
    [flowLayout setMinimumInteritemSpacing:interval];
    [flowLayout setMinimumLineSpacing:interval];
    _clockCollectioniView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    [_clockCollectioniView registerClass:[ClockPlateCollectionCell class] forCellWithReuseIdentifier:@"ClockPlateCollectionCell"];
    [_clockCollectioniView setDataSource:self];
    [_clockCollectioniView setDelegate:self];
    [_clockCollectioniView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_clockCollectioniView];
}


#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClockPlateCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClockPlateCollectionCell" forIndexPath:indexPath];
    [cell setBackgroundColor:UIColorFromRGB(0x60A469)];
    [cell setClockPlateView:self];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius:5.f];
    return cell;
}

#pragma mark - Timer

- (void)setupTimer {
    _rotateTimer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(timefire:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_rotateTimer forMode:NSDefaultRunLoopMode];;
}

- (void)stopTimer {
    [_rotateTimer invalidate];
}

- (void)timefire:(NSTimer *)timer {
    [self willChangeValueForKey:@"radian"];
    self.radian = currentAngle*M_PI/180;
    [self didChangeValueForKey:@"radian"];
    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_clockCollectioniView setTransform:CGAffineTransformMakeRotation(_radian)];
    } completion:^(BOOL finished) {
        currentAngle += 1.f;
        if (currentAngle == 360.f) {
            currentAngle = 0.f;
        }
    }];
}


@end
