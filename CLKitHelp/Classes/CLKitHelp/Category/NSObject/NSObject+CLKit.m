/***

    当前的文件名
    NSObject+CLKit.h

    不带后缀的文件名
    NSObject+CLKit

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

#import "NSObject+CLKit.h"
#import <sys/utsname.h>
#import <objc/runtime.h>


@implementation NSObject (CLKit)

/** 版本号 */
+ (NSString *)clKitVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

/** build号 */
+ (NSInteger)clKitBuild
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return [app_build integerValue];
}

/** Bundle id */
+ (NSString *)clKitIdentifier
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return bundleIdentifier;
}

/** 语言 */
+ (NSString *)clKitCurrentLanguage
{
    return [[NSLocale preferredLanguages] firstObject];
}

/** 架构 */
+ (NSString *)clKitDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

/** 类名 */
- (NSString *)clKitClassName
{
    return NSStringFromClass([self class]);
}

/** 类名 */
+ (NSString *)clKitClassName
{
    return NSStringFromClass([self class]);
}

/** 父类名 */
- (NSString *)clKitSuperClassName
{
    return NSStringFromClass([self superclass]);
}

/** 父类名 */
+ (NSString *)clKitSuperClassName
{
    return NSStringFromClass([self superclass]);
}

/** 实例属性字典 */
- (NSDictionary *)clKitPropertyDictionary
{
    //创建可变字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id propValue = [self valueForKey:propName];
        [dict setObject:propValue ? : [NSNull null] forKey:propName];
    }
    free(props);
    return dict;
}

/** 属性名称列表 */
- (NSArray *)clKitPropertyKeys
{
    return [[self class] clKitPropertyKeys];
}

/** 属性名称列表 */
+ (NSArray *)clKitPropertyKeys
{
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(self, &propertyCount);
    NSMutableArray *propertyNames = [NSMutableArray array];
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNames;
}

/** 方法列表 */
- (NSArray *)clKitMethodList
{
    u_int count;
    NSMutableArray *methodList = [NSMutableArray array];
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        [methodList addObject:strName];
    }
    free(methods);
    return methodList;
}

/** 方法列表 */
+ (NSArray *)clKitMethodList
{
    u_int count;
    NSMutableArray *methodList = [NSMutableArray array];
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        [methodList addObject:strName];
    }
    free(methods);

    return methodList;
}

/** 格式化方法列表 */
- (NSArray *)clKitMethodListInfo
{
    u_int count;
    NSMutableArray *methodList = [NSMutableArray array];
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSMutableDictionary *info = [NSMutableDictionary dictionary];

        Method method = methods[i];
        //        IMP imp = method_getImplementation(method);
        SEL name = method_getName(method);
        // 返回方法的参数的个数
        int argumentsCount = method_getNumberOfArguments(method);
        //获取描述方法参数和返回值类型的字符串
        const char *encoding = method_getTypeEncoding(method);
        //取方法的返回值类型的字符串
        const char *returnType = method_copyReturnType(method);

        NSMutableArray *arguments = [NSMutableArray array];
        for (int index = 0; index < argumentsCount; index++) {
            // 获取方法的指定位置参数的类型字符串
            char *arg =   method_copyArgumentType(method, index);
            //            NSString *argString = [NSString stringWithCString:arg encoding:NSUTF8StringEncoding];
            [arguments addObject:[[self class] decodeType:arg]];
        }

        NSString *returnTypeString = [[self class] decodeType:returnType];
        NSString *encodeString = [[self class] decodeType:encoding];
        NSString *nameString = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];

        [info setObject:arguments forKey:@"arguments"];
        [info setObject:[NSString stringWithFormat:@"%d", argumentsCount] forKey:@"argumentsCount"];
        [info setObject:returnTypeString forKey:@"returnType"];
        [info setObject:encodeString forKey:@"encode"];
        [info setObject:nameString forKey:@"name"];
        //        [info setObject:imp_f forKey:@"imp"];
        [methodList addObject:info];
    }
    free(methods);
    return methodList;
}

/** 创建并返回一个指向所有已注册类的指针列表 */
+ (NSArray *)clKitRegistedClassList
{
    NSMutableArray *result = [NSMutableArray array];

    unsigned int count;
    Class *classes = objc_copyClassList(&count);
    for (int i = 0; i < count; i++) {
        [result addObject:NSStringFromClass(classes[i])];
    }
    free(classes);
    [result sortedArrayUsingSelector:@selector(compare:)];

    return result;
}

