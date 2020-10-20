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

#import "UIColor+CLKit.h"

@implementation UIColor (CLKit)

/// 适配黑暗模式
/// @param lightColor 正常模式颜色
/// @param darkColor 黑暗模式颜色
+ (UIColor *)clKitLightColor:(UIColor *)lightColor
                   darkColor:(UIColor *)darkColor;
{
    if (@available(iOS 13,*)) {
        if (darkColor) {
            UIColor *separateColor = [UIColor colorWithDynamicProvider:^UIColor *_Nonnull (UITraitCollection *_Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return darkColor;
                } else {
                    return lightColor;
                }
            }];
            return separateColor;
        } else {
            return lightColor;
        }
    } else {
        return lightColor;
    }
}

@end
