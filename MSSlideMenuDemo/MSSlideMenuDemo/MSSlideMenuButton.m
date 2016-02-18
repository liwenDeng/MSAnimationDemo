//
//  MSSlideMenuButton.m
//  MSSlideMenuDemo
//
//  Created by dengliwen on 16/2/17.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSSlideMenuButton.h"

@implementation MSSlideMenuButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)defaultButton{
    MSSlideMenuButton *button = [[MSSlideMenuButton alloc]init];
    
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 2;
    
    button.layer.cornerRadius = 10;
    
    return button;
}

@end
