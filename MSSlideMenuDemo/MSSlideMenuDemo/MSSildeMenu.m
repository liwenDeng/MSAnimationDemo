//
//  MSSiledMenu.m
//  MSSlideMenuDemo
//
//  Created by dengliwen on 16/2/17.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSSildeMenu.h"
#import "MSSlideMenuButton.h"

#define buttonSpace 30
#define menuBlankWidth 50

@interface MSSildeMenu()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSInteger animationCount;// 正在进行的动画的数量

@end

@implementation MSSildeMenu
{
    UIView *bgView; // 增加一个bgView来作为menu的容器，当隐藏时从keyWindow移除避免对keyWindow的入侵
    UIVisualEffectView *blurView;   //模糊视图
    UIView *helperTopView;  //顶部辅助视图
    UIView *helperCenterView;   //中间辅助视图
    UIWindow *keyWindow;
    BOOL triggered; //记录当前触发状态
    CGFloat diff;   //顶部与中间辅助视图的间距
    UIColor *_menuColor;
    CGFloat menuButtonHeight;
}

- (id)initWithTitles:(NSArray *)titles {
    return [self initWithTitles:titles ButtonHeight:40.0f MenuColor:[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1] BackBlurStyle:UIBlurEffectStyleDark];
}

- (instancetype)initWithTitles:(NSArray *)titles ButtonHeight:(CGFloat)height MenuColor:(UIColor *)menuColor BackBlurStyle:(UIBlurEffectStyle)style{
    if (self = [super init]) {
        keyWindow = [UIApplication sharedApplication].keyWindow;
        
        bgView = [[UIView alloc]initWithFrame:keyWindow.bounds];
        bgView.backgroundColor = [UIColor clearColor];
        
        // 背景模糊视图
        blurView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:style]];
        blurView.frame = keyWindow.frame;
        blurView.alpha = 0.0f;
        
        // 顶部辅助视图
        helperTopView = [[UIView alloc]initWithFrame:CGRectMake(-40, 0, 40, 40)];
        helperTopView.backgroundColor = [UIColor redColor];
        helperTopView.hidden = YES;
        [bgView addSubview:helperTopView];
        
        // 中间辅助视图
        helperCenterView = [[UIView alloc]initWithFrame:CGRectMake(-40, CGRectGetHeight(keyWindow.frame)/2-20, 40, 40)];
        helperCenterView.backgroundColor = [UIColor yellowColor];
        [bgView addSubview:helperCenterView];
        
        self.frame = CGRectMake(- keyWindow.frame.size.width/2 - menuBlankWidth, 0, keyWindow.frame.size.width/2 + menuBlankWidth, keyWindow.frame.size.height);
        helperCenterView.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        [bgView insertSubview:self belowSubview:helperTopView];
        
        _menuColor = menuColor;
        menuButtonHeight = height;
        
        [self addButtons:titles];
    }
    return self;
}

