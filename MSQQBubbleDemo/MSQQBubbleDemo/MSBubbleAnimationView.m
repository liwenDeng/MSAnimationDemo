//
//  MSBubbleAnimationView.m
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/24.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBubbleAnimationView.h"

#define kBubbleDestoryDuration 0.3f

typedef enum : NSUInteger {
    MSBubbleViewStateUnknown = 0,   //未知状态
    MSBubbleViewStateWillConnect = 1,   //将要粘连
    MSBubbleViewStateDidConnect = 2,   //粘连状态
    MSBubbleViewStateSeperated = 3,  //分离状态
    MSBubbleViewStatecoincide = 4,   //重合状态
    MSBubbleViewStateHidden = 5      //隐藏状态
} MSBubbleViewState;

@interface MSBubbleAnimationView ()

////气泡最初位置
@property (nonatomic, assign)CGFloat r1;
@property (nonatomic, assign)CGFloat x1;
@property (nonatomic, assign)CGFloat y1;

//拖拽后气泡位置
@property (nonatomic, assign)CGFloat r2;
@property (nonatomic, assign)CGFloat x2;
@property (nonatomic, assign)CGFloat y2;

@property (nonatomic, assign)CGFloat centerDistance;//两个圆心距离
@property (nonatomic, assign)CGFloat cosDigree;
@property (nonatomic, assign)CGFloat sinDigree;

@property (nonatomic, assign)CGPoint pointA;
@property (nonatomic, assign)CGPoint pointB;
@property (nonatomic, assign)CGPoint pointC;
@property (nonatomic, assign)CGPoint pointD;

//控制点
@property (nonatomic, assign)CGPoint pointO;
@property (nonatomic, assign)CGPoint pointP;

@property (nonatomic)UIBezierPath* cutePath;

@property (nonatomic, strong)CAShapeLayer* shapeLayer;
@property (nonatomic, strong)CAShapeLayer* circleLayer;

@property (nonatomic, assign)CGRect originFrame;    //badgeView在原始视图中的初始位置
@property (nonatomic, assign)CGPoint originCenterInself;  //badgeView的初始中心位置
@property (nonatomic, assign)CGRect originFrameInself;    //badgeView在self中的初始位置

@property (nonatomic, assign)MSBubbleViewState state;   //bubbleView状态

@property (nonatomic, strong)NSMutableArray* destoryImages;

@end

@implementation MSBubbleAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _shapeLayer = [CAShapeLayer layer];
        _circleLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_shapeLayer];
        [self.layer addSublayer:_circleLayer];
    }
    return self;
}

- (void)animateWithBadgeView:(MSBadgeView *)badgeView gestureRecognizer:(UIPanGestureRecognizer *)sender superView:(UIView *)superView {
    
    // 显示到顶部视图
    [kTopView addSubview:self];
    
    CGPoint dragPoint = [sender locationInView:self];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (!_shapeLayer.superlayer) {
            [self.layer addSublayer:_shapeLayer];
        }
        if (!_circleLayer.superlayer) {
            [self.layer addSublayer:_circleLayer];
        }
        _state = MSBubbleViewStateWillConnect;
        _originFrame = badgeView.frame;
        // 坐标转换
        CGRect beginFrame = [badgeView convertRect:badgeView.frame toView:self];
        _originFrameInself = beginFrame;
        CGPoint beginPoint = [badgeView.superview convertPoint:badgeView.center toView:self];
        _originCenterInself = beginPoint;
        badgeView.center = _originCenterInself;
        
        _shapeLayer.path = nil;
        [self addSubview:badgeView];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        badgeView.center = dragPoint;
        _state = [self drawRectWithBadgeView:badgeView superView:(UIView*)superView];
    }
    else if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        BOOL isInSide = CGRectContainsPoint(_originFrameInself, dragPoint);
        if (_state == MSBubbleViewStateSeperated) {
            if (isInSide ) {
                // 重合，需要复原不隐藏
                _state = MSBubbleViewStatecoincide;
                [self restoreAnimationWithBadgeView:badgeView superView:superView animation:NO];
            }
            else {
                // 未重合，需要复原隐藏,并显示消失动画
                _state = MSBubbleViewStateHidden;
                badgeView.hidden = YES;
                
                [self startDestroyAnimationsWithBadgeView:badgeView superView:superView];
//                [self restoreAnimationWithBadgeView:badgeView superView:superView animation:YES];
                
            }
        }
        else {
            // 未分离，复原不隐藏
            [self restoreAnimationWithBadgeView:badgeView superView:superView animation:YES];
        }

    } else {
        _state = MSBubbleViewStateUnknown;
    }
}

