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

#import "UILabel+CLKit.h"
#import <CoreText/CoreText.h>

@implementation UILabel (CLKit)
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
                            lines:(NSInteger)lines
{
    return [self clKitCreateShadowColorLableWithFrame:frame text:text font:font color:color alignment:alignment lines:lines shadowColor:UIColor.clearColor];
}

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
                                      shadowColor:(UIColor *)colorShadow
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:font];
    [label setText:text];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:color];
    [label setShadowColor:colorShadow];
    [label setTextAlignment:alignment];
    [label setNumberOfLines:lines];

    return label;
}

/// 画一条带颜色的线
/// @param color 颜色值
+ (UILabel *)clKitCreateLineWithColor:(UIColor *)color
{
    UILabel *lb = [UILabel new];
    lb.backgroundColor = color;
    return lb;
}

/// 设置字间距
- (void)clKitSetColumnSpace:(CGFloat)columnSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

/// 设置行距
- (void)clKitSetRowSpace:(CGFloat)rowSpace
{
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

@end
