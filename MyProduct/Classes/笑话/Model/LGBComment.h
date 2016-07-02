//
//  LGBComment.h
//  MyProduct
//
//  Created by Bing on 16/5/13.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGBComment : NSObject
//评论内容
@property (nonatomic,copy)NSString * content;
//名字
@property (nonatomic,strong)NSDictionary * user;

//创建时间
@property (nonatomic,copy)NSString * created_at;

//cell的高
@property (nonatomic,assign,readonly)CGFloat cellHeight;


@end
