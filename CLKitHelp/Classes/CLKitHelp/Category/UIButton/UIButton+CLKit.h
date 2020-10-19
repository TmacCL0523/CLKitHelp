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

typedef enum : NSUInteger {
    ButtonImageLocationTop,    //图片在上面
    ButtonImageLocationLeft,   //图片在左边
    ButtonImageLocationBottom, //图片在底部
    ButtonImageLocationRight   //图片在右边
} ButtonImageLocation;

typedef void (^TouchedButtonBlock)(void);

@interface UIButton (CLKit)
#pragma mark ================属性=================
/** 改变按钮的响应区域,上左下右分别增加或减小多少 正数为增加 负数为减小 */
@property (nonatomic, assign) UIEdgeInsets clKitEdgeInsets;

/** 角标 */
@property (strong, nonatomic) UILabel *badge;

/** 角标的值 */
@property (nonatomic) NSString *badgeValue;

/** 角标背景颜色 */
@property (nonatomic) UIColor *badgeBGColor;

/** 角标文字颜色 */
@property (nonatomic) UIColor *badgeTextColor;

/** 角标文字的字体 */
@property (nonatomic) UIFont *badgeFont;

/** 角标边距 */
@property (nonatomic) CGFloat badgePadding;

/** 角标最小的大小 */
@property (nonatomic) CGFloat badgeMinSize;

/** 角标x坐标 */
@property (nonatomic) CGFloat badgeOriginX;

/** 角标y坐标 */
@property (nonatomic) CGFloat badgeOriginY;

/** 如果是数字0的话就隐藏角标不显示 */
@property BOOL shouldHideBadgeAtZero;

/** 显示角标是否要缩放动画 */
@property BOOL shouldAnimateBadge;
#pragma mark ================Method - 方法=================

/// 快速创建按钮
/// @param title 文本
/// @param backColor 背景颜色
/// @param nonarlImage 图片
/// @param selectImage 点击图片
/// @param color 字体颜色
/// @param font 字体
/// @param cornerRadius 圆角半径
+ (instancetype)clKitButtonWithTitle:(NSString *)title
                            backColor:(UIColor *)backColor
                          nonarlImage:(UIImage *)nonarlImage
                          selectImage:(UIImage *)selectImage
                           titleColor:(UIColor *)color
                                 font:(UIFont *)font
                         cornerRadius:(CGFloat)cornerRadius;

/// 快速创建title按钮
/// @param title 文本
/// @param backColor 背景颜色
/// @param color 字体颜色
/// @param font 字体
/// @param cornerRadius 圆角半径
+ (instancetype)clKitButtonWithTitle:(NSString *)title
                            backColor:(UIColor *)backColor
                           titleColor:(UIColor *)color
                                 font:(UIFont *)font
                         cornerRadius:(CGFloat)cornerRadius;

/// 快速创建图片按钮
/// @param nonarlImage 图片
/// @param selectImage 选中图片
/// @param cornerRadius 圆角半径
+ (instancetype)clKitButtonWithImage:(UIImage *)nonarlImage
                          selectImage:(UIImage *)selectImage
                         cornerRadius:(CGFloat)cornerRadius;

/// 多久之后开始执行
/// @param timeout 多少秒
/// @param waitBlock 倒计时
/// @param finishBlock 倒计时结束时回调
- (void)clKitStartTime:(NSInteger)timeout
              waitBlock:(void (^)(NSInteger remainTime))waitBlock
            finishBlock:(void (^)(void))finishBlock;

/// 添加点击事件
/// @param touchHandler 回调
- (void)clKitAddActionHandler:(TouchedButtonBlock)touchHandler;

/// 显示菊花
- (void)clKitShowIndicator;

/// 隐藏菊花
- (void)clKitHideIndicator;
@end

