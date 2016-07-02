//
//  LGBNavigationController.m
//  MyProduct
//
//  Created by Bing on 16/5/11.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBNavigationController.h"

@interface LGBNavigationController ()

@end

@implementation LGBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //获得当前的
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"] forBarMetrics:UIBarMetricsDefault];
    
    [self createBackButton];

}
-(void)createBackButton
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, 100, 100);
    
    [button setTitle:@"返回" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
}
-(void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
