//
//  GKGravityView.m
//  GKGravity
//
//  Created by gukong on 15/11/2.
//  Copyright © 2015年 Nate. All rights reserved.
//

#import "GKGravityView.h"
#import "ElasticRope.h"

@interface GKGravityView ()
{
    GKGravityViewCustomViewBlurStyle customViewBlurStyle;
    UIAttachmentBehavior *attachmentBehavior1;
    
    ElasticRope *elasticRope;
    CGFloat distance;
}
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIVisualEffectView *blurBgView;
@property (nonatomic, strong) UIVisualEffectView *vibrancyView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;

@end

@implementation GKGravityView

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"center"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addObserver];
    }
    return self;
}

- (void)addObserver {
    [self addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didMoveToSuperview {
    [self setupBehavior];
    [self setupCustomView:_customView fixedAnchorDistance:50.f blurStyle:customViewBlurStyle];
}

- (void)setupBehavior {
    if (!elasticRope) {
        elasticRope = [[ElasticRope alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    }
    [self.superview insertSubview:elasticRope belowSubview:self];
    /*
    UIGravityBehavior;
    UIAttachmentBehavior;
     */
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self]];
    [gravityBehavior setMagnitude:0.4f];
    [gravityBehavior setAngle:90*(M_PI / 180)];

    attachmentBehavior1 = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:CGPointMake(self.center.x, self.center.y-distance)];
    attachmentBehavior1.damping = 0.1f;
    attachmentBehavior1.frequency = 1.f;
    
    _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
    [_dynamicAnimator addBehavior:gravityBehavior];
    [_dynamicAnimator addBehavior:attachmentBehavior1];
    
 
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userActionWithGestureRecognizer:)];
    [self addGestureRecognizer:_panGestureRecognizer];
    
    [elasticRope setHeadPoint:attachmentBehavior1.anchorPoint];
    [elasticRope setTailPoint:_attachmentBehavior.anchorPoint];
}

- (void)setupBlurEffectViewWithEffectStyle:(UIBlurEffectStyle)effectStyle contentView:(UIView *)contentView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:effectStyle];
    _blurBgView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [_blurBgView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_blurBgView setFrame:self.bounds];
    [self addSubview:_blurBgView];
    
    //setup frame
    CGPoint oldCenter = _blurBgView.center;
    [_blurBgView setFrame:contentView.bounds];
    [_blurBgView setCenter:oldCenter];
    [_blurBgView.layer setCornerRadius:contentView.layer.cornerRadius];
    [_blurBgView.layer setMasksToBounds:contentView.layer.masksToBounds];
    [_blurBgView.contentView addSubview:contentView];
}

- (void)setupVibrancyEffectViewWithEffectStyle:(UIBlurEffectStyle)effectStyle contentView:(UIView *)contentView {
    [self setupBlurEffectViewWithEffectStyle:effectStyle contentView:contentView];
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)_blurBgView.effect];
    _vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [_blurBgView.contentView addSubview:_vibrancyView];
    
    //setup frame
    [_vibrancyView setFrame:contentView.bounds];
    [_vibrancyView.contentView addSubview:contentView];
}

- (void)removeAllBlurEffect {
    [_vibrancyView removeFromSuperview];
    _vibrancyView = nil;
    [_blurBgView removeFromSuperview];
    _blurBgView =nil;
}

- (void)setupCustomView:(UIView *)customView fixedAnchorDistance:(CGFloat)dis blurStyle:(GKGravityViewCustomViewBlurStyle)blurStyle {
    [_customView removeFromSuperview];
    _customView = customView;
    customViewBlurStyle = blurStyle;
    distance = dis;
    /**
     *  effect style
     */
    UIBlurEffectStyle effectStyle = UIBlurEffectStyleLight;
    if (blurStyle & GKGravityViewCustomViewBlurStyle_Effect_ExtraLight) {
        effectStyle = UIBlurEffectStyleExtraLight;
    }
    else if (blurStyle & GKGravityViewCustomViewBlurStyle_Effect_Dark) {
        effectStyle = UIBlurEffectStyleDark;
    }
    else {
        // default GKGravityViewCustomViewBlurStyle_Effect_Light
        effectStyle = UIBlurEffectStyleLight;
    }

    /**
     *  blureffect
     */
    if (blurStyle & GKGravityViewCustomViewBlurStyle_BlurEffect) {
        [self setupBlurEffectViewWithEffectStyle:effectStyle contentView:customView];
    }
    else if (blurStyle & GKGravityViewCustomViewBlurStyle_VibrancyEffect) {
        [self setupVibrancyEffectViewWithEffectStyle:effectStyle contentView:customView];
    }
    else {
        //default GKGravityViewCustomViewBlurStyle_None
        [self removeAllBlurEffect];
        
        CGPoint oldCenter = self.center;
        [self setBounds:customView.bounds];
        [self setCenter:oldCenter];
        [self addSubview:customView];
    }
}

- (UIAttachmentBehavior *)attachmentBehavior {
    if (_attachmentBehavior == nil) {
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:self.center];
        _attachmentBehavior.damping = 20.f;
        _attachmentBehavior.frequency = 1.f;
    }
    return _attachmentBehavior;
}

#pragma mark - action

- (void)userActionWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [_dynamicAnimator addBehavior:self.attachmentBehavior];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateCancelled ||
             gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [_dynamicAnimator removeBehavior:_attachmentBehavior];
        _attachmentBehavior = nil;
    }
    else {
        CGPoint point = [gestureRecognizer locationInView:self.superview];
        [_attachmentBehavior setAnchorPoint:point];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [elasticRope setTailPoint:CGPointMake(self.center.x, self.center.y-CGRectGetHeight(_customView.frame)/2)];
}
@end
