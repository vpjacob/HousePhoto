//
//  NSDate+BTAddition.m
//  BEConnector
//
//  Created by andy on 3/18/15.
//  Copyright (c) 2015 NationSky. All rights reserved.
//

#import "NSDate+BTAddition.h"

@implementation NSDate (BTAddition)

- (NSString*)transformToFuzzyDate
{
    NSDate *nowDate = [NSDate date];
    NSUInteger timeInterval = [nowDate timeIntervalSinceDate:self];
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //  通过已定义的日历对象，获取某个时间点的NSDateComponents表示，并设置需要表示哪些信息（NSYearCalendarUnit, NSMonthCalendarUnit, NSDayCalendarUnit等）
    NSDateComponents *nowDateComponents = [greCalendar components:NSCalendarUnitEra | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | kCFCalendarUnitWeek | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:nowDate];
    
    NSDateComponents *selfDateComponents = [greCalendar components:NSCalendarUnitEra | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | kCFCalendarUnitWeek | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:self];
    
    if (timeInterval < (5 * 60)) {
        return @"刚刚";
    }
    else if (timeInterval < (60 * 60)) {
        return [NSString stringWithFormat:@"%@分钟前",@(timeInterval / 60)];
    }
    else if (timeInterval < (24 * 60 * 60) && nowDateComponents.day == selfDateComponents.day) {
        return [NSString stringWithFormat:@"%@小时前",@(timeInterval / (60 * 60))];
    }
    else if (nowDateComponents.day == (selfDateComponents.day + 1) ||
             (timeInterval < (24 * 60 * 60) && nowDateComponents.day != selfDateComponents.day)){
        return @"昨天";
    }
    else if (nowDateComponents.weekOfMonth == selfDateComponents.weekOfMonth) {
        NSArray *weekdays = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
        return weekdays[selfDateComponents.weekday - 1];
    }
    else if ([self timeIntervalSince1970] == 0) {
        return @"";
    }
    else {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        NSString *dateString = [dateFormatter stringFromDate:self];
        return dateString;
    }
}

- (NSString*)promptDateString
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *nowDateComponents = [greCalendar components:NSCalendarUnitEra | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | kCFCalendarUnitWeek | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:nowDate];
    
    NSDateComponents *selfDateComponents = [greCalendar components:NSCalendarUnitEra | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | kCFCalendarUnitWeek | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear fromDate:self];
    
    NSDateComponents *weeDateComponents = [[NSDateComponents alloc] init];
    [weeDateComponents setCalendar:[NSCalendar currentCalendar]];
    weeDateComponents.year = selfDateComponents.year;
    weeDateComponents.month = selfDateComponents.month;
    weeDateComponents.day = selfDateComponents.day;
    weeDateComponents.hour = 0;
    weeDateComponents.minute = 0;
    weeDateComponents.second = 0;
    
//    NSString* twoComponent = nil;
//    NSInteger hour = nowDateComponents.hour;
//    
//    if (hour < 12) {
//        twoComponent = @"am";
//    }
//    else {
//        twoComponent = @"pm";
//        hour = hour - 12;
//    }
    
    NSDate *weeDate = [[weeDateComponents date] dateByAddingTimeInterval:24 * 60 * 60];
    //判断显示小时
    NSString *newHour = [NSString stringWithFormat:@"%@",@(selfDateComponents.hour)];
    if (selfDateComponents.hour < 10) {
        newHour = [NSString stringWithFormat:@"0%@",@(selfDateComponents.hour)];
    }
    
    //判断显示分钟
    NSString *minute = [NSString stringWithFormat:@"%@",@(selfDateComponents.minute)];
    if (selfDateComponents.minute < 10) {
        minute = [NSString stringWithFormat:@"0%@",@(selfDateComponents.minute)];
    }
    
    NSString *lastComponents = [NSString stringWithFormat:@"%@:%@",newHour,minute];
    
    NSString* dateString = nil;
    int timeInterval = [nowDate timeIntervalSinceDate:weeDate];
    
    if (abs(timeInterval) < (24 * 60 * 60)) {
        dateString = [NSString stringWithFormat:@"%@ %@",@"yesterday",lastComponents];
        if (nowDateComponents.day == selfDateComponents.day) {
            dateString = lastComponents;
        }
    }
    else if (nowDateComponents.weekOfMonth == selfDateComponents.weekOfMonth) {
        NSArray *weekdays = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
        NSString *weekdayString = weekdays[selfDateComponents.weekday - 1];
        dateString = [NSString stringWithFormat:@"%@%@",weekdayString,lastComponents];
    }
    else { //判断是否是同一年
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateString = [NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:self],lastComponents];
    }
    return dateString;
}

+ (NSDate *)transformTimeStamp:(long long)timeStamp
{
    return [NSDate dateWithTimeIntervalSince1970:timeStamp];
}

/**
 *  比较时间（self），获取间隔
 */
