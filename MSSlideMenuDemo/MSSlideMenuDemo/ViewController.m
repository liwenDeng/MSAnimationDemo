//
//  ViewController.m
//  MSSlideMenuDemo
//
//  Created by dengliwen on 16/2/17.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "ViewController.h"
#import "MSSildeMenu.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) MSSildeMenu* menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"首页";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setTitle:@"Tap" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(300, 600, 40, 20);
    
    [self.view addSubview:button];

    self.menu = [[MSSildeMenu alloc]initWithTitles:@[@"首页",@"消息",@"个人中心",@"设置",@"其他"]];
//    self.menu = [[MSSiledMenu alloc]initWithTitles:@[@"首页",@"消息",@"个人中心",@"设置",@"其他"] ButtonHeight:40 MenuColor:[UIColor blueColor] BackBlurStyle:(UIBlurEffectStyleDark)];
    self.menu.menuClickBlock = ^(NSInteger index){
        NSLog(@"index:%ld",index);
    };
    
    
}

- (void)buttonTap:(UIButton*)sender {
    [self.menu trigger];
}

- (void)pan:(UIPanGestureRecognizer*)sender {
    CGPoint direction = [sender velocityInView:self.view];
    NSLog(@"...");
    if (direction.x > 0 && sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"右滑");
        [self.menu trigger];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"No.%ld",(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"sssss");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
