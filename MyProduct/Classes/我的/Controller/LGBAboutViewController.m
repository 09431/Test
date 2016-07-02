//
//  LGBAboutViewController.m
//  MyProduct
//
//  Created by Bing on 16/5/12.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBAboutViewController.h"
//二维码的生成和滤镜的实现都是使用CoreImage框架
#import <CoreImage/CoreImage.h>

#import "UIImage+LGBExtension.h"

@interface LGBAboutViewController ()

{
    UIImageView * _imageView;
}

@end

@implementation LGBAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
}
-(void)setupNav
{
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar-light"]];
    
    imageView.userInteractionEnabled = YES;
    
    imageView.frame = CGRectMake(0, 0, LGBScreenW, 64);
    
    [self.view addSubview:imageView];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 25, 46, 30);
    
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor redColor];
    
    backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [backButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:backButton];
   
    
    //设置标题
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(LGBScreenW/2-60, 30, 120, 30)];
    label.text = @"关于我们";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:22];
    label.textColor = [UIColor redColor];
    
    [imageView addSubview:label];
    
    //创建ImageView
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LGBScreenW, LGBScreenH)];
    _imageView.center = self.view.center;
    
    [self.view addSubview:_imageView];
    
    //创建一个滤镜处理器
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置二维码包含的信息
    NSString * str = @"爱你一辈子";
    
    //需要将字符串转化为NSData
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    //将转化之后的data赋给滤镜处理器
    [filter setValue:data forKey:@"inputMessage"];
    
    //输出图片
    CIImage * ciImage = [filter outputImage];
    
    //将CIImage 转化为Image
    UIImage * image = [UIImage imageWithCIImage:ciImage];
    
    _imageView.image = image;
    

}


-(void)backButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
