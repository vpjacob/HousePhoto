//
//  NSDate+BTAddition.h
//  BEConnector
//
//  Created by andy on 3/18/15.
//  Copyright (c) 2015 NationSky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BTAddition)

/**
 *  转换成描述性字符串
 */
- (NSString *)transformToFuzzyDate;

/**
 *  转换成描述性字符串
 */
- (NSString *)promptDateString;


/**
 *  时间戳 -> NSDate
 *
 *  @param timeStamp 时间戳
 */
+ (NSDate *)transformTimeStamp:(long long)timeStamp;

/**
 *  dataStr -> NSDate
 *
 *  @param dateStr  格式（"yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd HH:mm"）
 */
+ (NSDate *)transformDateStr:(NSString *)dateStr;

/**
 *  dataStr -> NSDate
 *
 *  @param dateStr
 *  @param dateFormate  exp ("yyyy-MM-dd HH:mm:ss"）
 */
+ (NSDate *)transformDateStr:(NSString *)dateStr
                  dateFormat:(NSString *)dateFormate;

/**
 *  NSDate -> dataStr
 *
 *  @param NSDate
 *  @param dateFormate  exp ("yyyy-MM-dd HH:mm:ss"）
 */

+ (NSString *)transformDate:(NSDate *)date
                 dateFormat:(NSString *)dateFormate;
/**
 *  获取时间差
 *
 *  @param date 比较时间
 */
- (NSInteger)compareDate:(NSDate *)date;

/**
 *  获取当前时间的时间差
 *
 *  @param date 比较时间
 */
+ (NSInteger)compareCurrentDate:(NSDate *)date;

/**
 *  获取 当前时间 与 dateStr 的时间差 (用于倒计时)
 *
 *  @param dateStr 比较时间 格式（"yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd HH:mm"）
 *  @param 时间间隔
 */
+ (NSInteger)compareCurrentDateInterval:(NSString *)dateStr;

/**
 *  判断时间是否在当前日期的后n天之内
 *
 *  @param dateStr 格式（"yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd HH:mm"）
 *  @param days 天
 */
+ (BOOL)judgeDateStr:(NSString *)dateStr withInDays:(NSInteger)days;


/**
 *  判断时间是否在当前时间的后n小时之外
 *
 *  @param dateStr 格式（"yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd HH:mm"）
 *  @param hours 小时
 */
+ (BOOL)judgeDateStr:(NSString *)dateStr outHours:(NSInteger)hours;
- (BOOL)judgeDateStr:(NSString *)dateStr withInDays:(NSInteger)days;

/**
 *  获取当前时间前n个月数据格式  2015-09
 *
 *  @param month 前几个月
 */
+ (NSArray *)beforeCurrentMonth:(NSInteger)month;

/**
 *  获取当前时间的字符串格式
 *
 *  @return ("yyyy-MM-dd HH:mm:ss")
 */
+ (NSString *)currentDateStr;

/**
 *  获取当前时间的字符串格式
 *
 *  @return ("yyyyMMddHHmmss")
 */
+ (NSString *)currentDateSimpleFormat;

/**
 *  把时间转换成字符串
 *
 *  @return ("yyyy-MM-dd HH:mm:ss")
 */
+ (NSString *)dateTransformStr:(NSDate *)date;

/**
 *  把时间戳转换成字符串
 *
 *  @param timeStamp 时间戳
 *
 *  @return ("yyyy-MM-dd HH:mm:ss")
 */
+ (NSString *)timeStampTransformStr:(long long)timeStamp;

/**
 *  把时间转换为 分:秒
 *
 *  @param totalSeconds 秒
 *
 *  @return 分:秒
 */
+ (NSString *)totalSecondsTransformStr:(int)totalSeconds;

/**
 *  把时间转换为 时:分:秒
 *
 *  @param totalSeconds 秒
 *
 *  @return 时:分:秒
 */
+ (NSString *)totalSecondsTransformFuzzyStr:(int)totalSeconds;

/**
 *  把时间转换为 时:分:秒
 *
 *  @param totalSeconds 秒
 *
 *  @return xx时xx分xx秒
 */
+ (NSString *)totalSecondsTransform:(int)totalSeconds;


/**
 *  把时间转换为 天:时:分:秒 / 时:分:秒
 *
 *  @param totalSecond 秒
 *
 *  @return 天:时:分:秒 / 时:分:秒
 */

+ (NSString *)totalSecondsTransStr:(int)totalSecond;

/**
 *  把时间转换为 天:时:分:秒
 *
 *  @param totalSecond 秒
 *
 *  @return 天:时:分:秒
 */
+ (NSString *)totalSecondsTransformDaysStr:(int)totalSecond;

/**
 *  把时间转换为 小时(可大于24小时)
 *
 *  @param totalSeconds 秒
 *
 *  @return 时
 */
+ (NSString *)totalSecondsTransformHours:(int)totalSeconds;

/**
 *  把时间转换为 分钟
 *
 *  @param totalSeconds 秒
 *
 *  @return 分钟
 */
+ (NSString *)totalSecondsTransformMinutes:(int)totalSeconds;

/**
 *  把时间转换为 秒
 *
 *  @param totalSeconds 秒
 *
 *  @return 秒
 */
+ (NSString *)totalSecondsTransformSeconds:(int)totalSeconds;

/**
 *  获取当前时间的剩余时间
 *
 *  @param time 要比较的时间
 *
 */
+ (NSString *)getResidualTime:(NSString *)time;

/**
 *  把时间转换为 float时间
 *
 *  @param time 时间字符串
 *
 *  @return 时间float
 */
+ (CGFloat)changeToFloatTime:(NSString *)time;

/**
 *  把时间转换为 float分钟
 *
 *  @param time 时间字符串
 *
 *  @return 分钟float
 */
+ (CGFloat)changeToFloatMinute:(NSString *)time;

@end