- (NSInteger)compareDate:(NSDate *)date
{
    return fabs([self timeIntervalSinceDate:date]);
}

/**
 *  比较时间（当前时间），获取间隔
 */
+ (NSInteger)compareCurrentDate:(NSDate *)date
{
    return [[NSDate date] compareDate:date];
}

/**
 *  获取 当前时间 与 dateStr 的时间差
 *
 *  @param dateStr 比较时间 格式（"yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd HH:mm"）
 *  @param 时间间隔
 */
+ (NSInteger)compareCurrentDateInterval:(NSString *)dateStr
{
    NSDate *date = [self transformDateStr:dateStr];
    NSInteger timeInterval = [date timeIntervalSinceDate:[NSDate date]];
    return timeInterval < 0 ? 0 : timeInterval;
}

/**
 *  dataStr -> NSDate
 *
 *  @param dateStr  格式（"yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd HH:mm"）
 */
+ (NSDate *)transformDateStr:(NSString *)dateStr
{
    NSString *formate = @"yyyy-MM-dd HH:mm:ss";
    if (dateStr.length != formate.length) {
        formate = @"yyyy-MM-dd HH:mm";
    }
    return [self transformDateStr:dateStr dateFormat:formate];
}

/**
 *  dataStr -> NSDate
 *
 *  @param dateStr
 *  @param dateFormate  exp ("yyyy-MM-dd HH:mm:ss"）
 */
+ (NSDate *)transformDateStr:(NSString *)dateStr
                  dateFormat:(NSString *)dateFormate
{
    NSDateFormatter *forma = [[NSDateFormatter alloc] init];
    [forma setDateFormat:dateFormate];
    NSDate *date = [forma dateFromString:dateStr];
    return date;
}

/**
 *  NSDate -> dataStr
 *
 *  @param NSDate
 *  @param dateFormate  exp ("yyyy-MM-dd HH:mm:ss"）
 */

+ (NSString *)transformDate:(NSDate *)date
                 dateFormat:(NSString *)dateFormate {
    NSDateFormatter *forma = [[NSDateFormatter alloc] init];
    [forma setDateFormat:dateFormate];
    NSString *dateString = [forma stringFromDate:date];
    return dateString;
}

/**
 *  判断时间是否在当前日期的后n天之内
 *
 *  @param dateStr 格式（"yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd HH:mm"
 *  @param days 天
 */
+ (BOOL)judgeDateStr:(NSString *)dateStr withInDays:(NSInteger)days
{
    NSDate *date = [self transformDateStr:dateStr];
    NSInteger timeInterval = [date timeIntervalSinceDate:[NSDate date]];
    if (timeInterval < 0 || timeInterval > (days * 24 * 3600)) {
        return NO;
    }
    return YES;
}

- (BOOL)judgeDateStr:(NSString *)dateStr withInDays:(NSInteger)days
{
    NSDate *date = [NSDate transformDateStr:dateStr];
    NSInteger timeInterval = [date timeIntervalSinceDate:self];
    if (timeInterval < 0 || timeInterval > (days * 24 * 3600)) {
        return NO;
    }
    return YES;
}


/**
 *  判断时间是否在当前时间的后n小时之外
 *
 *  @param dateStr 格式（"yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd HH:mm"
 *  @param hours 小时
 */
+ (BOOL)judgeDateStr:(NSString *)dateStr outHours:(NSInteger)hours
{
    NSDate *date = [self transformDateStr:dateStr];
    NSInteger timeInterval = [date timeIntervalSinceDate:[NSDate date]];
    if (timeInterval < (hours * 3600)) {
        return NO;
    }
    return YES;
}

+ (NSString *)currentDateStr
{
    return [self dateTransformStr:[NSDate date]];
}

+ (NSString *)currentDateSimpleFormat
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

/**
 *  把时间转换成字符串
 *
 *  @return ("yyyy-MM-dd HH:mm:ss")
 */
+ (NSString *)dateTransformStr:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/**
 *  获取当前时间前n个月数据格式  2015-09
 *
 *  @param month 前几个月
 */
+ (NSArray *)beforeCurrentMonth:(NSInteger)month
{
    NSMutableArray *muDataArray = [NSMutableArray array];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    for (NSInteger i = month - 1; i >= 0; i--) {
        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
        [adcomps setYear:0];
        [adcomps setMonth:-i];
        [adcomps setDay:0];
        NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM"];
        NSString *dateString = [dateformat stringFromDate:newdate];
        [muDataArray addObject:dateString];
    }
    return muDataArray;
}

/**
 *  把时间戳转换成字符串
 *
 *  @param timeStamp 时间戳
 *
 *  @return ("yyyy-MM-dd HH:mm:ss")
 */
+ (NSString *)timeStampTransformStr:(long long)timeStamp
{
    NSString *time = [NSString stringWithFormat:@"%lld",timeStamp];
    if (time.length > 11) {
        time = [time substringToIndex:10];
        timeStamp = [time doubleValue];
    }
    NSDate *date = [self transformTimeStamp:timeStamp];
    NSString *dateStr = [self dateTransformStr:date];
    return dateStr;
}

