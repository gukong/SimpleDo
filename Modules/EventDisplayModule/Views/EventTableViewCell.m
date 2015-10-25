//
//  EventTableViewCell.m
//  SimpleDo
//
//  Created by gukong on 15/8/30.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "EventTableViewCell.h"
#import "GKSelectedView.h"
#import "EventItem.h"


@interface EventTableViewCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) GKSelectedView *completeFlagView;
@property (nonatomic, strong) UILabel *eventDesLabel;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) EventItem *eventItem;

@end

@implementation EventTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setFrame:CGRectMake(0, 0, 40.f, 14.f)];
    [_timeLabel setFont:[UIFont systemFontOfSize:11.f]];
    [self addSubview:_timeLabel];
    
    _completeFlagView = [[GKSelectedView alloc] init];
    [self addSubview:_completeFlagView];
    
    _eventDesLabel = [[UILabel alloc] init];
    [_eventDesLabel setFrame:CGRectMake(84.f, 0, 143.f, 12)];
    [_eventDesLabel setFont:[UIFont systemFontOfSize:13.f]];
    [self addSubview:_eventDesLabel];
}

- (void)configWithEventItem:(EventItem *)eventItem {
    _eventItem = eventItem;
    
    [_timeLabel setText:_eventItem.startTime];
    
    [_eventDesLabel setText:_eventItem.sectionIdentifier];
    
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_timeLabel setCenterY:Height_V(self)/2];
    [_eventDesLabel setCenterY:Height_V(self)/2];
}

@end