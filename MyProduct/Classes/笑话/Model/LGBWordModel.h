//
//  LGBWordModel.h
//  MyProduct
//
//  Created by Bing on 16/5/12.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LGBWordModel : NSObject

@property (nonatomic,strong)NSDictionary * user;

//内容
@property (nonatomic,copy)NSString * content;

//评论数
@property (nonatomic,assign)NSInteger comments_count;

//分享数
@property (nonatomic,assign)NSInteger share_count;

//评论类型
@property (nonatomic,copy)NSString * type;


//用户的 传值id
@property (nonatomic,copy)NSString * ID;

//设置cell的高度
@property (nonatomic,assign,readonly)CGFloat cellHeight;


@end
