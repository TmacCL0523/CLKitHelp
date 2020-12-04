/**
 *********************************************************************************
 *
 * 用户名:     QiYue
 * 文件名:     UserDefaultsTools.h
 * 工程名:     Pods
 * 父类:       NSObject
 * 创建时间:    2020/12/4
 *
 *********************************************************************************
 **/


#import <Foundation/Foundation.h>


@interface UserDefaultsTools : NSObject

//TODO: 对象存储
/// 存储
/// @param value 对象
/// @param key 键值
+ (void)saveClass:(id)value forKey:(NSString *)key;


/// 根据key取出对象
/// @param key 键值
+ (id)classValueWithKey:(NSString *)key;


//TODO: 字符串存储
/// 存储
/// @param value 对象
/// @param key 键值
+ (void)saveValue:(NSString *)value forKey:(NSString *)key;


/// 根据key取出对象
/// @param key 键值
+ (NSString *)valueWithKey:(NSString *)key;

/// 根据键值判断是否BOOL
/// @param key 键值
+ (BOOL)boolValueWithKey:(NSString *)key;

/// 保存BOOL
/// @param value BOOL对象
/// @param key 键值
+ (void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

/// 根据键值删除对象
/// @param key 键值
+ (void)removeValueWithKey:(NSString *)key;

/// 打印所有
+ (void)logAllObject;

@end
