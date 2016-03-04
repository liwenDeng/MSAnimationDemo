//
//  MSBubbleView.m
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/22.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBubbleView.h"
#import "MSBubbleAnimationView.h"
#import "MSBadgeView.h"

@interface MSBubbleView ()

@property (nonatomic, strong)MSBadgeView* badgeView;
@property (nonatomic, strong)MSBubbleAnimationView* animationView;
@property (nonatomic, assign)MSBadgeViewAlignMode alignMode;

@end

@implementation MSBubbleView

- (instancetype)initWithFrame:(CGRect)frame bubbleColor:(UIColor*)bubbleColor titleColor:(UIColor*)titileColor fontSize:(CGFloat)fontSize alignMode:(MSBadgeViewAlignMode)alignMode {
    if (self = [super initWithFrame:frame]) {
        _alignMode = alignMode;
        _badgeView = [[MSBadgeView alloc]initWithBubbleColor:bubbleColor titleColor:titileColor fontSize:fontSize];
        [self addSubview:_badgeView];
    }
    return self;
}

- (instancetype)initWithCustomStyleFrame:(CGRect)frame {
    return [self initWithFrame:frame bubbleColor:[UIColor redColor] titleColor:[UIColor whiteColor] fontSize:14.0 alignMode:(MSBadgeViewAlignRight)];
}

- (void)dragGesture:(UIPanGestureRecognizer*)sender {
    [self.animationView animateWithBadgeView:_badgeView gestureRecognizer:sender superView:self];
}

#pragma mark - Property
- (void)setBadge:(NSString *)badge {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragGesture:)];
    [_badgeView addGestureRecognizer:pan];
    
    _badge = [badge copy];
    _badgeView.badge = badge;
    
    // 设置对齐方式
    switch (_alignMode) {
        case MSBadgeViewAlignLeft:
        {
            _badgeView.frame = CGRectMake(0, 0, _badgeView.frame.size.width, _badgeView.frame.size.height);
            _badgeView.center = CGPointMake(_badgeView.center.x, self.frame.size.height/2);
        }
            break;
        case MSBadgeViewAlignCenter:
        {
            _badgeView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        }
            break;
        case MSBadgeViewAlignRight:
        {
            _badgeView.frame = CGRectMake(self.frame.size.width - _badgeView.frame.size.width, 0, _badgeView.frame.size.width, _badgeView.frame.size.height);
            _badgeView.center = CGPointMake(_badgeView.center.x, self.frame.size.height/2);
        }
        default:
            break;
    }
}

- (MSBubbleAnimationView *)animationView {
    if (!_animationView) {
        _animationView = [[MSBubbleAnimationView alloc]initWithFrame:kKeyWindow.frame];
        _animationView.backgroundColor = [UIColor clearColor];
        _animationView.seperateScale = self.seperateScale;
    }
    return _animationView;
}

- (void)setSeperateScale:(CGFloat)seperateScale {
    _seperateScale = seperateScale;
}

@end
