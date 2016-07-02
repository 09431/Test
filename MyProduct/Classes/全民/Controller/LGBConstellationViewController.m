//
//  LGBConstellationViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/14.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBConstellationViewController.h"

@interface LGBConstellationViewController ()

@end

@implementation LGBConstellationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.path = ConstellationURL;
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
