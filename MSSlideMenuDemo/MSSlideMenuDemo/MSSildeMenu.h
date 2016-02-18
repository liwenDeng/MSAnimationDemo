//
//  MSSiledMenu.h
//  MSSlideMenuDemo
//
//  Created by dengliwen on 16/2/17.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuButtonClickedBlock)(NSInteger index);

@interface MSSildeMenu : UIView

@property (nonatomic, copy)MenuButtonClickedBlock menuClickBlock;

/**
 *  便利构造器
 */
-(id)initWithTitles:(NSArray *)titles;

/**
 *  创建自定义侧滑菜单
 *
 *  @param titles    按钮标题数组
 *  @param height    按钮高度
 *  @param menuColor 菜单颜色
 *  @param style     背景模糊效果
 */
- (instancetype)initWithTitles:(NSArray *)titles ButtonHeight:(CGFloat)height MenuColor:(UIColor *)menuColor BackBlurStyle:(UIBlurEffectStyle)style;

/**
 *  触发事件
 */
- (void)trigger;

@end
