//
//  LGBTabBarViewController.m
//  MyProduct
//
//  Created by Bing on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBTabBarViewController.h"
#import "LGBJokeViewController.h"
#import "LGBMeViewController.h"
#import "LGBLiveViewController.h"
#import "LGBHomeViewController.h"
#import "LGBTabBar.h"




@interface LGBTabBarViewController ()

@end

@implementation LGBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LGBLiveViewController * liveVC = [[LGBLiveViewController alloc]init];
    LGBMeViewController * meVC = [[LGBMeViewController alloc]init];
    LGBHomeViewController * homeVC = [[LGBHomeViewController alloc]init];
    LGBJokeViewController * jokeVC = [[LGBJokeViewController alloc]init];
    
    NSArray * arrayVC = @[homeVC,jokeVC,liveVC,meVC];
    
    NSArray * titleArray = @[@"首页",@"搞笑",@"直播",@"我的"];
    
    NSArray * imageArray = @[@"推荐-默认~iphone",@"栏目-默认~iphone",@"发现-默认~iphone",@"我的-默认~iphone"];
    NSArray * selectedArray = @[@"推荐-焦点~iphone",@"栏目-焦点~iphone",@"发现-焦点~iphone",@"我的-焦点~iphone"];
   
    NSMutableArray * array = [[NSMutableArray alloc]init];
    
    for (int i=0; i< arrayVC.count; i++) {
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:arrayVC[i]];
        
        nav.tabBarItem.title = titleArray[i];
        
        nav.tabBarItem.image = [[UIImage imageNamed:imageArray[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedArray[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [array addObject:nav];
        
    }
    
    //使用kVC 更换tabBar
    [self setValue:[[LGBTabBar alloc]init] forKey:@"tabBar"];
    
    self.viewControllers = array;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
