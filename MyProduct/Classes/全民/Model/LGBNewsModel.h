//
//  LGBNewsModel.h
//  MyProduct
//
//  Created by Bing on 16/5/6.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGBNewsModel : NSObject

//标题
@property (nonatomic,copy)NSString * title;
//图片
@property (nonatomic,copy)NSString * pic;
//时长
@property (nonatomic,copy)NSString * duration;
//视频
@property (nonatomic,copy)NSString * videoUrl;


//
//vid: "14296128",
//title: "大学都是这样叫室友起床的？",
//pic: "http://img.mms.v1.cn/static/mms/images//201605050918117005.png",
//cid: "6",
//videoUrl: "http://f02.v1.cn/transcode/14296128MOBILET2.mp4",
//at: "1",
//shareUrl: "http://m.v1.cn/video/v_14296128.jhtml",
//duration: "295",
//headpic: "",
//name: "娱乐扒一扒",
//playNum: "0",
//shareNum: "0",
//likeNum: "0"

@end
