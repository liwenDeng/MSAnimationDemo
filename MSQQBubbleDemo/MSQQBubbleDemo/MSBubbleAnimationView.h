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

- (void)animateWithBadgeView:(MSBadgeView*)badgeView gestureRecognizer:(UIPanGestureRecognizer*)sender superView:(UIView*)superView;

@end
