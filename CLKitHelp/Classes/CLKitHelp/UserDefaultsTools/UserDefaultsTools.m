/**
 *********************************************************************************
 *
 * 用户名:     QiYue
 * 文件名:     UserDefaultsTools.m
 * 工程名:     Pods
 * 父类:       NSObject
 * 创建时间:    2020/12/4
 *
 *********************************************************************************
 **/


#import "UserDefaultsTools.h"
#import <YYModel/YYModel.h>


#ifdef DEBUG
#define CLLog(...)                 printf("%s [第%d行]: %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define CLLog(...)
#endif

#define NSStringFormat(format, ...) [NSString stringWithFormat:format, ## __VA_ARGS__]

@implementation UserDefaultsTools


/// 存储
/// @param value 对象
/// @param key 键值
+ (void)saveClass:(id)value forKey:(NSString *)key
{
    NSDictionary *dict = [value yy_modelToJSONObject];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];
}


/// 根据key取出对象
/// @param key 键值
+ (id)classValueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:key];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return dict;
}

/// 存储
/// @param value 对象
/// @param key 键值
+ (void)saveValue:(NSString *)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:value forKey:key];
    [userDefaults synchronize];
}


/// 根据key取出对象
/// @param key 键值
+ (NSString *)valueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:key];

}

/// 根据键值判断是否BOOL
/// @param key 键值
+ (BOOL)boolValueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}

/// 保存BOOL
/// @param value BOOL对象
/// @param key 键值
+ (void)saveBoolValue:(BOOL)value withKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

/// 根据键值删除对象
/// @param key 键值
+ (void)removeValueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
}

/// 打印所有
+ (void)logAllObject
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    CLLog(@"%@", dic);
}


@end