- (void)addButtons:(NSArray *)titles{
    
    // 偶数个
    if (titles.count % 2 == 0) {
        NSInteger index_down = titles.count/2;
        NSInteger index_up = -1;
        for (NSInteger i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            MSSlideMenuButton *home_button = [MSSlideMenuButton defaultButton];
            home_button.tag = i;
            [home_button setTitle:title forState:(UIControlStateNormal)];
            // 下半部按钮
            if (i >= titles.count / 2) {
                index_up ++;
                home_button.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 + menuButtonHeight*index_up + buttonSpace*index_up + buttonSpace/2 + menuButtonHeight/2);
            } else {
            // 上半部按钮
                index_down --;
                home_button.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 - menuButtonHeight*index_down - buttonSpace*index_down - buttonSpace/2 - menuButtonHeight/2);
            }
            home_button.bounds = CGRectMake(0, 0, keyWindow.frame.size.width/2 - 20*2, menuButtonHeight);
            [self addSubview:home_button];
            [home_button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        }
    } else {
        NSInteger index = (titles.count - 1) /2 +1;
        for (NSInteger i = 0; i < titles.count; i++) {
            index --;
            NSString *title = titles[i];
            MSSlideMenuButton *home_button = [MSSlideMenuButton defaultButton];
            home_button.tag = i;
            [home_button setTitle:title forState:(UIControlStateNormal)];
            home_button.center = CGPointMake(keyWindow.frame.size.width/4, keyWindow.frame.size.height/2 - menuButtonHeight*index - 20*index);
            home_button.bounds = CGRectMake(0, 0, keyWindow.frame.size.width/2 - 20*2, menuButtonHeight);
            [self addSubview:home_button];
            [home_button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
}

- (void)buttonClick:(UIButton*)sender {
    self.menuClickBlock(sender.tag);
}

- (void)trigger{
    if (!triggered) {
        [self show];
    }
    else {
        [self hide];
    }
}

- (void)show {
    // 添加模糊视图
    [bgView insertSubview:blurView belowSubview:self];
    
    [keyWindow addSubview:bgView];
    
    [UIView animateWithDuration:0.3 animations:^{
        //            self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.frame = self.bounds;
    }];
    
    // 顶部辅助视图动画
    [self beforeAnimation]; //开启定时器
    [UIView animateWithDuration:0.7f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
        helperTopView.center = CGPointMake(keyWindow.center.x, helperTopView.center.y);
    } completion:^(BOOL finished) {
        [self finishAnimation];//动画完成停止计时器
    }];
    
    // 显示背景模糊视图
    [UIView animateWithDuration:0.3 animations:^{
        blurView.alpha = 1.0f;
    }];
    
    // 中间辅助视图动画
    [self beforeAnimation];
    [UIView animateWithDuration:0.7f delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        helperCenterView.center = keyWindow.center;
    } completion:^(BOOL finished) {
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [blurView addGestureRecognizer:tap];
        [self finishAnimation];
    }];
    
    // 显示按钮动画
    [self animateButtons];
    
    triggered = YES;
}

- (void)animateButtons {
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:[MSSlideMenuButton class]]) {
            view.transform = CGAffineTransformMakeTranslation(-90, 0);
            [UIView animateWithDuration:0.7 delay:i*(0.3/self.subviews.count) usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
                view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(-keyWindow.frame.size.width/2-menuBlankWidth, 0, keyWindow.frame.size.width/2+menuBlankWidth, keyWindow.frame.size.height);
    }];
    
//    // 顶部辅助视图动画
    [self beforeAnimation]; //开启定时器
    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.9f options:(UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction) animations:^{
        helperTopView.center = CGPointMake(-helperCenterView.frame.size.width/2, helperTopView.center.y);
    } completion:^(BOOL finished) {
        [self finishAnimation];//动画完成停止计时器
    }];
    
    // 隐藏背景模糊视图
    [UIView animateWithDuration:0.3 animations:^{
        blurView.alpha = 0.0f;
    }];
    
    // 中间辅助视图动画
    [self beforeAnimation];
    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        helperCenterView.center = CGPointMake(-helperCenterView.frame.size.width/2, helperCenterView.center.y);
    } completion:^(BOOL finished) {
        [self finishAnimation];
    }];
    
    triggered = NO;
}

- (void)beforeAnimation {
    if (self.displayLink == nil) {
        // 每隔一帧重绘一次
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayCurrentView)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.animationCount ++;
}

- (void)finishAnimation {
    self.animationCount --;
    // 辅助视图动画完成后，停止重绘
    if (self.animationCount == 0) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        if (triggered == NO) {
            [bgView removeFromSuperview];
        }
    }
}

- (void)displayCurrentView{
    // 获取辅助视图当前layer 的副本
    CALayer *helperTopViewPresentLayer = [helperTopView.layer presentationLayer];
    CALayer *helperCenterViewPresentLayer = [helperCenterView.layer presentationLayer];
    
    CGRect centerRect = helperCenterViewPresentLayer.frame;
    CGRect topRect = helperTopViewPresentLayer.frame;
    
    diff = topRect.origin.x - centerRect.origin.x;
    
    [self setNeedsDisplay];

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - menuBlankWidth, 0)];
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width - menuBlankWidth, self.frame.size.height) controlPoint:CGPointMake(keyWindow.frame.size.width/2 + diff, keyWindow.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [_menuColor set];
    CGContextFillPath(context);
    
}

@end
