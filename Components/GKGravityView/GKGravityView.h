//
//  GKGravityView.h
//  GKGravity
//
//  Created by gukong on 15/11/2.
//  Copyright © 2015年 Nate. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger,GKGravityViewCustomViewBlurStyle) {
    //blur effect style
    GKGravityViewCustomViewBlurStyle_None              = 0,     //default
    GKGravityViewCustomViewBlurStyle_BlurEffect        = 1 << 0,
    GKGravityViewCustomViewBlurStyle_VibrancyEffect    = 1 << 1,

    // blur style
    GKGravityViewCustomViewBlurStyle_Effect_Light      = 0 << 16,//default
    GKGravityViewCustomViewBlurStyle_Effect_ExtraLight = 1 << 16,
    GKGravityViewCustomViewBlurStyle_Effect_Dark       = 2 << 16
};

@interface GKGravityView : UIView

@property (nonatomic, assign) CGPoint anchorPoint;
@property (nonatomic, assign) CGFloat lineLength;
@property (nonatomic, strong, readonly) UIView *customView;

- (void)setupCustomView:(UIView *)customView fixedAnchorDistance:(CGFloat)distance blurStyle:(GKGravityViewCustomViewBlurStyle)blurStyle;

@end
