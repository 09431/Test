//
//  LGBPublishView.m
//  MyProduct
//
//  Created by Bing on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//
#import "LGBTabBar.h"
#import "LGBPublishView.h"


//类扩展
@interface LGBTabBar()
//发布按钮
@property (nonatomic,weak)UIButton * publishButton;

@end


@implementation LGBTabBar


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //设置tabBar 背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //设置发布按钮的frame
        UIButton * publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_iconN"] forState:UIControlStateHighlighted];
        
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:publishButton];
        
        self.publishButton = publishButton;
        
    }
    return self;
}

-(void)publishClick
{
    
    LGBPublishView * publish = [LGBPublishView publishView];
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    publish.frame = window.bounds;
    
    [window addSubview:publish];
    
    window = [[UIWindow alloc]init];
    window.frame = [UIScreen mainScreen].bounds;
    
    window.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    window.hidden = NO;
    

}
-(void)layoutSubviews
{

    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
//    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    
    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
    
    self.publishButton.center = CGPointMake(width * 0.5, self.height * 0.5);

    //设置其他按钮的UITabBarButton 的 frame
    
    CGFloat buttonY = 0 ;
    CGFloat buttonW = width/5;
    CGFloat buttonH = height;
    
    NSUInteger index =0;
    for (UIView * button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])
            continue;
        
        CGFloat buttonX = buttonW * ((index >1) ? (index+1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }

    
}
@end
