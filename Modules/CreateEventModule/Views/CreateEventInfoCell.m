//
//  CreateEventInfoCell.m
//  SimpleDo
//
//  Created by gukong on 15/12/6.
//  Copyright © 2015年 gukong. All rights reserved.
//

#import "CreateEventInfoCell.h"
#import "EventLevelSelectView.h"

@interface CreateEventInfoCell ()
@property (nonatomic,strong) NSArray *selectViews;
@end

@implementation CreateEventInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    EventLevelSelectView *selectView0 = [EventLevelSelectView eventLevelSelectViewWithEventType:EventType_IM_EM];
    [selectView0 addTarget:self action:@selector(tapActionOnSelectView:) forControlEvents:UIControlEventTouchUpInside];
    EventLevelSelectView *selectView1 = [EventLevelSelectView eventLevelSelectViewWithEventType:EventType_IM_NEM];
    [selectView1 addTarget:self action:@selector(tapActionOnSelectView:) forControlEvents:UIControlEventTouchUpInside];
    EventLevelSelectView *selectView2 = [EventLevelSelectView eventLevelSelectViewWithEventType:EventType_NIM_EM];
    [selectView2 addTarget:self action:@selector(tapActionOnSelectView:) forControlEvents:UIControlEventTouchUpInside];
    EventLevelSelectView *selectView3 = [EventLevelSelectView eventLevelSelectViewWithEventType:EventType_NIM_NEM];
    [selectView3 addTarget:self action:@selector(tapActionOnSelectView:) forControlEvents:UIControlEventTouchUpInside];
    _selectViews = @[selectView0, selectView1, selectView2, selectView3];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat interval = self.width/5;
    int i = 0;
    for (EventLevelSelectView *selectView in _selectViews) {
        [selectView setCenter:CGPointMake(interval * (i+1), self.height/2)];
        [self addSubview:selectView];
        i ++;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tapActionOnSelectView:(EventLevelSelectView *)selectView {
    
}

@end
