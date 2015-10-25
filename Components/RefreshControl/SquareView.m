//
//  SquareView.m
//
//  Code generated using QuartzCode 1.32.1 on 15/8/30.
//  www.quartzcodeapp.com
//

#import "SquareView.h"
#import "QCMethod.h"

@interface SquareView ()

@property (nonatomic, strong) NSMutableDictionary * layers;
@property (nonatomic, strong) NSMapTable * completionBlocks;
@property (nonatomic, assign) BOOL  updateLayerValueForCompletedAnimation;


@end

@implementation SquareView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupProperties];
		[self setupLayers];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self setupProperties];
		[self setupLayers];
	}
	return self;
}

- (void)setFrame:(CGRect)frame{
	[super setFrame:frame];
	[self setupLayerFrames];
}

- (void)setBounds:(CGRect)bounds{
	[super setBounds:bounds];
	[self setupLayerFrames];
}

- (void)setupProperties{
	self.completionBlocks = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory valueOptions:NSPointerFunctionsStrongMemory];;
	self.layers = [NSMutableDictionary dictionary];
    _fillColor = [UIColor redColor];
}

- (void)setupLayers{
	self.backgroundColor = [UIColor clearColor];
	
	CAShapeLayer * Square = [CAShapeLayer layer];
	[self.layer addSublayer:Square];
	self.layers[@"Square"] = Square;
	
	[self setupLayerFrames];
	[self resetLayerPropertiesForLayerIdentifiers:nil];
}

- (void)resetLayerPropertiesForLayerIdentifiers:(NSArray *)layerIds{
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	
	if(!layerIds || [layerIds containsObject:@"Square"]){
		CAShapeLayer * Square = self.layers[@"Square"];
		Square.fillColor = _fillColor.CGColor;
		Square.lineWidth = 0;
	}
	
	[CATransaction commit];
}

- (void)setupLayerFrames{
	CAShapeLayer * Square = self.layers[@"Square"];
	Square.frame          = CGRectMake(0, 0,  CGRectGetWidth(Square.superlayer.bounds),  CGRectGetHeight(Square.superlayer.bounds));
	Square.path           = [self SquarePathWithBounds:[self.layers[@"Square"] bounds]].CGPath;
	
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self resetLayerPropertiesForLayerIdentifiers:nil];
}

#pragma mark - Animation Setup

- (void)addRorationAnimation{
    [self resetLayerPropertiesForLayerIdentifiers:@[@"Square"]];
    
    NSString * fillMode = kCAFillModeForwards;
    
    ////An infinity animation
        
    ////Square animation
    CAKeyframeAnimation * SquareTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    SquareTransformAnim.values      = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-50 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-40 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-45 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-45 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(2, 2, 1), CATransform3DMakeRotation(45 * M_PI/180, 0, -0, 1))],
                                        [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(0.9, 0.9, 1), CATransform3DMakeRotation(45 * M_PI/180, 0, -0, 1))],
                                        [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(1.1, 1.1, 1), CATransform3DMakeRotation(45 * M_PI/180, 0, -0, 1))],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-45 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-45 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-95 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-85 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-90 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-90 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(2, 2, 1), CATransform3DMakeRotation(90 * M_PI/180, 0, -0, 1))],
                                        [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(0.9, 0.9, 1), CATransform3DMakeRotation(90 * M_PI/180, 0, -0, 1))],
                                        [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(1.1, 1.1, 1), CATransform3DMakeRotation(90 * M_PI/180, 0, -0, 1))],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-90 * M_PI/180, 0, 0, -1)],
                                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-90 * M_PI/180, 0, 0, -1)]];
    SquareTransformAnim.keyTimes    = @[@0, @0.112, @0.133, @0.151, @0.173, @0.33, @0.423, @0.441, @0.459, @0.491, @0.612, @0.631, @0.651, @0.673, @0.836, @0.932, @0.952, @0.969, @1];
    SquareTransformAnim.duration    = 3;
    SquareTransformAnim.repeatCount = INFINITY;
    
    CAAnimationGroup * SquareRorationAnim = [QCMethod groupAnimations:@[SquareTransformAnim] fillMode:fillMode];
    [self.layers[@"Square"] addAnimation:SquareRorationAnim forKey:@"SquareRorationAnim"];
}

#pragma mark - Animation Cleanup

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    void (^completionBlock)(BOOL) = [self.completionBlocks objectForKey:anim];;
    if (completionBlock){
        [self.completionBlocks removeObjectForKey:anim];
        if ((flag && self.updateLayerValueForCompletedAnimation) || [[anim valueForKey:@"needEndAnim"] boolValue]){
            [self updateLayerValuesForAnimationId:[anim valueForKey:@"animId"]];
            [self removeAnimationsForAnimationId:[anim valueForKey:@"animId"]];
        }
        completionBlock(flag);
    }
}

- (void)updateLayerValuesForAnimationId:(NSString *)identifier{
    if([identifier isEqualToString:@"Roration"]){
        [QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"Square"] animationForKey:@"SquareRorationAnim"] theLayer:self.layers[@"Square"]];
    }
}

- (void)removeAnimationsForAnimationId:(NSString *)identifier{
    if([identifier isEqualToString:@"Roration"]){
        [self.layers[@"Square"] removeAnimationForKey:@"SquareRorationAnim"];
    }
}

#pragma mark - Bezier Path

- (UIBezierPath*)SquarePathWithBounds:(CGRect)bound{
    UIBezierPath*  SquarePath = [UIBezierPath bezierPathWithRect:bound];
    return SquarePath;
}

@end