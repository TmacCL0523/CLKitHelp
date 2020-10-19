/***

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

#import <UIKit/UIKit.h>

@interface UILabel (CLKit)

/// 快速创建lable
/// @param frame 大小
/// @param text 文本
/// @param font 字体
/// @param color 颜色
/// @param alignment 对齐模式
/// @param lines 行数
+ (UILabel *)clKitCreateWithFrame:(CGRect)frame
                             text:(NSString *)text
                             font:(UIFont *)font
                            color:(UIColor *)color
                        alignment:(NSTextAlignment)alignment
                            lines:(NSInteger)lines;

/// 快速创建带阴影
/// @param frame 带下
/// @param text 文本
/// @param font 字体
/// @param color 颜色
/// @param alignment 对齐
/// @param lines 行数
/// @param colorShadow 阴影
+ (UILabel *)clKitCreateShadowColorLableWithFrame:(CGRect)frame
                                             text:(NSString *)text
                                             font:(UIFont *)font
                                            color:(UIColor *)color
                                        alignment:(NSTextAlignment)alignment
                                            lines:(NSInteger)lines
                                      shadowColor:(UIColor *)colorShadow;

/// 画一条带颜色的线
/// @param color 颜色值
+ (UILabel *)clKitCreateLineWithColor:(UIColor *)color;

/// 设置字间距
- (void)clKitSetColumnSpace:(CGFloat)columnSpace;

/// 设置行距
- (void)clKitSetRowSpace:(CGFloat)rowSpace;

@end
