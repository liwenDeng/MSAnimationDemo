//
//  MSBubbleView.m
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/22.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBubbleView.h"
#import "MSBadgeView.h"
#import "MSBubbleAnimationView.h"

@interface MSBubbleView ()

@property (nonatomic, strong)MSBadgeView* badgeView;

@property (nonatomic, strong)MSBubbleAnimationView* animationView;

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

@property (nonatomic, strong)UIView* drawView;  //拖拽时，所有视图动画在此视图上进行
@property (nonatomic, strong)CAShapeLayer* shapeLayer;
@property (nonatomic, strong)CAShapeLayer* circleLayer;

@property (nonatomic, assign)CGRect originFrame;//badgeView的初始位置
@property (nonatomic, assign)CGPoint originCenter;  //badgeView的初始中心位置

@end

@implementation MSBubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _badgeView = [[MSBadgeView alloc]initWithCustom];
        [self addSubview:_badgeView];

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragGesture:)];
        [_badgeView addGestureRecognizer:pan];
    }
    return self;
}

- (void)dragGesture:(UIPanGestureRecognizer*)sender {
    [self.animationView animateWithBadgeView:_badgeView gestureRecognizer:sender superView:self];
}


#pragma mark - Property
- (void)setBadge:(NSString *)badge {
    _badge = [badge copy];
    _badgeView.badge = badge;
}

- (MSBubbleAnimationView *)animationView {
    if (!_animationView) {
        _animationView = [[MSBubbleAnimationView alloc]initWithFrame:kKeyWindow.frame];
        _animationView.backgroundColor = [UIColor clearColor];
    }
    return _animationView;
}

@end
