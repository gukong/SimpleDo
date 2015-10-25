//
//  MenuBarView.m
//  SimpleDo
//
//  Created by gukong on 15/9/2.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "MenuBarView.h"

@interface MenuBarView ()

@property (nonatomic, strong) UIButton *eventButton;
@property (nonatomic, strong) UITabBar *backView;

@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation MenuBarView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    _views = [[NSMutableArray alloc] init];
    
    _backView = [[UITabBar alloc] initWithFrame:self.bounds];
    [self addSubview:_backView];
    
    _eventButton = [[UIButton alloc] init];
    [_eventButton setSize:CGSizeMake(Height_V(self), Height_V(self))];
    [_eventButton setBackgroundColor:[UIColor redColor]];
    [_eventButton addTarget:self action:@selector(tapActionOnEventButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_eventButton];
    
    [_views addObject:_eventButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat interval = _views.count == 0 ? 0 : (Width_V(self) / (_views.count + 1));
    CGFloat initOffsetX = Width_V(self) / (_views.count+1);
    for (int i = 0; i < _views.count; i++) {
        UIView *view = _views[i];
        [view setCenter:CGPointMake(initOffsetX + interval * i, Height_V(self)/2)];
    }
}

- (void)tapActionOnEventButton:(id)sender {
    if ([_delegate respondsToSelector:@selector(createNewEvent:)]) {
        [_delegate createNewEvent:self];
    }
}

@end
