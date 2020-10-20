/***

    当前的文件名
    NSArray+CLKit.h

    不带后缀的文件名
    NSArray+CLKit.h

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

@interface NSArray (CLKit)

/// 获取在安全模式下给定索引的对象（如果自身是空的则无）
/// @param index 索引
- (id _Nullable)clKitSafeObjectAtIndex:(NSUInteger)index;

/// 创建反向数组
- (NSArray *_Nullable)clKitReversedArray;

/// 转换成JSON的NSString
- (NSString *_Nullable)clKitArrayToJson;

/// 模拟阵列当作一个圆。当它超出范围，重新开始
/// @param index 索引
- (id _Nonnull)clKitObjectAtCircleIndex:(NSInteger)index;

/// 将指定的数组创建反向数组
/// @param array 数组
+ (NSArray *_Nullable)clKitReversedArray:(NSArray *_Nullable)array;

/// 将指定的数组转换成JSON的NSString
/// @param array 数组
+ (NSString *_Nullable)clKitArrayToJson:(NSArray *_Nullable)array;

@end

@interface NSMutableArray (CLKit)

/// 获取在安全模式下给定索引的对象（如果自身是空的则无）
/// @param index 设定的索引
- (id _Nullable)clKitSafeObjectAtIndex:(NSUInteger)index;

/// 移动对象从一个索引到另一个索引
/// @param from 源索引
/// @param to 目标索引
- (void)clKitMoveObjectFromIndex:(NSUInteger)from
                    toIndex:(NSUInteger)to;

/// 创建反向数组
- (NSMutableArray *_Nullable)clKitReversedArray;

/// 获取给定的键值和排序的数组
/// @param key 键值
/// @param array 指定的集合
/// @param ascending YES为升序，NO为降序
+ (NSMutableArray *_Nullable)clKitSortArrayByKey:(NSString *_Nullable)key
                                      array:(NSMutableArray *_Nullable)array
                                  ascending:(BOOL)ascending;
@end
