//
//  LGBRootViewController.m
//  MyProduct
//
//  Created by Bing on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBRootViewController.h"

@interface LGBRootViewController ()

@end

@implementation LGBRootViewController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
      self.view.backgroundColor = LGBGlobalBg;
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
