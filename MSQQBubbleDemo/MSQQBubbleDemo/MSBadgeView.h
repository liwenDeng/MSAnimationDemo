//
//  MSBubbleView.h
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/19.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  基本的badgeView
 */
@interface MSBadgeView : UIView

@property (nonatomic, copy)NSString* badge;
@property (nonatomic, strong)UIColor *bubbleColor;

- (instancetype)initWithBubbleColor:(UIColor*)bubbleColor titleColor:(UIColor*)titleColor fontSize:(CGFloat)fontSize;

- (instancetype)initWithCustom;

@end
