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

#import "NSDate+CLKit.h"

static const unsigned componentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (CLKit)
#pragma mark ===================属性===================

- (NSInteger)nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

/// 时
- (NSInteger)hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

/// 分
- (NSInteger)minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

/// 秒
- (NSInteger)seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

/// 天
- (NSInteger)day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

/// 月
- (NSInteger)month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

/// 周
- (NSInteger)week
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.week;
}

/// 周几 - 周日为1
- (NSInteger)weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

/// 周几
- (NSInteger)nthWeekday  // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

/// 年
- (NSInteger)year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

//TODO: ----------格式化时间----------

/// 格式化 - yyyy-MM-dd HH:mm:ss
- (NSString *)dateymdhmsString
{
    return [self stringWithFormat:D_YMDHMS];
}

/// 格式化 - yyyy-MM-dd
- (NSString *)dateymdString
{
    return [self stringWithFormat:D_YMDHMS];
}

/// 格式化 - HH:mm
- (NSString *)datehmString
{
    return [self stringWithFormat:D_HM];
}

/// 格式化 - HH:mm:ss
- (NSString *)datehmsString
{
    return [self stringWithFormat:D_HMS];
}

/// 转换成时间戳
- (NSString *)timeStamp
{
    NSInteger timeSp = [[NSNumber numberWithDouble:[self timeIntervalSince1970]] integerValue] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)timeSp];
    return timeString;
}

#pragma mark ===================类 - 方法===================
+ (NSCalendar *)currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar) sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

/// 明天
+ (NSDate *)dateTomorrow
{
    return [NSDate dateAfterWithDay:1];
}

/// 昨天
+ (NSDate *)dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

/// 创建距离当前时间几天后的时间
/// @param days 天
+ (NSDate *)dateAfterWithDay:(NSInteger)days
{
    return [[NSDate date] dateByAddingDays:days];
}

/// 创建距离当前时间几小时后的时间
/// @param hours 小时
+ (NSDate *)dateAfterWithHours:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

/// 创建距离当前时间几分钟后的时间
/// @param minutes 分钟
+ (NSDate *)dateAfterWithMinutes:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

/// 创建前几天的时间
/// @param days 时间
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days
{
    return [[NSDate date] dateBySubtractingDays:days];
}

/// 创建前几小时的时间
/// @param dHours 小时
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

/// 创建前几分钟的时间
/// @param dMinutes 分钟
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

/// 获取时间有多少天
/// @param date 时间
+ (NSInteger)getDayCountWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];

    return range.length;
}

+ (NSDate *)createDateWithDateString:(NSString *)dateString
                       withFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

/// 根据时间戳创建时间
/// @param timeInterval 时间戳（*1000）
+ (NSDate *)createDateWithTimeInterVal:(double)timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval / 1000];
    return date;
}

#pragma mark ===================对象 - 方法===================
//TODO: ----------格式化----------
/// 根据date格式化转换为字符串
/// @param format 格式化
- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
//    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

//TODO: ----------时间比较----------
/// 是否同一天
/// @param aDate 时间
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

/// 是否今天
- (BOOL)isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

/// 是否明天
- (BOOL)isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

/// 是否昨天
- (BOOL)isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

/// 与日期通一星期
/// @param aDate 时间
- (BOOL)isSameWeekAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];

    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.week != components2.week) return NO;

    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

/// 周 - 是否本周
- (BOOL)isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

/// 周 - 是否下周
- (BOOL)isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

/// 周 - 是否上周
- (BOOL)isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

/// 与日期同一个月
/// @param aDate 时间
- (BOOL)isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

/// 月 - 是否本月
- (BOOL)isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

/// 月 - 是否上月
- (BOOL)isLastMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

/// 月 - 是否上月
- (BOOL)isNextMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

/// 与日期同一年
/// @param aDate 时间
- (BOOL)isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

/// 年 - 是否今年
- (BOOL)isThisYear
{
    // Thanks, baspellis
    return [self isSameYearAsDate:[NSDate date]];
}

