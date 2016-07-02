//
//  LGBLiveModel.h
//  MyProduct
//
//  Created by Bing on 16/5/3.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGBLiveModel : NSObject
//标题
@property (nonatomic,copy)NSString * title;
//大图
@property (nonatomic,copy)NSString * picUrl;
//小图
@property (nonatomic,copy)NSString * face_url;
//播放地址
@property (nonatomic,copy)NSString * roomid;
//城市名称
@property (nonatomic,copy)NSString * city_name;
//粉丝
@property (nonatomic,copy)NSString * fancount;


@end
