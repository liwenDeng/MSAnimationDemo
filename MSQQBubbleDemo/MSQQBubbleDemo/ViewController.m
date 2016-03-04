//
//  ViewController.m
//  MSQQBubbleDemo
//
//  Created by dengliwen on 16/2/19.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "ViewController.h"
#import "MSBubbleView.h"
#import "MSBadgeView.h"
#import "UIView+RoundedCorner.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, strong)MSBubbleView* bubble1 ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
//    MSBubbleView *bView = [[MSBubbleView alloc]initWithFrame:CGRectMake(200, 100, 60, 30) bubbleColor:[UIColor redColor] titleColor:[UIColor whiteColor] fontSize:18.0 alignMode:(MSBadgeViewAlignCenter)];
//    [self.view addSubview:bView];
//    bView.seperateScale = 0.3;
//    bView.badge = @"5";
//    
//    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(200, 200, 60, 30)];
//    backView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:backView];
//    
//    MSBadgeView *badgeView = [[MSBadgeView alloc]initWithCustom];
//    badgeView.badge = @"6";
//    [backView addSubview:badgeView];
//    badgeView.center = CGPointMake(30, 15);
    

//    UIView *backView2 = [[UIView alloc]initWithFrame:CGRectMake(200, 300, 60, 30)];
//    UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
//    l1.text = @"5";
//    [backView2 addSubview:l1];
//    [self.view addSubview:backView2];
//    [backView2 setJMRadius:JMRadiusMake(30/2.0, 30/2.0, 30/2.0, 30/2.0) withBackgroundColor:[UIColor redColor]];
//    

    
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 99;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Cell"];
        MSBubbleView *bView = [[MSBubbleView alloc]initWithFrame:CGRectMake(200, 11, 60, 30) bubbleColor:[UIColor redColor] titleColor:[UIColor whiteColor] fontSize:18.0 alignMode:(MSBadgeViewAlignRight)];
        [cell addSubview:bView];
        bView.seperateScale = 0.3;
        bView.badge = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    return cell;
}

@end
