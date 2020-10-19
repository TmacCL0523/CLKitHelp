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

#import "NSArray+CLKit.h"

@implementation NSArray (CLKit)

/// 获取在安全模式下给定索引的对象（如果自身是空的则无）
/// @param index 索引
- (id _Nullable)clKitSafeObjectAtIndex:(NSUInteger)index
{
    if ([self count] > 0 && [self count] > index) {
        return [self objectAtIndex:index];
    }
    return nil;
}

/// 创建反向数组
- (NSArray *_Nullable)clKitReversedArray
{
    return [NSArray clKitReversedArray:self];
}

/// 转换成JSON的NSString
- (NSString *_Nullable)clKitArrayToJson
{
    return [NSArray clKitArrayToJson:self];
}

/// 模拟阵列当作一个圆。当它超出范围，重新开始
/// @param index 索引
- (id _Nonnull)clKitObjectAtCircleIndex:(NSInteger)index
{
    return [self objectAtIndex:[self superCircle:index
                                         maxSize:self.count]];
}

/// 将指定的数组创建反向数组
/// @param array 数组
+ (NSArray *_Nullable)clKitReversedArray:(NSArray *_Nullable)array
{
    // 从一个阵列容量初始化阵列
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    // 获取NSArray的逆序枚举器
    NSEnumerator *enumerator = [array reverseObjectEnumerator];

    for (id element in enumerator) {
        [arrayTemp addObject:element];
    }
    return arrayTemp;
}

/// 将指定的数组转换成JSON的NSString
/// @param array 数组
+ (NSString *_Nullable)clKitArrayToJson:(NSArray *_Nullable)array
{
    NSString *json = nil;
    NSError *error = nil;
    // 生成一个Foundation对象JSON数据
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:0
                                                     error:&error];
    if (!error) {
        json = [[NSString alloc] initWithData:data
                                     encoding:NSUTF8StringEncoding];
        return json;
    } else
        // 返回主用户显示消息的错误
        return error.localizedDescription;
}

#pragma mark ================私有方法=================
/* 当索引超出范围，重新设定索引 */
- (NSInteger)superCircle:(NSInteger)index
                 maxSize:(NSInteger)maxSize
{
    if (index < 0) {
        index = index % maxSize;
        index += maxSize;
    }
    if (index >= maxSize) {
        index = index % maxSize;
    }
    return index;
}

@end

@implementation NSMutableArray (CLKit)

/// 获取在安全模式下给定索引的对象（如果自身是空的则无）
/// @param index 设定的索引
- (id _Nullable)clKitSafeObjectAtIndex:(NSUInteger)index
{
    if ([self count] > 0 && [self count] > index) {
        return [self objectAtIndex:index];
    }

    return nil;
}

/// 移动对象从一个索引到另一个索引
/// @param from 源索引
/// @param to 目标索引
- (void)clKitMoveObjectFromIndex:(NSUInteger)from
                    toIndex:(NSUInteger)to
{
    if (to != from) {
        id obj = [self clKitSafeObjectAtIndex:from];
        // 删除集合指定的元素
        [self removeObjectAtIndex:from];

        if (to >= [self count])
            // 向集合添加元素
            [self addObject:obj];
        else
            // 向集合的指定位置插入一个元素
            [self insertObject:obj
                       atIndex:to];
    }
}

/// 创建反向数组
- (NSMutableArray *_Nullable)clKitReversedArray
{
    return [[NSArray clKitReversedArray:self] mutableCopy];
}

/// 获取给定的键值和排序的数组
/// @param key 键值
/// @param array 指定的集合
/// @param ascending YES为升序，NO为降序
+ (NSMutableArray *_Nullable)clKitSortArrayByKey:(NSString *_Nullable)key
                                      array:(NSMutableArray *_Nullable)array
                                  ascending:(BOOL)ascending
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    // 集合移除全部对象
    [tempArray removeAllObjects];
    // 向集合尾部添加指定集合
    [tempArray addObjectsFromArray:array];
    // 初始化一个指定键值和排序的排序描述器
    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:brandDescriptor, nil];
    // 通过排序接收机对象返回一个新的数组
    NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:sortDescriptors];
    [tempArray removeAllObjects];
    tempArray = (NSMutableArray *)sortedArray;
    [array removeAllObjects];
    [array addObjectsFromArray:tempArray];

    return array;
}

@end
