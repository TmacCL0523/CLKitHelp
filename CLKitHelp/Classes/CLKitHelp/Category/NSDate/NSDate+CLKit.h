/***

    当前的文件名
    NSDate+CLKit.h

    不带后缀的文件名
    NSDate+CLKit

     　　　　　　　 ┏┓       ┏┓+ +
     　　　　　　　┏┛┻━━━━━━━┛┻┓ + +
     　　　　　　　┃　　　　　　 ┃
     　　　　　　　┃　　　━　　　┃ ++ + + +
     　　　　　　 █████━█████  ┃+
     　　　　　　　┃　　　　　　 ┃ +
     　　　　　　　┃　　　┻　　　┃
     　　　　　　　┃　　　　　　 ┃ + +
     　　　　　　　┗━━┓　　　 ┏━┛
                    ┃　　  ┃
     　　　　　　　　　┃　　  ┃ + + + +
     　　　　　　　　　┃　　　┃　Code is far away from     bug with the animal protecting
     　　　　　　　　　┃　　　┃ + 　　　　         神兽保佑,代码无bug
     　　　　　　　　　┃　　　┃
     　　　　　　　　　┃　　　┃　　+
     　　　　　　　　　┃　 　 ┗━━━┓ + +
     　　　　　　　　　┃ 　　　　　┣┓
     　　　　　　　　　┃ 　　　　　┏┛
     　　　　　　　　　┗┓┓┏━━━┳┓┏┛ + + + +
     　　　　　　　　　 ┃┫┫　 ┃┫┫
     　　　　　　　　　 ┗┻┛　 ┗┻┛+ + + +

**/

#import <Foundation/Foundation.h>

#define D_MINUTE 60
#define D_HOUR   3600
#define D_DAY    86400
#define D_WEEK   604800
#define D_YEAR   31556926
#define D_YMDHMS @"yyyy-MM-dd HH:mm:ss"
#define D_YMD    @"yyyy-MM-dd"
#define D_HM     @"HH:mm"
#define D_HMS    @"HH:mm:ss"

@interface NSDate (CLKit)

#pragma mark ================属性=================

/// 最近的小时
@property (readonly) NSInteger nearestHour;

/// 时
@property (readonly) NSInteger hour;

/// 分
@property (readonly) NSInteger minute;

/// 秒
@property (readonly) NSInteger seconds;

/// 天
@property (readonly) NSInteger day;

/// 月
@property (readonly) NSInteger month;

/// 周
@property (readonly) NSInteger week;

/// 周几 - 国外算法 1 = 周天
@property (readonly) NSInteger weekday;

/// 周几
@property (readonly) NSInteger nthWeekday;

/// 年份
@property (readonly) NSInteger year;

/// 格式  yyyy-MM-dd HH:mm:ss
@property (nonatomic, readonly) NSString *dateymdhmsString;
/// 格式  yyyy-MM-dd
@property (nonatomic, readonly) NSString *dateymdString;
/// 格式  HH:mm:ss
@property (nonatomic, readonly) NSString *datehmsString;
/// 格式  HH:mm
@property (nonatomic, readonly) NSString *datehmString;
/// 时间戳
@property (nonatomic, strong) NSString *timeStamp;
#pragma mark ================类 - 方法=================
+ (NSCalendar *)currentCalendar;

/// 明天
+ (NSDate *)dateTomorrow;

/// 昨天
+ (NSDate *)dateYesterday;

/// 创建距离当前时间几天后的时间
/// @param days 天
+ (NSDate *)dateAfterWithDay:(NSInteger)days;

/// 创建距离当前时间几小时后的时间
/// @param hours 小时
+ (NSDate *)dateAfterWithHours:(NSInteger)hours;

/// 创建距离当前时间几分钟后的时间
/// @param minutes 分钟
+ (NSDate *)dateAfterWithMinutes:(NSInteger)minutes;

/// 创建前几天的时间
/// @param days 时间
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;

/// 创建前几小时的时间
/// @param dHours 小时
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;

/// 创建前几分钟的时间
/// @param dMinutes 分钟
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;

/// 获取时间有多少天
/// @param date 时间
+ (NSInteger)getDayCountWithDate:(NSDate *)date;
/// 格式化时间
/// @param dateString 时间
/// @param formatter 格式
+ (NSDate *)createDateWithDateString:(NSString *)dateString
                       withFormatter:(NSString *)formatter;