/** 实例变量 */
+ (NSArray *)clKitInstanceVariable
{
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < outCount; i++) {
        NSString *type = [[self class] decodeType:ivar_getTypeEncoding(ivars[i])];
        NSString *name = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        NSString *ivarDescription = [NSString stringWithFormat:@"%@ %@", type, name];
        [result addObject:ivarDescription];
    }
    free(ivars);
    return result.count ? [result copy] : nil;
}

/** 是否包含某个属性 */
- (BOOL)clKitHasPropertyForKey:(NSString *)key
{
    objc_property_t property = class_getProperty([self class], [key UTF8String]);
    return (BOOL)property;
}

/** 是否包含某个实例变量 */
- (BOOL)clKitHasIvarForKey:(NSString *)key
{
    Ivar ivar = class_getInstanceVariable([self class], [key UTF8String]);
    return (BOOL)ivar;
}

- (void)clKitModelWithDictionary:(NSDictionary *)dict __attribute__((deprecated(" ")))
{
    //得到本模型的所有属性
    NSArray *propertyNameList = [self getPropertyNameList];
    //遍历字典中的所有属性
    [dict enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
        //根据本类的属性有选择的拿字典中的key value
        //如果本类的属性包含字典的key,则把key的value赋值给这个属性
        if ([propertyNameList containsObject:key]) {
            [self setValue:obj forKey:key];
        }
    }];
}

- (NSArray<NSString *> *)getPropertyNameList
{
    NSMutableArray *mArray = [NSMutableArray array];
    unsigned int count;
    /*
     本类中的属性列表
     1.哪个类
     2.输出参数 有几个属性
     返回一个数组 数组内的类型是objc_property_t, 代表了属性
     */
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);

    //循环所有属性,拿到属性名字
    for (int i = 0; i < count; i++) {
        objc_property_t properyt = propertyList[i];
        const char *propertyName = property_getName(properyt);
        //属性的名字
        NSString *nameString = [NSString stringWithUTF8String:propertyName];
        [mArray addObject:nameString];
    }
    return mArray.copy;
}

+ (NSString *)decodeType:(const char *)cString
{
    if (!strcmp(cString, @encode(char))) return @"char";
    if (!strcmp(cString, @encode(int))) return @"int";
    if (!strcmp(cString, @encode(short))) return @"short";
    if (!strcmp(cString, @encode(long))) return @"long";
    if (!strcmp(cString, @encode(long long))) return @"long long";
    if (!strcmp(cString, @encode(unsigned char))) return @"unsigned char";
    if (!strcmp(cString, @encode(unsigned int))) return @"unsigned int";
    if (!strcmp(cString, @encode(unsigned short))) return @"unsigned short";
    if (!strcmp(cString, @encode(unsigned long))) return @"unsigned long";
    if (!strcmp(cString, @encode(unsigned long long))) return @"unsigned long long";
    if (!strcmp(cString, @encode(float))) return @"float";
    if (!strcmp(cString, @encode(double))) return @"double";
    if (!strcmp(cString, @encode(bool))) return @"bool";
    if (!strcmp(cString, @encode(_Bool))) return @"_Bool";
    if (!strcmp(cString, @encode(void))) return @"void";
    if (!strcmp(cString, @encode(char *))) return @"char *";
    if (!strcmp(cString, @encode(id))) return @"id";
    if (!strcmp(cString, @encode(Class))) return @"class";
    if (!strcmp(cString, @encode(SEL))) return @"SEL";
    if (!strcmp(cString, @encode(BOOL))) return @"BOOL";

    NSString *result = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];

    if ([[result substringToIndex:1] isEqualToString:@"@"] && [result rangeOfString:@"?"].location == NSNotFound) {
        result = [[result substringWithRange:NSMakeRange(2, result.length - 3)] stringByAppendingString:@"*"];
    } else {
        if ([[result substringToIndex:1] isEqualToString:@"^"]) {
            result = [NSString stringWithFormat:@"%@ *",
                      [NSString decodeType:[[result substringFromIndex:1] cStringUsingEncoding:NSUTF8StringEncoding]]];
        }
    }
    return result;
}


/// 获取所有字体名称
-(NSArray *)clKitGetFamilyNames
{
    NSMutableArray *familyNamesArray = [NSMutableArray array];
    for(NSString *fontfamilyname in [UIFont familyNames])
       {
           [familyNamesArray addObject:fontfamilyname];
           for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
           {
               NSLog(@"\tfont:'%@'",fontName);
           }
       }
    return familyNamesArray;
}

/// 获取所有字体代号
-(NSArray *)clKitGetFontNames
{
    NSMutableArray *fontNamesArray = [NSMutableArray array];
    for(NSString *fontfamilyname in [UIFont familyNames])
       {
           for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
           {
               [fontNamesArray addObject:fontName];
           }
       }
    return fontNamesArray;
}
@end