- (MSBubbleViewState)drawRectWithBadgeView:(MSBadgeView*)badgeView superView:(UIView*)superView {
    _x1 = _originCenterInself.x;
    _y1 = _originCenterInself.y;
    
    _x2 = badgeView.center.x;
    _y2 = badgeView.center.y;
    
    _centerDistance = sqrtf((_x2-_x1)*(_x2-_x1) + (_y2-_y1)*(_y2-_y1));
    if (_centerDistance == 0) {
        _cosDigree = 1;
        _sinDigree = 0;
    }else{
        _cosDigree = (_y2-_y1)/_centerDistance;
        _sinDigree = (_x2-_x1)/_centerDistance;
    }
    
    _r1 = _originFrame.size.height / 2 - _centerDistance / 10;
    _r2 = _originFrame.size.height / 2 - _centerDistance / 20;
    
    // 判断分离时的距离
    if (_r1 <= _originFrame.size.height / 2 * 0.2) {
        [self shouldClearShapeLayer];
        return MSBubbleViewStateSeperated;
    }
    
    _pointA = CGPointMake(_x1-_r1*_cosDigree, _y1+_r1*_sinDigree);  // A
    _pointB = CGPointMake(_x1+_r1*_cosDigree, _y1-_r1*_sinDigree); // B
    _pointD = CGPointMake(_x2-_r2*_cosDigree, _y2+_r2*_sinDigree); // D
    _pointC = CGPointMake(_x2+_r2*_cosDigree, _y2-_r2*_sinDigree); // C
    //_pointO = CGPointMake(_pointA.x + (_centerDistance / 2)*_sinDigree, _pointA.y + (_centerDistance / 2)*_cosDigree);
    //_pointP = CGPointMake(_pointB.x + (_centerDistance / 2)*_sinDigree, _pointB.y + (_centerDistance / 2)*_cosDigree);
    _pointP = CGPointMake((_x1 + _x2)/2, (_y1 + _y2)/2);
    _pointO = CGPointMake((_x1 + _x2)/2, (_y1 + _y2)/2);

    // 弹性路径
    _cutePath = [UIBezierPath bezierPath];
    
    [_cutePath moveToPoint:_pointA];
    [_cutePath addQuadCurveToPoint:_pointD controlPoint:_pointO];
    [_cutePath addLineToPoint:_pointC];
    [_cutePath addQuadCurveToPoint:_pointB controlPoint:_pointP];

    self.shapeLayer.path = [_cutePath CGPath];
    self.shapeLayer.fillColor = badgeView.bubbleColor.CGColor;
    
    // 圆路径
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_x1, _y1) radius:_r1 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    self.circleLayer.path = circlePath.CGPath;
    self.circleLayer.fillColor = badgeView.bubbleColor.CGColor;

    return MSBubbleViewStateDidConnect;
}

- (void)restoreAnimationWithBadgeView:(MSBadgeView*)badgeView superView:(UIView*)superView animation:(BOOL)animated{
    
    [self.shapeLayer removeFromSuperlayer];
    badgeView.userInteractionEnabled = NO;
    if (animated) {
        [UIView animateWithDuration:0.3 delay:0.0f usingSpringWithDamping:0.3 initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            badgeView.center = CGPointMake(_x1, _y1);
        } completion:^(BOOL finished) {
            [badgeView removeFromSuperview];
            badgeView.frame = _originFrame;
            [superView addSubview:badgeView];
            badgeView.userInteractionEnabled = YES;
            [self removeFromSuperview];
        }];
    }else {
        [badgeView removeFromSuperview];
        badgeView.frame = _originFrame;
        [superView addSubview:badgeView];
        badgeView.userInteractionEnabled = YES;
        [self removeFromSuperview];
    }
}

/**
 *  分离时需要清除绘制的路径
 */
- (void)shouldClearShapeLayer {
    [_circleLayer removeFromSuperlayer];
    [_shapeLayer removeFromSuperlayer];
    _circleLayer.path = nil;
    _shapeLayer.path = nil;
}

/**
 *  消失动画
 */
- (void)startDestroyAnimationsWithBadgeView:(MSBadgeView*)badgeView superView:(UIView*)superView;
{

    //加载气泡消失gif
    UIImageView *ainmImageView = [[UIImageView alloc] initWithFrame:badgeView.frame];
    ainmImageView.animationImages = self.destoryImages;
    ainmImageView.animationRepeatCount = 1;
    ainmImageView.animationDuration = kBubbleDestoryDuration;
    ainmImageView.backgroundColor = [UIColor clearColor];
    [ainmImageView startAnimating];
    [self addSubview:ainmImageView];

    //延迟时间与气泡动画时间相同
    [UIView animateWithDuration:0.3 delay:kBubbleDestoryDuration usingSpringWithDamping:0.3 initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        badgeView.center = CGPointMake(_x1, _y1);
    } completion:^(BOOL finished) {
        [badgeView removeFromSuperview];
        badgeView.frame = _originFrame;
        [superView addSubview:badgeView];
        badgeView.userInteractionEnabled = YES;
        [self removeFromSuperview];
    }];
    
}


#pragma mark -layLoading
- (NSMutableArray *)destoryImages {
    if (!_destoryImages) {
        _destoryImages = [NSMutableArray array];
        for (int i = 1; i < 9; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
            [_destoryImages addObject:image];
        }
    }
    return _destoryImages;
}


@end
