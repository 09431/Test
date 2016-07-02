//
//  LGBGuideViewController.m
//  MyProduct
//
//  Created by Bing on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBGuideViewController.h"
#import "LGBTabBarViewController.h"
#import "MyGuide.h"
#import "AppDelegate.h"

#define LGBEnterCount @"EnterCountKey"

@interface LGBGuideViewController ()

@end

@implementation LGBGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self isFirstEnter]) {
        [self goGuide];
    }
    else{
        [self goMainView];
    }
    
}

#pragma mark - 判断是否是第一次启动
-(BOOL)isFirstEnter
{
    NSInteger enterCount = [[NSUserDefaults standardUserDefaults] integerForKey:LGBEnterCount];
    
    //保存
    enterCount++;
    
    [[NSUserDefaults standardUserDefaults]setInteger:enterCount forKey:LGBEnterCount];
    //同步数据
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (enterCount == 1) {
        return YES;
    }
    else{
        return NO;
    }
}
#pragma mark - 导航页
-(void)goGuide
{
    NSArray * imageArray = @[@"",@"",@"",@"",@""];
    
    __weak LGBGuideViewController * weakSelf = self;
    
    MyGuide * guideView = [[MyGuide alloc]initWithFrame:self.view.bounds withImageArray:imageArray goBack:^{
        //当我滑到最后一页的时候,切换到主界面
        [weakSelf goMainView];
        
    }];
    
    [self.view addSubview:guideView];
}
-(void)goMainView
{
    LGBTabBarViewController * tabBarVC = [[LGBTabBarViewController alloc]init];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor redColor]} forState:UIControlStateNormal];
    
   AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    app.window.rootViewController = tabBarVC;
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
