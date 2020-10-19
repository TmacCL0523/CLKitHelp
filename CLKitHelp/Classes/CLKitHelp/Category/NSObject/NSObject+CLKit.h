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

#import <Foundation/Foundation.h>


@interface NSObject (CLKit)
/** 版本号 */
+ (NSString *)clKitVersion;

/** build号 */
+ (NSInteger)clKitBuild;

/** Bundle id */
+ (NSString *)clKitIdentifier;

/** 语言 */
+ (NSString *)clKitCurrentLanguage;

/** 架构 */
+ (NSString *)clKitDeviceModel;

/** 类名 */
- (NSString *)clKitClassName;

/** 类名 */
+ (NSString *)clKitClassName;

/** 父类名 */
- (NSString *)clKitSuperClassName;

/** 父类名 */
+ (NSString *)clKitSuperClassName;

/** 实例属性字典 */
- (NSDictionary *)clKitPropertyDictionary;

/** 属性名称列表 */
- (NSArray *)clKitPropertyKeys;

/** 属性名称列表 */
+ (NSArray *)clKitPropertyKeys;

/** 方法列表 */
- (NSArray *)clKitMethodList;

/** 方法列表 */
+ (NSArray *)clKitMethodList;

/** 格式化方法列表 */
- (NSArray *)clKitMethodListInfo;

/** 创建并返回一个指向所有已注册类的指针列表 */
+ (NSArray *)clKitRegistedClassList;

/** 实例变量 */
+ (NSArray *)clKitInstanceVariable;

/** 是否包含某个属性 */
- (BOOL)clKitHasPropertyForKey:(NSString *)key;

/** 是否包含某个实例变量 */
- (BOOL)clKitHasIvarForKey:(NSString *)key;


/// 获取所有字体名称
/***/
-(NSArray *)clKitGetFamilyNames;

/// 获取所有字体代号
-(NSArray *)clKitGetFontNames;
@end