/// 时间戳转NSDate
/// @param timeInterval 时间戳
+ (NSDate *)createDateWithTimeInterVal:(double)timeInterval;

#pragma mark ===================对象 - 方法===================
// Comparing dates

/// 是否同一天
/// @param aDate 时间
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
/// 是否今天
- (BOOL)isToday;
/// 是否明天
- (BOOL)isTomorrow;
/// 是否昨天
- (BOOL)isYesterday;

/// 与日期通一星期
/// @param aDate 时间
- (BOOL)isSameWeekAsDate:(NSDate *)aDate;

/// 周 - 是否本周
- (BOOL)isThisWeek;

/// 周 - 是否下周
- (BOOL)isNextWeek;

/// 周 - 是否上周
- (BOOL)isLastWeek;

/// 与日期同一个月
/// @param aDate 时间
- (BOOL)isSameMonthAsDate:(NSDate *)aDate;

/// 月 - 是否本月
- (BOOL)isThisMonth;

/// 月 - 是否下月
- (BOOL)isNextMonth;

/// 月 - 是否上月
- (BOOL)isLastMonth;

/// 与日期同一年
/// @param aDate 时间
- (BOOL)isSameYearAsDate:(NSDate *)aDate;

/// 年 - 是否今年
- (BOOL)isThisYear;

/// 年 - 是否明年
- (BOOL)isNextYear;

/// 是否去年
- (BOOL)isLastYear;

/// 比较aDate是否比当前时间晚
/// @param aDate 比较时间
- (BOOL)isEarlierThanDate:(NSDate *)aDate;

/// 比较当前时间是否aDate早
/// @param aDate 时间
- (BOOL)isLaterThanDate:(NSDate *)aDate;

/// 将来时间
- (BOOL)isInFuture;

/// 过去时间
- (BOOL)isInPast;

/// 是否 - 工作日
- (BOOL)isTypicallyWorkday;

/// 是否 - 周末
- (BOOL)isTypicallyWeekend;

//TODO: ----------时间增加----------

/// 增加 - 年
/// @param dYears 年
- (NSDate *)dateByAddingYears:(NSInteger)dYears;

/// 增加 - 月
/// @param dMonths 月
- (NSDate *)dateByAddingMonths:(NSInteger)dMonths;

/// 增加 - 天
/// @param dDays 天
- (NSDate *)dateByAddingDays:(NSInteger)dDays;

/// 增加 - 小时
/// @param dHours 小时
- (NSDate *)dateByAddingHours:(NSInteger)dHours;

/// 增加 - 分钟
/// @param dMinutes 分钟
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes;
//TODO: ----------时间减少----------

/// 减少 - 年
/// @param dYears 年
- (NSDate *)dateBySubtractingYears:(NSInteger)dYears;

/// 减少 - 月
/// @param dMonths 月
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths;

/// 减少 - 天
/// @param dDays 天
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;

/// 减少 - 小时
/// @param dHours 小时
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;

/// 减少 - 分钟
/// @param dMinutes 分钟
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;

/// Date转换 - 开始时间
- (NSDate *)dateAtStartOfDay;

/// Date转换 - 结束时间
- (NSDate *)dateAtEndOfDay;

//TODO: ----------时间比较 - 差距值----------
/// 早多少分钟
/// @param aDate 比较时间
- (NSInteger)minutesAfterDate:(NSDate *)aDate;
/// 早多少小时
/// @param aDate 比较时间
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
/// 早多少天
/// @param aDate 比较时间
- (NSInteger)daysAfterDate:(NSDate *)aDate;
/// 晚多少分钟
/// @param aDate 比较时间
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
/// 晚多少小时
/// @param aDate 比较时间
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
/// 晚多少天
/// @param aDate 比较时间
- (NSInteger)daysBeforeDate:(NSDate *)aDate;

/// 当前date对象 比anotherDate差距多少天
/// @param anotherDate 比较时间
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

/// 判断当前时间是否在时间内
/// @param startDate 开始时间
/// @param endDate 结束时间
- (BOOL)judgeTimeByStartDate:(NSString *)startDate
                  andEndTime:(NSString *)endDate;

@end
