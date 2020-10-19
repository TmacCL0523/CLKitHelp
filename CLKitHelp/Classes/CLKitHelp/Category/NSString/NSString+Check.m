
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

#import "NSString+Check.h"

@implementation NSString (Check)

/// 获得汉字的拼音
/// @param chinese 中文字符串
+ (NSString *)clKitCheckPinYinWithStr:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}

/// 判断是否包含中文
- (BOOL)clKitCheckContainChinese
{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

/// 获取字符数量
- (int)clKitCheckWordsCount
{
    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++) {
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}

/// 字符串转字典
- (NSDictionary *)clKitFormatterToDictionary
{
    NSError *errorJson;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&errorJson];
    if (errorJson != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", self, errorJson);
#endif
    }
    return jsonDict;
}

///    手机号分服务商
- (BOOL)clKitCheckMobileNumberClassification
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     * 联通：130,131,132,152,155,156,185,186,1709
     * 电信：133,1349,153,180,189,1700,173
     */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况

    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     12         */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,1709
     17         */
    NSString *CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,1700,173
     22         */
    NSString *CT = @"^1((33|53|73|8[09])\\d|349|700)\\d{7}$";

    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString *PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";

    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    if (([self isValidateByRegex:CM])
        || ([self isValidateByRegex:CU])
        || ([self isValidateByRegex:CT])
        || ([self isValidateByRegex:PHS])) {
        return YES;
    } else {
        return NO;
    }
}

///    手机号有效性
- (BOOL)clKitCheckMobileNumber
{
    NSString *mobileRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0678]|18[0-9]|14[57])[0-9]{8}$";
    BOOL ret1 = [self isValidateByRegex:mobileRegex];
    return ret1;
}

///    邮箱地址
- (BOOL)clKitCheckEmailAddress
{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

///    身份证号码
- (BOOL)clKitCheckIdentityCardNum
{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self isValidateByRegex:regex2];
}

///    验证身份证（算法验证）
+ (BOOL)clKitCheckSafeIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    if (!value) {
        return NO;
    } else {
        length = (int)value.length;

        if (length != 15 && length != 18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6, 2)].intValue + 1900;

            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            } else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];

            if (numberofMatch > 0) {
                return YES;
            } else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6, 4)].intValue;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            } else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if (numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0, 1)].intValue + [value substringWithRange:NSMakeRange(10, 1)].intValue) * 7 + ([value substringWithRange:NSMakeRange(1, 1)].intValue + [value substringWithRange:NSMakeRange(11, 1)].intValue) * 9 + ([value substringWithRange:NSMakeRange(2, 1)].intValue + [value substringWithRange:NSMakeRange(12, 1)].intValue) * 10 + ([value substringWithRange:NSMakeRange(3, 1)].intValue + [value substringWithRange:NSMakeRange(13, 1)].intValue) * 5 + ([value substringWithRange:NSMakeRange(4, 1)].intValue + [value substringWithRange:NSMakeRange(14, 1)].intValue) * 8 + ([value substringWithRange:NSMakeRange(5, 1)].intValue + [value substringWithRange:NSMakeRange(15, 1)].intValue) * 4 + ([value substringWithRange:NSMakeRange(6, 1)].intValue + [value substringWithRange:NSMakeRange(16, 1)].intValue) * 2 + [value substringWithRange:NSMakeRange(7, 1)].intValue * 1 + [value substringWithRange:NSMakeRange(8, 1)].intValue * 6 + [value substringWithRange:NSMakeRange(9, 1)].intValue * 3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y, 1)];// 判断校验位
                NSString *test = [value substringWithRange:NSMakeRange(17, 1)];
                if ([[M lowercaseString] isEqualToString:[test lowercaseString]]) {
                    return YES;// 检测ID的校验位
                } else {
                    return NO;
                }
            } else {
                return NO;
            }
        default:
            return NO;
    }
}

///    车牌号码
- (BOOL)clKitCheckCarNumber
{
    //车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    //其中\u4e00-\u9fa5表示unicode编码中汉字已编码部分，\u9fa5-\u9fff是保留部分，将来可能会添加
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";
    return [self isValidateByRegex:carRegex];
}

///    银行卡号验证（Luhn算法）
- (BOOL)clKitCheckBankCardluhmCheck
{
    //取出最后一位
    NSString *lastNum = [[self substringFromIndex:(self.length - 1)] copy];
    //前15或18位
    NSString *forwardNum = [[self substringToIndex:(self.length - 1)] copy];

    NSMutableArray *forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < forwardNum.length; i++) {
        NSString *subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    NSMutableArray *forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    //前15位或者前18位倒序存进数组
    for (int i = (int)(forwardArr.count - 1); i > -1; i--) {
        [forwardDescArr addObject:forwardArr[i]];
    }
    //奇数位*2的积 < 9
    NSMutableArray *arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];
    //奇数位*2的积 > 9
    NSMutableArray *arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];
    //偶数位数组
    NSMutableArray *arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i % 2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        } else {//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            } else {
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    __block NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    __block NSInteger sumEvenNumTotal = 0;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    NSInteger lastNumber = [lastNum integerValue];
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    return (luhmTotal % 10 == 0) ? YES : NO;
}

///    IP地址验证
- (BOOL)clKitCheckIPAddress
{
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL rc = [pre evaluateWithObject:self];
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        return v;
    }
    return NO;
}

///    MAC地址验证
- (BOOL)clKitCheckMacAddress
{
    NSString *macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    return [self isValidateByRegex:macAddRegex];
}

///    网站验证
- (BOOL)clKitCheckValidUrl
{
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self isValidateByRegex:regex];
}

///    纯中文验证
- (BOOL)clKitCheckValidChinese
{
    NSString *chineseRegex = @"^[\u4e00-\u9fa5]+$";
    return [self isValidateByRegex:chineseRegex];
}

///    邮编验证
- (BOOL)clKitCheckValidPostalcode
{
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    return [self isValidateByRegex:postalRegex];
}

///    工商税号验证
- (BOOL)clKitCheckValidTaxNo
{
    NSString *taxNoRegex = @"[0-9]\\d{13}([0-9]|X)$";
    return [self isValidateByRegex:taxNoRegex];
}

#pragma mark ===================私有方法===================

//TODO: ----------正则表达式----------
#pragma mark - 正则相关
- (BOOL)isValidateByRegex:(NSString *)regex
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:self];
}

@end
