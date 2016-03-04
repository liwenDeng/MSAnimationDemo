//
//  MSBubbleAnimationView.h
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/24.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSBadgeView.h"

#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kTopView [[UIApplication sharedApplication].windows lastObject]

@interface MSBubbleAnimationView : UIView

/**
 *  分离比率，拖动时圆球半径/初始圆球半径 默认为0.2
 */
@property (nonatomic, assign)CGFloat seperateScale;

- (void)animateWithBadgeView:(MSBadgeView*)badgeView gestureRecognizer:(UIPanGestureRecognizer*)sender superView:(UIView*)superView;

@end
