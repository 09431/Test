//
//  NSDate+LGBExtension.h
//  白丝不得姐
//
//  Created by Bing on 16/4/22.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LGBExtension)
//比较from 和 self之间的差值
-(NSDateComponents *)deltaFrom:(NSDate *)from;

//是否是今年
-(BOOL)isThisYear;
//是否是当月
-(BOOL)isYestday;
//是否是今天
-(BOOL)isToday;

@end
