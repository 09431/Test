//
//  MyGuide.h
//  Love  Limit  Free
//
//  Created by Bing on 16/3/30.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGuide : UIView


-(instancetype)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray goBack:(void(^)())hander;

@end
