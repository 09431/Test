//
//  LGBBaseViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/9.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBBaseViewController.h"

@interface LGBBaseViewController ()

@end

@implementation LGBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //设置内边距
    
//    self.tableView.backgroundColor = LGBGlobalBg;
//    
//    CGFloat top = LGBTitlesViewH + LGBTitlesViewY;
//    
//    CGFloat bottom = self.tabBarController.tabBar.height;
//    
//    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
//    
//    self.tableView.rowHeight = 100;
//    
//    //设置滚动条的内边距
//    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
//
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addHud
{
    if (!_hud) {
        _hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.labelText = @"加载中...";
    }
}

- (void)removeHud
{
    if (_hud) {
        [_hud removeFromSuperview];
        _hud=nil;
    }
}



@end
