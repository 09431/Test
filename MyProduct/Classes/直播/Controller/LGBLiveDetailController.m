//
//  LGBLiveDetailController.m
//  MyProduct
//
//  Created by Bing on 16/5/4.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBLiveDetailController.h"

@interface LGBLiveDetailController ()

@property (nonatomic,strong)UIWebView * webView;

@end

@implementation LGBLiveDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createUI];
    
}
-(void)createUI
{
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.webView];
    
    //自适应屏幕大小
    self.webView.scalesPageToFit = YES;
    
    
    NSString * path = [NSString stringWithFormat:@"http://v.laifeng.com/%@",self.roomid];
    
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:request];
    
    
   
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
