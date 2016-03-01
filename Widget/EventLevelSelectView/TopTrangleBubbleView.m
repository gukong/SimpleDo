//
//  TopTrangleBubbleView.m
//  SimpleDo
//
//  Created by gukong on 15/12/6.
//  Copyright © 2015年 gukong. All rights reserved.
//

#import "TopTrangleBubbleView.h"

static CGFloat const trangleSize = 10.f;
static CGFloat const trangle_rectangle_offset = -3.f;
static CGFloat const kTTBView_MinWidth = 60.f;
static UIFont * textFont;

@interface TopTrangleBubbleView ()
@property (nonatomic, strong) NSString *textString;
@end

@implementation TopTrangleBubbleView


+ (instancetype)topTrangleBubbleViewWithText:(NSString *)text {
    textFont = [UIFont systemFontOfSize:10.f];
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: textFont};
    
    CGFloat textWidth = [text boundingRectWithSize: CGSizeMake(INFINITY, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.width;
    textWidth = textWidth > kTTBView_MinWidth ? textWidth : kTTBView_MinWidth;
    CGRect frame = CGRectMake(0, 0, textWidth, 40.f);
    
    TopTrangleBubbleView *bubbleView = [[TopTrangleBubbleView alloc] initWithFrame:frame];
    [bubbleView setBackgroundColor:[UIColor clearColor]];
    [bubbleView setTextString:text];
    return bubbleView;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)frame {
    // Drawing code
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    //// Subframes
    CGRect frame2 = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - trangleSize) * 0.5), 0, trangleSize, trangleSize);
    CGRect group = CGRectMake(CGRectGetMinX(frame2), CGRectGetMinY(frame2), CGRectGetWidth(frame2), CGRectGetHeight(frame2));
    
    
    //// Group
    {
        //// Bezier Drawing
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.59387 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.07797 * CGRectGetHeight(group))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.50000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.59387 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.07797 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.55556 * CGRectGetWidth(group), CGRectGetMinY(group) + -0.00000 * CGRectGetHeight(group))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(group) + 0.41025 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.06863 * CGRectGetHeight(group)) controlPoint1: CGPointMake(CGRectGetMinX(group) + 0.44444 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group)) controlPoint2: CGPointMake(CGRectGetMinX(group) + 0.41025 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.06863 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.00000 * CGRectGetWidth(group), CGRectGetMinY(group) + 1.00000 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 1.00000 * CGRectGetWidth(group), CGRectGetMinY(group) + 1.00000 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.59387 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.07797 * CGRectGetHeight(group))];
        [bezierPath closePath];
        [UIColor.grayColor setFill];
        [bezierPath fill];
    }
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, trangleSize+trangle_rectangle_offset, CGRectGetWidth(frame), CGRectGetHeight(frame) - trangleSize) cornerRadius: 5];
    [UIColor.grayColor setFill];
    [rectanglePath fill];
    
    //// Text Drawing
    CGRect textRect = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.60909 + 0.5), floor(CGRectGetWidth(frame) * 1.00000 + 0.5) - floor(CGRectGetWidth(frame) * 0.00000 + 0.5), 21);
    {
        NSString* textContent = _textString;
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: textFont, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }

}


@end
