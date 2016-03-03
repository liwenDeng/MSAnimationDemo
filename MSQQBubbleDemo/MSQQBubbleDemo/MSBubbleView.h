//
//  MSBubbleView.h
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/22.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    MSBadgeViewAlignLeft = 0,
    MSBadgeViewAlignCenter = 1,
    MSBadgeViewAlignRight = 2,
} MSBadgeViewAlignMode;

@interface MSBubbleView : UIView

@property (nonatomic, copy)NSString* badge;

/**
 *  便利构造器
 */
- (instancetype)initWithCustomStyleFrame:(CGRect)frame;

/**
 *  @param frame
 *  @param bubbleColor 气泡颜色
 *  @param titileColor 字体颜色
 *  @param fontSize    字体大小 会影响气泡的size大小
 *  @param alignMode   对齐方式
 */
- (instancetype)initWithFrame:(CGRect)frame bubbleColor:(UIColor*)bubbleColor titleColor:(UIColor*)titileColor fontSize:(CGFloat)fontSize alignMode:(MSBadgeViewAlignMode)alignMode;

@end
