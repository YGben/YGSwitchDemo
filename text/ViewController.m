//
//  ViewController.m
//  text
//
//  Created by BEN on 16/4/12.
//  Copyright © 2016年 Ben. All rights reserved.
//

#import "ViewController.h"
#import "YGUpgrateSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YGUpgrateSwitch *switchView = [[YGUpgrateSwitch alloc] init];
    switchView.frame = CGRectMake(0, 0,  SCREEN_WIDTH, SCREEN_HEIGHT);
    switchView.titleArray = @[@"动态",@"消息"];
    [self.view addSubview:switchView];
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    switchView.childVCArray = @[vc1,vc2];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
