//
//  LGBComment.m
//  MyProduct
//
//  Created by Bing on 16/5/13.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LGBComment.h"
#import "NSDate+LGBExtension.h"

@implementation LGBComment

{
    CGFloat _cellheight;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

-(CGFloat)cellHeight
{
    if (!_cellheight) {
        CGSize maxSize = CGSizeMake(LGBScreenW - 73 -44 - 2*LGBTopicCellMargin, MAXFLOAT);
        
        CGFloat textH = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        //到cell 的高度
        _cellheight = 36 + textH ;
        
        //到底部的高度
        _cellheight += 29+3.5 + LGBTopicCellMargin;
    }
    return _cellheight;
}

-(NSString *)created_at
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[_created_at intValue]];
  
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    //设置日期格式(y年M月d日 H时m分s秒)
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //帖子创建的时间
    NSDate * create = date;
    if (create.isThisYear) { //今年
        if (create.isToday) { //今天
            NSDateComponents * comps = [[NSDate date]deltaFrom:create];
            
            if (comps.hour >=1) { //时间差距大于一小时
                return  [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }
            else if(comps.minute >=1){  // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前",comps.minute];
            }
            else{ //时间差距小于 1分钟
                return  @"刚刚";
            }
        }else if(create.isYestday){ //昨天
            dateFormatter.dateFormat = @"昨天 HH:mm:ss";
            return  [dateFormatter stringFromDate:create];
            
        }
        else{ //其他
            dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
            return [dateFormatter stringFromDate:create];
        }
    }
    else{ //非今年
        return [NSString stringWithFormat:@"%@",date];
    }
    
}

@end
