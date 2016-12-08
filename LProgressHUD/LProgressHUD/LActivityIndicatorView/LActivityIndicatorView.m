//
//  LActivityIndicatorView.m
//  LProgressHUD
//
//  Created by Lester on 16/8/12.
//  Copyright © 2016年 Lester. All rights reserved.
//

#import "LActivityIndicatorView.h"
/** 画线速率*/
static const float DRAW_LINE_RATE = 7.5;
/** 周期*/
static const float RECURRENT = 4;
/** 一圈*/
static const float STROKE_STEP = 170;
static const float DRAW_LING_ROTATE = M_PI_4;

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define STROKE_END_RADIAN 180/RADIANS_TO_DEGREES(M_PI)
#define STROKE_PROCESS_RADIAN(angle) angle/RADIANS_TO_DEGREES(M_PI)

@interface LActivityIndicatorView()
/** 显示风格*/
@property (assign, nonatomic) LActivityIndicatorViewStyle indicatorViewStyle;

/** 主层*/
@property (strong, nonatomic) CALayer *centerLayer;
/** 左边的ShapeLayer*/
@property (strong, nonatomic) CAShapeLayer *leftShapeLayer;
/** 右边的ShapeLayer*/
@property (strong, nonatomic) CAShapeLayer *rightShapeLayer;
@property (nonatomic, strong) CABasicAnimation *strokeEndAnimation;
@property (nonatomic, strong) CABasicAnimation *rotateAnimation;

/** 图标*/
@property (strong, nonatomic) UIImageView *iconImageView;
@end

@implementation LActivityIndicatorView

-(instancetype)initWithFrame:(CGRect)frame IndicatorViewStyle:(LActivityIndicatorViewStyle)style{
    self = [super initWithFrame:frame];
    if(self){
        self.indicatorViewStyle = style;
        
        /** 判断是否是图标模式.否则只需默认*/
        if(self.indicatorViewStyle==LActivityIndicatorViewStyleIcon){
            [self addSubview:self.iconImageView];
        }
        [self drawAnchor];
        
        /** 注册通知*/
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillEnterForegroundNotification) name:@"applicationWillEnterForeground" object:nil];
    }
    return self;
}

-(void)startAnimation{
    [self clearAllAnimation];
    [self.leftShapeLayer addAnimation:self.strokeEndAnimation forKey:self.strokeEndAnimation.keyPath];
    [self.rightShapeLayer addAnimation:self.strokeEndAnimation forKey:self.strokeEndAnimation.keyPath];
    [self.centerLayer addAnimation:self.rotateAnimation forKey:self.rotateAnimation.keyPath];
}
-(void)stopAnimation{
    [self resetAnimation];
}
+(void)applicationWillEnterForeground{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"applicationWillEnterForeground" object:nil];
}

#pragma mark - privete function
- (void)applicationWillEnterForegroundNotification{
    [self startAnimation];
}
- (void)clearAllAnimation {
    [self.layer removeAllAnimations];
    [self resetAnimation];
}
- (void)resetAnimation {
    [self.leftShapeLayer removeAllAnimations];
    [self.rightShapeLayer removeAllAnimations];
    self.centerLayer.transform = CATransform3DIdentity;
    [self.centerLayer removeAllAnimations];
    [self.leftShapeLayer setStrokeEnd:0.01];
    [self.rightShapeLayer setStrokeEnd:0.01];
}
-(void)drawAnchor{
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    CGFloat radius = self.bounds.size.width/2;
    NSDictionary *angleResult = [self calculateAngle:30];

    CGFloat leftStartAngle = [[[angleResult objectForKey:@"left"] objectForKey:@"start"] doubleValue];
    CGFloat leftEndAngle = [[[angleResult objectForKey:@"left"] objectForKey:@"end"] doubleValue];
    CGFloat rightStartAngle = [[[angleResult objectForKey:@"right"] objectForKey:@"start"] doubleValue];
    CGFloat rightEndAngle = [[[angleResult objectForKey:@"right"] objectForKey:@"end"] doubleValue];
    UIBezierPath *lineLeft = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:DEGREES_TO_RADIANS(leftStartAngle) endAngle:DEGREES_TO_RADIANS(leftEndAngle) clockwise:YES];
    
    UIBezierPath *lineRight = [UIBezierPath bezierPathWithArcCenter:center radius:radius  startAngle:DEGREES_TO_RADIANS(rightStartAngle) endAngle:DEGREES_TO_RADIANS(rightEndAngle) clockwise:YES];
    
    self.leftShapeLayer.path = lineLeft.CGPath;
    self.rightShapeLayer.path = lineRight.CGPath;
}
- (NSDictionary *)calculateAngle:(CGFloat)leftStartPosition {
    CGFloat leftStartAngle = leftStartPosition;
    CGFloat leftEndAngle = leftStartPosition > 0 ? (leftStartPosition + STROKE_STEP) - 360: STROKE_STEP + leftStartPosition;
    CGFloat rightStartAngle = leftEndAngle + 10;
    CGFloat rightEndAngle = leftStartAngle - 10;
    return @{@"left" : @{@"start" : @(leftStartAngle), @"end" : @(leftEndAngle)}, @"right" : @{@"start" : @(rightStartAngle), @"end" : @(rightEndAngle)}};
}

