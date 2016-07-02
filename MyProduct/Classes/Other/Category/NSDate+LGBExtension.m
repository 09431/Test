//
//  NSDate+LGBExtension.m
//  白丝不得姐
//
//  Created by Bing on 16/4/22.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "NSDate+LGBExtension.h"

@implementation NSDate (LGBExtension)


//比较from 和 self之间的差值
-(NSDateComponents *)deltaFrom:(NSDate *)from
{
    //日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    //比较时间
    NSCalendarUnit uint = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    
    return [calendar components:uint fromDate:from toDate:self options:0];
    
}
//是否是今年
-(BOOL)isThisYear
{
   
    //获得今天的日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;

}
//是否是当月
-(BOOL)isYestday;
{
    //日期格式化
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate * nowDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
    
    NSDate * selfDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:self]];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * comps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return comps.year == 0
    &&comps.month == 0
    &&comps.day == 1;


}
////是否是今天
//-(BOOL)isToday;
//{
//    NSCalendar * calendar = [NSCalendar currentCalendar];
//    
//    NSCalendarUnit  unit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay;
//    
//    NSDateComponents * nowComps = [calendar components:unit fromDate:[NSDate date]];
//    NSDateComponents * selfComps = [calendar components:unit fromDate:self];
//    
//    return nowComps.year == selfComps.year
//    && nowComps.month == selfComps.month
//    && nowComps.day == selfComps.day;
//    
//}
-(BOOL)isToday
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * nowString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString * selfString = [dateFormatter stringFromDate:self];
    
    return [nowString isEqualToString:selfString];

}

@end
