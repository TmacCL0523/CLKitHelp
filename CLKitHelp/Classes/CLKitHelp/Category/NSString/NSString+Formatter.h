
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

#import <Foundation/Foundation.h>

@interface NSString (Formatter)

/// 手机号码格式化样式：344【中间空格】，示例：13855556666 --> 138 5555 6666
/// @param phoneNumber 138 5555 6666
+ (NSString *)clKitFormatterPhoneNumberSpace:(NSString *)phoneNumber;

/// 手机号码格式化样式：3*4【中间4位为*】，示例：13855556666 --> 138****6666
/// @param phoneNumber 138****6666
+ (NSString *)clKitFormatterPhoneNumberCenterStar:(NSString *)phoneNumber;

/// 数字格式化样式，示例：12345678.89 --> 12,345,678.89
/// @param numberStyle 样式
/// @param numberString 12,345,678.89
+ (NSString *)clKitFormatterWithStyle:(NSNumberFormatterStyle)numberStyle
                         numberString:(NSString *)numberString;

/// 格式化为带小数点的数字，示例：12345678.89 --> 12,345,678.89
/// @param numberString 12,345,678.89
+ (NSString *)clKitFormatterWithDecimalStyleWithNumberString:(NSString *)numberString;

/// 格式化为货币样式，示例：12345678.89 --> 12,345,678.89
/// @param numberString 12,345,678.89
+ (NSString *)clKitFormatterWithCurrencyStyleWithNumberString:(NSString *)numberString;

/// 格式化为百分比样式，示例：12345678.89 --> 1,234,567,889%
/// @param numberString 1,234,567,889%
+ (NSString *)clKitFormatterWithPercentStyleWithNumberString:(NSString *)numberString;

/// 格式化为科学计数样式，示例：12345678.89 --> 1.234567889E7
/// @param numberString 1.234567889E7
+ (NSString *)clKitFormatterWithScientificStyleWithNumberString:(NSString *)numberString;

/// 格式化为英文输出样式（注：此处根据系统语言输出），示例：12345678.89 --> 一千二百三十四万五千六百七十八点八九
/// @param numberString 一千二百三十四万五千六百七十八点八九
+ (NSString *)clKitFormatterWithSpellOutStyleWithNumberString:(NSString *)numberString;

/// 格式化为序数样式，示例：12345678.89 --> 第1234,5679
/// @param numberString 第1234,5679
+ (NSString *)clKitFormatterWithOrdinalStyleWithNumberString:(NSString *)numberString;

+ (BOOL)checkDecimalDotPlaces:(NSRange)range
                    dotPlaces:(NSNumber *)dotPlaces
                      decimal:(NSString *)decimal;

/// 点赞数处理：2.1千，3.4万
/// @param string 传入的 string 类型的 数字
+ (NSString *)clKitFormatterLikeNumber:(NSString *)string;

///    清除HTML标签
- (NSString *)clKitFormatterByStrippingHTML;

///    清除JS脚本
- (NSString *)clKitFormatterByRemovingScriptsAndStrippingHTML;

///    清除空格
- (NSString *)clKitFormatterRemoveSpace;

///    取出空格空行
- (NSString *)clKitFormatterRemoveSpaceAndBankLine;

///    随机字符串
+ (NSString *)clkitRandomString;

@end
