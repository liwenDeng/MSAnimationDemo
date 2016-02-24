//
//  UIView+ms_ScreenShot.h
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/22.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ms_ScreenShot)

+ (UIImage *)ms_imageWithView:(UIView *)selectView;

- (UIImage *)ms_convertViewToImage;

- (UIImage *)screenshotWithRect:(CGRect)rect;

- (UIImage *)screenshot;



@end
