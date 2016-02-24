//
//  MSBubbleView.m
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/19.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBadgeView.h"

@interface MSBadgeView ()

// 气泡上显示数字的label
@property (nonatomic, strong)UILabel *bubbleLabel;
@property (nonatomic, strong)UIView *backView;

@property (nonatomic, assign)CGFloat diameter; //内容为一个数字时圆的直径

@end

@implementation MSBadgeView

- (instancetype)initWithBubbleColor:(UIColor*)bubbleColor titleColor:(UIColor*)titleColor fontSize:(CGFloat)fontSize {
    if (self = [super init]) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _backView.backgroundColor = bubbleColor;
        [self addSubview:_backView];
        
        _bubbleLabel = [[UILabel alloc]initWithFrame:_backView.bounds];
        [_bubbleLabel setTextAlignment:(NSTextAlignmentCenter)];
        [_bubbleLabel setTextColor:titleColor];
        _bubbleLabel.font = [UIFont systemFontOfSize:fontSize]; // 字体
        
        // 获取一个字时label高度
        _bubbleLabel.text = @"9";
        [_bubbleLabel sizeToFit];
        [_backView addSubview:_bubbleLabel];
        _diameter = _bubbleLabel.frame.size.height;
        _backView.layer.cornerRadius = _diameter/2;

    }
    return self;
}

- (instancetype)initWithCustom{
    return [self initWithBubbleColor:[UIColor redColor] titleColor:[UIColor whiteColor] fontSize:14.0];
}

- (void)setBadge:(NSString *)badge {
    _badge = [badge copy];
    _bubbleLabel.text = [badge integerValue] > 99 ? @"99+" : badge;
    [_bubbleLabel sizeToFit];
    
    if ([badge integerValue] > 0) {
        self.hidden = NO;
    }
    
    CGFloat width = _diameter;
    if ([badge integerValue] > 9) {
        width = 1.5 * _diameter;
    }
    if ([badge integerValue] > 99) {
        width = 2.0 * _diameter;
    }
    
    _backView.frame = CGRectMake(0, 0, width,_diameter);
    _bubbleLabel.center = _backView.center;
    
    //内容自适应
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, _diameter);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
