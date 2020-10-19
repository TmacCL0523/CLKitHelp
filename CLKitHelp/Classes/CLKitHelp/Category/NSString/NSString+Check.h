/***

    当前的文件名
    NSString+Check.h

    不带后缀的文件名
    NSString+Check

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

@interface NSString (Check)

/// 获得汉字的拼音
/// @param chinese 中文字符串
+ (NSString *)clKitCheckPinYinWithStr:(NSString *)chinese;

/// 判断是否包含中文
- (BOOL)clKitCheckContainChinese;

/// 获取字符数量
- (int)clKitCheckWordsCount;

/// 字符串转字典
- (NSDictionary *)clKitFormatterToDictionary;

///    手机号分服务商
- (BOOL)clKitCheckMobileNumberClassification;

///    手机号有效性
- (BOOL)clKitCheckMobileNumber;

///    邮箱地址
- (BOOL)clKitCheckEmailAddress;

///    身份证号码
- (BOOL)clKitCheckIdentityCardNum;

///    验证身份证（算法验证）
+ (BOOL)clKitCheckSafeIDCardNumber:(NSString *)value;

///    车牌号码
- (BOOL)clKitCheckCarNumber;

///    银行卡号验证（Luhn算法）
- (BOOL)clKitCheckBankCardluhmCheck;

///    IP地址验证
- (BOOL)clKitCheckIPAddress;
///    MAC地址验证
- (BOOL)clKitCheckMacAddress;
///    网站验证
- (BOOL)clKitCheckValidUrl;
///    纯中文验证
- (BOOL)clKitCheckValidChinese;
///    邮编验证
- (BOOL)clKitCheckValidPostalcode;

///    工商税号验证
- (BOOL)clKitCheckValidTaxNo;

@end
