//
//  LGBVerticalButton.m
//  白丝不得姐
//
//  Created by Bing on 16/4/17.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBVerticalButton.h"

@implementation LGBVerticalButton


//通过重写init...frame 方法 以后不管是xib还是手动创建代码,都可以设置按钮图片,文字的位置
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self setup];
    }
    return self;
}

-(void)setup
{
    //文字居中对齐
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}
- (void)awakeFromNib {
    
    [self setup];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;

}

@end
