/***

    当前的文件名
    UIView+CLKit.h

    不带后缀的文件名
    UIView+CLKit.h

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

typedef void (^CLKit_TapActionBlock)(UITapGestureRecognizer *gestureRecoginzer);
typedef void (^CLKit_LongPressActionBlock)(UILongPressGestureRecognizer *gestureRecoginzer);
@interface UIView (CLKit)

#pragma mark ===================Property - 属性===================
/// X坐标
@property (nonatomic, assign) CGFloat clKitX;

/// Y坐标
@property (nonatomic, assign) CGFloat clKitY;

/// 宽
@property (nonatomic, assign) CGFloat clKitWidth;

/// 高
@property (nonatomic, assign) CGFloat clKitHeight;

/// 大小
@property (nonatomic, assign) CGSize clKitSize;

/// 中心X坐标
@property (nonatomic, assign) CGFloat clKitCenterX;

/// 中心Y坐标
@property (nonatomic, assign) CGFloat clKitCenterY;

/// 圆角角度
@property (assign, nonatomic) IBInspectable NSInteger clKitCornerRadius;

/// 是否可以设置圆角
@property (assign, nonatomic) IBInspectable BOOL clKitMasksToBounds;

/// 边框宽度
@property (assign, nonatomic) IBInspectable NSInteger clKitBorderWidth;

/// 边框颜色
@property (strong, nonatomic) IBInspectable NSString *clKitBorderHexRgb;

/// 边框颜色
@property (strong, nonatomic) IBInspectable UIColor *clKitBorderColor;
#pragma mark ===================Method - 方法===================
/// 截图
- (UIImage *)clKitSnapshotImage;

/// 点击事件
/// @param block 回调
- (void)clKitAddTapActionWithBlock:(CLKit_TapActionBlock)block;

/// 长按事件
/// @param block 回调
- (void)clKitAddLongPressActionWithBlock:(CLKit_LongPressActionBlock)block;

/// 找到指定类名的subView
/// @param clazz view名
- (UIView *)clKitFindSubViewWithClass:(Class)clazz;

///  找到指定类名的所有subView
/// @param clazz view名
- (NSArray *)clKitFindAllSubViewsWithClass:(Class)clazz;

/// 找到指定类名的superView对象
/// @param clazz 类名
- (UIView *)clKitFindSuperViewWithClass:(Class)clazz;

/// 找到view上的第一响应者
- (UIView *)clKitFindFirstResponder;

/// 找到当前view所在的viewcontroler
- (UIViewController *)clKitFindViewController;

/// 所有子View
- (NSArray *)clKitAllSubviews;

/// 移除所有子视图
- (void)clKitRemoveAllSubviews;

/// 添加数组View
/// @param views 数组view
- (void)clKitAddSubViews:(NSArray<UIView *> *)views;

/// 创建边框
/// @param color 颜色
/// @param radius 半径
/// @param width 宽度
- (void)clKitSetBordersWithColor:(UIColor *)color
                 andCornerRadius:(CGFloat)radius
                        andWidth:(CGFloat)width;

/// 删除边框
- (void)clKitRemoveBorders;

/// 创建阴影
/// @param offset 阴影偏移量
/// @param opacity 透明度
/// @param radius 模糊程度
- (void)clKitSetRectShadowWithOffset:(CGSize)offset
                             opacity:(CGFloat)opacity
                              radius:(CGFloat)radius;

/// 创建圆角半径阴影
/// @param cornerRadius 圆角半径
/// @param offset 偏移量
/// @param opacity 透明度
/// @param radius 模糊程度
- (void)clKitSetCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius
                                            offset:(CGSize)offset
                                           opacity:(CGFloat)opacity
                                            radius:(CGFloat)radius;
/// 摇摆动画
- (void)clKitShakeAnimation;

@end