/**
 *  把时间转换为 分:秒
 *
 *  @param totalSeconds 秒
 *
 *  @return 分:秒
 */
+ (NSString *)totalSecondsTransformStr:(int)totalSeconds {
    NSString *seconds = [self totalSecondsTransformSeconds:totalSeconds];
    NSString *minutes = [self totalSecondsTransformMinutes:totalSeconds];
    return [NSString stringWithFormat:@"%@:%@", minutes, seconds];
}

/**
 *  把时间转换为 时:分:秒
 *
 *  @param totalSeconds 秒
 *
 *  @return 时:分:秒
 */
+ (NSString *)totalSecondsTransformFuzzyStr:(int)totalSeconds {
    NSString *seconds = [self totalSecondsTransformSeconds:totalSeconds];
    NSString *minutes = [self totalSecondsTransformMinutes:totalSeconds];
    NSString *hours = [self totalSecondsTransformHours:totalSeconds];
    return [NSString stringWithFormat:@"%@:%@:%@", hours, minutes, seconds];
}

+ (NSString *)totalSecondsTransform:(int)totalSeconds {
    NSString *seconds = [self totalSecondsTransformSeconds:totalSeconds];
    NSString *minutes = [self totalSecondsTransformMinutes:totalSeconds];
    NSString *hours = [self totalSecondsTransformHours:totalSeconds];
    return [NSString stringWithFormat:@"%@ 时 %@ 分 %@ 秒", hours, minutes, seconds];
}

/**
 *  把时间转换为 天:时:分:秒
 *
 *  @param totalSeconds 秒
 *
 *  @return 天 时:分:秒
 */
+ (NSString *)totalSecondsTransformDaysStr:(int)totalSeconds {
    NSString *seconds = [self totalSecondsTransformSeconds:totalSeconds];
    NSString *minutes = [self totalSecondsTransformMinutes:totalSeconds];
    NSString *hours = [self totalSecondsTransformDayHours:totalSeconds];
    NSString *days = [self totalSecondsTransformDays:totalSeconds];
    return [NSString stringWithFormat:@"%@天 %@:%@:%@", days, hours, minutes, seconds];
}

+ (NSString *)totalSecondsTransStr:(int)totalSecond {
    NSString *dateStr = [NSDate totalSecondsTransformFuzzyStr:totalSecond] ;
    if (totalSecond > 86400) {
        dateStr = [NSDate totalSecondsTransformDaysStr: totalSecond];
    }
    return dateStr;
}

+ (NSString *)totalSecondsTransformDays:(int)totalSeconds {
    int days = totalSeconds / 86400;
    return [NSString stringWithFormat:@"%d", days];
}

+ (NSString *)totalSecondsTransformDayHours:(int)totalSeconds {
    int hours = (totalSeconds / 3600) % 24;
    return [NSString stringWithFormat:@"%02d", hours];
}

// 可大于 24 小时
+ (NSString *)totalSecondsTransformHours:(int)totalSeconds {
    int hours = (totalSeconds / 3600);
    return [NSString stringWithFormat:@"%02d", hours];
}

+ (NSString *)totalSecondsTransformMinutes:(int)totalSeconds {
    int minutes = (totalSeconds / 60) % 60;
    return [NSString stringWithFormat:@"%02d", minutes];
}

+ (NSString *)totalSecondsTransformSeconds:(int)totalSeconds {
    int seconds = totalSeconds % 60;
    return [NSString stringWithFormat:@"%02d", seconds];
}

+ (NSString *)getResidualTime:(NSString *)time {
    NSDate *date = [self transformDateStr:time];
    long long timeInterval = [date timeIntervalSinceDate:[NSDate date]];
    if (timeInterval <= 0) {
        return @"0天";
    }
    double hour = (timeInterval % (3600 * 24)) / 3600;
    double day = timeInterval / (24 * 3600);
    NSString *timeStr = @"";
    if (day > 0) {
        timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%.0f天",day]];
    }
    if (hour > 0) {
        timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%.0f时",hour]];
    }

    return timeStr;
}

+ (CGFloat)changeToFloatTime:(NSString *)time {
    CGFloat floatTime = 0.0;
    
    NSArray *array = [time componentsSeparatedByString:@":"];
    
    if (array) {
        floatTime = [array[0] intValue] * 60 * 60 + [array[1] intValue] * 60 + [array[2] intValue];
    }
    return floatTime;
}

+ (CGFloat)changeToFloatMinute:(NSString *)time {
    CGFloat floatMinutes = 0.0;
    
    NSArray *array = [time componentsSeparatedByString:@":"];
    
    if (array) {
        floatMinutes = [array[0] intValue] * 60 + [array[1] intValue];
    }
    return floatMinutes;
}

@end