/// 年 - 是否明年
- (BOOL)isNextYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];

    return (components1.year == (components2.year + 1));
}

///  是否去年
- (BOOL)isLastYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];

    return (components1.year == (components2.year - 1));
}

/// 比较aDate是否比当前时间晚
/// @param aDate 比较时间
- (BOOL)isEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

/// 比较当前时间是否aDate早
/// @param aDate 时间
- (BOOL)isLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

/// 将来时间
- (BOOL)isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

/// 过去时间
- (BOOL)isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}

/// 是否 - 周末
- (BOOL)isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7)) return YES;
    return NO;
}

/// 是否 - 工作日
- (BOOL)isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

//TODO: ----------时间增加----------

/// 增加 - 年
/// @param dYears 年
- (NSDate *)dateByAddingYears:(NSInteger)dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

/// 增加 - 月
/// @param dMonths 月
- (NSDate *)dateByAddingMonths:(NSInteger)dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

/// 增加 - 天
/// @param dDays 天
- (NSDate *)dateByAddingDays:(NSInteger)dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

/// 增加 - 小时
/// @param dHours 小时
- (NSDate *)dateByAddingHours:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

/// 增加 - 分钟
/// @param dMinutes 分钟
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

//TODO: ----------时间减少----------
/// 减少 - 年
/// @param dYears 年
- (NSDate *)dateBySubtractingYears:(NSInteger)dYears
{
    return [self dateByAddingYears:-dYears];
}

/// 减少 - 月
/// @param dMonths 月
- (NSDate *)dateBySubtractingMonths:(NSInteger)dMonths
{
    return [self dateByAddingMonths:-dMonths];
}

/// 减少 - 天
/// @param dDays 天
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays
{
    return [self dateByAddingDays:(dDays * -1)];
}

/// 减少 - 小时
/// @param dHours 小时
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours
{
    return [self dateByAddingHours:(dHours * -1)];
}

/// 减少 - 分钟
/// @param dMinutes 分钟
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes
{
    return [self dateByAddingMinutes:(dMinutes * -1)];
}

/// Date转换 - 开始时间
- (NSDate *)dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

/// Date转换 - 结束时间
- (NSDate *)dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23;     // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

//TODO: ----------时间相差数值----------

//TODO: ----------时间比较 - 差距值----------
/// 早多少分钟
/// @param aDate 比较时间
- (NSInteger)minutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_MINUTE);
}

/// 早多少小时
/// @param aDate 比较时间
- (NSInteger)hoursAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_HOUR);
}

/// 早多少天
/// @param aDate 比较时间
- (NSInteger)daysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / D_DAY);
}

/// 晚多少分钟
/// @param aDate 比较时间
- (NSInteger)minutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_MINUTE);
}

/// 晚多少小时
/// @param aDate 比较时间
- (NSInteger)hoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_HOUR);
}

/// 晚多少天
/// @param aDate 比较时间
- (NSInteger)daysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / D_DAY);
}

/// 当前date对象 比anotherDate差距多少天
/// @param anotherDate 比较时间
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

/// 判断当前时间是否在时间内
/// @param startDate 开始时间
/// @param endDate 结束时间
- (BOOL)judgeTimeByStartDate:(NSString *)startDate
                  andEndTime:(NSString *)endDate
{
    //获取当前时间
    NSDate *today = [NSDate date];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,建议大写    HH 使用 24 小时制；hh 12小时制
    [dateFormat setDateFormat:@"yyyy:mm:HH:mm:ss"];
    NSString *todayStr = [dateFormat stringFromDate:today];//将日期转换成字符串
    today = [dateFormat dateFromString:todayStr];//转换成NSDate类型。日期置为方法默认日期
    //start end 格式 "2016-05-18 9:00:00"
    NSDate *start = [dateFormat dateFromString:startDate];
    NSDate *expire = [dateFormat dateFromString:endDate];

    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

@end
