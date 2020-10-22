
/***

    当前的文件名
    NSString+Formatter.h

    不带后缀的文件名
    NSString+Formatter

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

#import "NSString+Formatter.h"

@implementation NSString (Formatter)

/// 手机号码格式化样式：344【中间空格】，示例：13855556666 --> 138 5555 6666
/// @param phoneNumber 138 5555 6666
+ (NSString *)clKitFormatterPhoneNumberSpace:(NSString *)phoneNumber
{
    NSString *phone = phoneNumber;

    while (phone.length > 0) {
        NSString *subString = [phone substringToIndex:MIN(phone.length, 3)];
        if (phone.length >= 7) {
            subString = [subString stringByAppendingString:@" "];
            subString = [subString stringByAppendingString:[phone substringWithRange:NSMakeRange(3, 4)]];
        }
        if (phone.length == 11) {
            subString = [subString stringByAppendingString:@" "];
            subString = [subString stringByAppendingString:[phone substringWithRange:NSMakeRange(7, 4)]];
            phone = subString;
            break;
        }
    }

    return phone;
}

/// 手机号码格式化样式：3*4【中间4位为*】，示例：13855556666 --> 138****6666
/// @param phoneNumber 138****6666
+ (NSString *)clKitFormatterPhoneNumberCenterStar:(NSString *)phoneNumber
{
    NSString *phone = phoneNumber;

    while (phone.length > 0) {
        phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        break;
    }

    return phone;
}

/// 数字格式化样式，示例：12345678.89 --> 12,345,678.89
/// @param numberStyle 样式
/// @param numberString 12,345,678.89
+ (NSString *)clKitFormatterWithStyle:(NSNumberFormatterStyle)numberStyle
                         numberString:(NSString *)numberString
{
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = numberStyle;
    NSString *string = [formatter stringFromNumber:number];

    return string;
}

/// 格式化为带小数点的数字，示例：12345678.89 --> 12,345,678.89
/// @param numberString 12,345,678.89
+ (NSString *)clKitFormatterWithDecimalStyleWithNumberString:(NSString *)numberString
{
    return [NSString clKitFormatterWithStyle:NSNumberFormatterDecimalStyle numberString:numberString];
}

/// 格式化为货币样式，示例：12345678.89 --> 12,345,678.89
/// @param numberString 12,345,678.89
+ (NSString *)clKitFormatterWithCurrencyStyleWithNumberString:(NSString *)numberString
{
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    NSString *string = [formatter stringFromNumber:number];

    /*! 输出结果示例：numberFormatter == 12,345,678.89 */
    return string;
}

/// 格式化为百分比样式，示例：12345678.89 --> 1,234,567,889%
/// @param numberString 1,234,567,889%
+ (NSString *)clKitFormatterWithPercentStyleWithNumberString:(NSString *)numberString
{
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    NSString *string = [formatter stringFromNumber:number];

    /*! 输出结果示例：numberFormatter == 1,234,567,889% */
    return string;
}

/// 格式化为科学计数样式，示例：12345678.89 --> 1.234567889E7
/// @param numberString 1.234567889E7
+ (NSString *)clKitFormatterWithScientificStyleWithNumberString:(NSString *)numberString
{
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterScientificStyle;
    NSString *string = [formatter stringFromNumber:number];

    /*! 输出结果示例：numberFormatter == 1.234567889E7 */
    return string;
}

/// 格式化为英文输出样式（注：此处根据系统语言输出），示例：12345678.89 --> 一千二百三十四万五千六百七十八点八九
/// @param numberString 一千二百三十四万五千六百七十八点八九
+ (NSString *)clKitFormatterWithSpellOutStyleWithNumberString:(NSString *)numberString
{
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    NSString *string = [formatter stringFromNumber:number];

    /*! 输出结果示例：numberFormatter == twelve million three hundred forty-five thousand six hundred seventy-eight point eight nine */
    return string;
}

/// 格式化为序数样式，示例：12345678.89 --> 第1234,5679
/// @param numberString 第1234,5679
+ (NSString *)clKitFormatterWithOrdinalStyleWithNumberString:(NSString *)numberString
{
    NSString *numString = numberString;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle = NSNumberFormatterOrdinalStyle;
    NSString *string = [formatter stringFromNumber:number];

    /*! 输出结果示例：numberFormatter == 第1234,5679 */
    return string;
}

+ (BOOL)checkDecimalDotPlaces:(NSRange)range
                    dotPlaces:(NSNumber *)dotPlaces
                      decimal:(NSString *)decimal
{
    BOOL bHaveDot = false;

    if (dotPlaces.integerValue < 0) {
        dotPlaces = @0;
    }

    if ([decimal rangeOfString:@"."].location == NSNotFound) {
        bHaveDot = false;
    } else {
        bHaveDot = true;
    }

    if (bHaveDot) {
        //判断小数点的位数
        NSRange ran = [decimal rangeOfString:@"."];

        if (range.location - ran.location > dotPlaces.integerValue) {
            return NO;
        }
    }
    return YES;
}

/// 点赞数处理：2.1千，3.4万
/// @param string 传入的 string 类型的 数字
+ (NSString *)clKitFormatterLikeNumber:(NSString *)string
{
    float number = [string integerValue];

    NSString *numberString = @"";
    if (number < 1000) {
        numberString = [NSString stringWithFormat:@"%.0f", number];
    } else
    if (number / 1000 && number / 10000 < 1) {
        numberString = [NSString stringWithFormat:@"%.1f千", number / 1000];
    } else {
        numberString = [NSString stringWithFormat:@"%.1f万", number / 10000];
    }

    return numberString;
}

///    清除HTML标签
- (NSString *)clKitFormatterByStrippingHTML
{
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

///    清除JS脚本
- (NSString *)clKitFormatterByRemovingScriptsAndStrippingHTML
{
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString clKitFormatterByStrippingHTML];
}

///    清除空格
- (NSString *)clKitFormatterRemoveSpace
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

///    取出空格空行
- (NSString *)clKitFormatterRemoveSpaceAndBankLine
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/// 随机字符串
+ (NSString *)clkitRandomString
{
    NSInteger count = arc4random_uniform(200);
    NSString *letters = @"0123456789ABCDEFGHIJKLMNOPQRST我们还是爱你的狗子你变了,.!我QWERTYUI偶怕对方过后注册风格好看UI欧派";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:count];

    for (NSInteger i = 0; i < count; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform(letters.length)]];
    }
    return randomString;
}

/// 根据key取不同语言字符串 （国际化操作）
/// @param key 关键字
/// @param table 表名
+ (NSString *)clKitGetStrForLanguageWithKey:(NSString *)key
                                  withTable:(NSString *)table
{
    NSString * translated = NSLocalizedStringFromTable(key, table, nil);
    return translated;
}

@end