#pragma mark - Set
-(void)setColor:(UIColor *)color{
    _color = color;
    self.leftShapeLayer.strokeColor = _color.CGColor;
    self.rightShapeLayer.strokeColor = _color.CGColor;
}
-(void)setImage:(UIImage *)image{
    _image = image;
    self.iconImageView.image = _image;
}

#pragma mark - 懒加载
-(CALayer *)centerLayer{
    if(!_centerLayer){
        _centerLayer = [CALayer new];
        _centerLayer.frame = self.bounds;
        [self.layer addSublayer:_centerLayer];
    }
    return _centerLayer;
}
- (CAShapeLayer *)leftShapeLayer{
    if(!_leftShapeLayer){
        _leftShapeLayer = [CAShapeLayer new];
        _leftShapeLayer.frame = self.bounds;
        _leftShapeLayer.lineWidth = RING_LINE_WIDTH;
        _leftShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _leftShapeLayer.strokeColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1].CGColor;
        _leftShapeLayer.lineCap = kCALineCapRound;
        [self.centerLayer  addSublayer:_leftShapeLayer];
    }
    return _leftShapeLayer;
}
- (CAShapeLayer *)rightShapeLayer{
    if(!_rightShapeLayer){
        _rightShapeLayer = [CAShapeLayer new];
        _rightShapeLayer.frame = self.bounds;
        _rightShapeLayer.lineWidth = RING_LINE_WIDTH;
        _rightShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _rightShapeLayer.strokeColor = [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1].CGColor;
        _rightShapeLayer.lineCap = kCALineCapRound;
        [self.centerLayer  addSublayer:_rightShapeLayer];
    }
    return _rightShapeLayer;
}
- (CABasicAnimation *)strokeEndAnimation {
    if (!_strokeEndAnimation) {
        _strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _strokeEndAnimation.fromValue = @(1 - STROKE_END_RADIAN);
        _strokeEndAnimation.toValue = @(STROKE_PROCESS_RADIAN(160));
        _strokeEndAnimation.duration = DRAW_LINE_RATE / SPEED;
        _strokeEndAnimation.repeatCount = HUGE_VAL;
        _strokeEndAnimation.removedOnCompletion = NO;
        _strokeEndAnimation.autoreverses = YES;
    }
    return _strokeEndAnimation;
}
- (CABasicAnimation *)rotateAnimation {
    if (!_rotateAnimation) {
        _rotateAnimation =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _rotateAnimation.duration = self.strokeEndAnimation.duration / RECURRENT;
        _rotateAnimation.fromValue = @(DRAW_LING_ROTATE + DEGREES_TO_RADIANS(30));
        _rotateAnimation.toValue = @(DRAW_LING_ROTATE + DEGREES_TO_RADIANS(30) + M_PI);
        _rotateAnimation.repeatCount = HUGE_VAL;
        _rotateAnimation.autoreverses = NO;
        _rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    return _rotateAnimation;
}
- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width - (self.bounds.size.width - LACTIVITY_ZOOM))/2, (self.bounds.size.height - (self.bounds.size.height - LACTIVITY_ZOOM))/2, self.bounds.size.width - LACTIVITY_ZOOM, self.bounds.size.height - LACTIVITY_ZOOM)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

@end
