//
//  ViewController.m
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/19.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "ViewController.h"
#import "MSBubbleView.h"
#import "UIView+ms_ScreenShot.h"
@interface ViewController ()

@property (nonatomic, strong)MSBubbleView* bubble1 ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MSBubbleView *bView = [[MSBubbleView alloc]initWithFrame:CGRectMake(0, 20, 60, 30)];
    bView.badge = @"0";
    [self.view addSubview:bView];
    
    MSBubbleView *bView1 = [[MSBubbleView alloc]initWithFrame:CGRectMake(50, 90, 60, 30)];
    bView1.badge = @"3";
    [self.view addSubview:bView1];
    self.bubble1 = bView1;
    
    MSBubbleView *bView2 = [[MSBubbleView alloc]initWithFrame:CGRectMake(50, 130, 60, 30)];
    bView2.badge = @"12";
    [self.view addSubview:bView2];
    
    MSBubbleView *bView3 = [[MSBubbleView alloc]initWithFrame:CGRectMake(50, 170, 60, 30)];
    bView3.badge = @"55";
    [self.view addSubview:bView3];
    
    MSBubbleView *bView4 = [[MSBubbleView alloc]initWithFrame:CGRectMake(50, 220, 60, 30)];
    bView4.badge = @"162";
    [self.view addSubview:bView4];
    bView4.badge = @"2";


    bView.center = CGPointMake(120, 60);
    bView1.center = CGPointMake(120, 100);
    bView2.center = CGPointMake(120, 140);
    bView3.center = CGPointMake(120, 180);
    bView4.center = CGPointMake(120, 220);
    
//    bView.backgroundColor = [UIColor grayColor];
//    bView1.backgroundColor = [UIColor grayColor];
//    bView2.backgroundColor = [UIColor grayColor];
//    bView3.backgroundColor = [UIColor grayColor];
//    bView4.backgroundColor = [UIColor grayColor];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(100, 300, 30, 30);
    [self.view addSubview:btn];
    [btn setTitle:@"add Budge" forState:(UIControlStateNormal)];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click{
    NSInteger num = [self.bubble1.badge integerValue];
    num++;
    self.bubble1.badge = [NSString stringWithFormat:@"%d",num];
}

@end
