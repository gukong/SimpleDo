//
//  EventLevelSelectView.m
//  SimpleDo
//
//  Created by gukong on 15/11/30.
//  Copyright © 2015年 gukong. All rights reserved.
//

#import "EventLevelSelectView.h"
#import "TopTrangleBubbleView.h"

static CGFloat const kELSView_Min_Radius = 20.f;
static CGFloat const kELSView_Max_Radius = 25.f;
static CGFloat const kELSView_Oval_Interval = (kELSView_Max_Radius - kELSView_Min_Radius)/2;
static NSString *const EventLevelSelectView_Notification_DidSelect = @"EventLevelSelectView_Notification_DidSelect";

@interface EventLevelSelectView ()
@property (nonatomic, assign) EventType eventType;
@end
@implementation EventLevelSelectView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)eventLevelSelectViewWithEventType:(EventType)eventType {
    EventLevelSelectView *selectView = [[EventLevelSelectView alloc] init];
    [selectView setEventType:eventType];
    [selectView setBackgroundColor:[UIColor clearColor]];
    [selectView setupViews];
    return selectView;
}

- (void)setupViews {
    NSString *title = @"";
    switch (_eventType) {
        case EventType_IM_EM:
            title = Localized("title_im_em");
            break;
        case EventType_IM_NEM:
            title = Localized("title_im_nem");
            break;
        case EventType_NIM_EM:
            title = Localized("title_nim_em");
            break;
        case EventType_NIM_NEM:
            title = Localized("title_nim_nem");
            break;
        case EventType_SUM:
            break;
    }
    TopTrangleBubbleView *bubbleView = [TopTrangleBubbleView topTrangleBubbleViewWithText:title];
    [bubbleView setCenter:CGPointMake(bubbleView.width/2, kELSView_Max_Radius + 5 + bubbleView.height/2)];
    [self addSubview:bubbleView];
    
    self.bounds = CGRectMake(0, 0, bubbleView.width, CGRectGetMaxY(bubbleView.frame));
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSelectEventNotification:) name:EventLevelSelectView_Notification_DidSelect object:nil];
    [self addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)drawRect:(CGRect)frame {
    //// Subframes
    CGRect group = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - kELSView_Max_Radius) * 0.5), CGRectGetMinY(frame)+2, kELSView_Max_Radius, kELSView_Max_Radius);
    
    //// Group
    {
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(group) + kELSView_Oval_Interval, CGRectGetMinY(group) + kELSView_Oval_Interval, kELSView_Min_Radius, kELSView_Min_Radius)];
        [self.tintColor setFill];
        [ovalPath fill];
        
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(group), CGRectGetMinY(group), kELSView_Max_Radius, kELSView_Max_Radius)];
        [[UIColor grayColor] setStroke];
        oval2Path.lineWidth = 1;
        [oval2Path stroke];
    }
}

#pragma mark - action

- (void)tapAction:(EventLevelSelectView *)sender {
    if (self.isSelected) {
        return;
    }
    
    [self setSelected:YES];
    self.tintColor = [UIColor blueColor];
    [self setNeedsDisplay];
    
    __weak __typeof(self) wself = self;
    [[NSNotificationCenter defaultCenter] postNotificationName:EventLevelSelectView_Notification_DidSelect object:wself];
}

#pragma mark - notification

- (void)didReceiveSelectEventNotification:(NSNotification *)notification {
    if (notification.object != self) {
        [self setSelected:NO];
        self.tintColor = [UIColor orangeColor];
        [self setNeedsDisplay];
    }
}

@end
