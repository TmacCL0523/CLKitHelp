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

#import "UIView+CLKit.h"
#import <objc/runtime.h>

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;

@implementation UIView (CLKit)
#pragma mark ================坐标属性=================
- (void)setClKitX:(CGFloat)clKitX
{
    CGRect frame = self.frame;
    frame.origin.x = clKitX;
    self.frame = frame;
}

- (CGFloat)clKitX {
    return self.frame.origin.x;
}

- (void)setClKitY:(CGFloat)clKitY
{
    CGRect frame = self.frame;
    frame.origin.y = clKitY;
    self.frame = frame;
}

- (CGFloat)clKitY
{
    return self.frame.origin.y;
}

- (void)setClKitWidth:(CGFloat)clKitWidth
{
    CGRect frame = self.frame;
    frame.size.width = clKitWidth;
    self.frame = frame;
}

- (CGFloat)clKitWidth
{
    return self.frame.size.width;
}

- (void)setClKitHeight:(CGFloat)clKitHeight
{
    CGRect frame = self.frame;
    frame.size.height = clKitHeight;
    self.frame = frame;
}

- (CGFloat)clKitHeight
{
    return self.frame.size.height;
}

- (void)setClKitCenterX:(CGFloat)clKitCenterX
{
    CGPoint point = self.center;
    point.x = clKitCenterX;
    self.center = point;
}

- (CGFloat)clKitCenterX
{
    return self.center.x;
}

- (void)setClKitCenterY:(CGFloat)clKitCenterY
{
    CGPoint point = self.center;
    point.y = clKitCenterY;
    self.center = point;
}

- (CGFloat)clKitCenterY
{
    return self.center.y;
}

- (void)setClKitSize:(CGSize)clKitSize
{
    CGRect frame = self.frame;
    frame.size = clKitSize;
    self.frame = frame;
}

- (CGSize)clKitSize
{
    return self.frame.size;
}

#pragma mark ================圆角属性=================

- (void)setClKitCornerRadius:(NSInteger)clKitCornerRadius
{
    self.layer.cornerRadius = clKitCornerRadius;
    self.layer.masksToBounds = clKitCornerRadius > 0;
}

- (NSInteger)clKitCornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setClKitMasksToBounds:(BOOL)clKitMasksToBounds
{
    self.layer.masksToBounds = clKitMasksToBounds;
}

- (BOOL)clKitMasksToBounds
{
    return self.layer.masksToBounds;
}

- (void)setClKitBorderWidth:(NSInteger)clKitBorderWidth
{
    self.layer.borderWidth = clKitBorderWidth;
}

- (NSInteger)clKitBorderWidth
{
    return self.layer.borderWidth;
}

- (void)setClKitBorderColor:(UIColor *)clKitBorderColor
{
    self.layer.borderColor = clKitBorderColor.CGColor;
}

- (UIColor *)clKitBorderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setClKitBorderHexRgb:(NSString *)clKitBorderHexRgb
{
    NSScanner *scanner = [NSScanner scannerWithString:clKitBorderHexRgb];
    unsigned hexNum;
    //这里是将16进制转化为10进制
    if (![scanner scanHexInt:&hexNum]) return;
    self.layer.borderColor = [self colorWithRGBHex:hexNum].CGColor;
}

- (NSString *)clKitBorderHexRgb
{
    return @"0xffffff";
}

#pragma mark ================Method - 方法=================
/// 截图
- (UIImage *)clKitSnapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);

    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return result;
}

/** 触发点击事件 */
- (void)clKitAddTapActionWithBlock:(CLKit_TapActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

/** 触发长按事件 */
- (void)clKitAddLongPressActionWithBlock:(CLKit_LongPressActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

/// 找到指定类名的subView
- (UIView *)clKitFindSubViewWithClass:(Class)clazz
{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:clazz]) {
            return subView;
        }
    }
    return nil;
}

/// 找到指定类名的所有subView
- (NSArray *)clKitFindAllSubViewsWithClass:(Class)clazz
{
    NSMutableArray *array = [NSMutableArray array];

    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:clazz]) {
            [array addObject:subView];
        }
    }
    return array;
}

/// 找到指定类名的superView对象
- (UIView *)clKitFindSuperViewWithClass:(Class)clazz
{
    if (self == nil) {
        return nil;
    } else if (self.superview == nil) {
        return nil;
    } else if ([self.superview isKindOfClass:clazz]) {
        return self.superview;
    } else {
        return [self.superview clKitFindSuperViewWithClass:clazz];
    }
}

/// 找到view上的第一响应者
- (UIView *)clKitFindFirstResponder
{
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder)) {
        return self;
    }

    for (UIView *v in self.subviews) {
        UIView *fv = [v clKitFindFirstResponder];
        if (fv) {
            return fv;
        }
    }

    return nil;
}

/// 找到当前view所在的viewcontroler
- (UIViewController *)clKitFindViewController
{
    UIResponder *responder = self.nextResponder;
    do{
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }while (responder);

    return nil;
}

/// 所有子View
- (NSArray *)clKitAllSubviews
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];

    [array addObjectsFromArray:self.subviews];

    for (UIView *view in self.subviews) {
        [array addObjectsFromArray:[view clKitAllSubviews]];
    }

    return array;
}

/// 移除所有子视图
- (void)clKitRemoveAllSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

/// 添加view数组
- (void)clKitAddSubViews:(NSArray<UIView *> *)views
{
    [views enumerateObjectsUsingBlock:^(UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [self addSubview:obj];
    }];
}

/// 创建边框
/// @param color 颜色
/// @param radius 半径
/// @param width 宽度
- (void)clKitSetBordersWithColor:(UIColor *)color andCornerRadius:(CGFloat)radius andWidth:(CGFloat)width
{
    // 设置边框宽度
    self.layer.borderWidth = width;
    // 设置圆角半径
    self.layer.cornerRadius = radius;
    // 设置是否栅格化
    self.layer.shouldRasterize = NO;
    // 设置栅格化规模
    self.layer.rasterizationScale = 2;
    // 设置边缘抗锯齿遮盖
    self.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
    // 设置边界剪切
    self.clipsToBounds = YES;
    // 设置边界是否遮盖
    self.layer.masksToBounds = YES;

    // 创建颜色空间
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGColorRef cgColor = [color CGColor];
    self.layer.borderColor = cgColor;
    CGColorSpaceRelease(space);
}

/// 删除边框
- (void)clKitRemoveBorders
{
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = 0;
    self.layer.borderColor = nil;
}

/// 创建阴影
/// @param offset 阴影偏移量
/// @param opacity 透明度
/// @param radius 模糊程度
- (void)clKitSetRectShadowWithOffset:(CGSize)offset
                             opacity:(CGFloat)opacity
                              radius:(CGFloat)radius
{
    // 设置阴影的颜色
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的透明度
    self.layer.shadowOpacity = opacity;
    // 设置阴影的偏移量
    self.layer.shadowOffset = offset;
    // 设置阴影的模糊程度
    self.layer.shadowRadius = radius;
    // 设置边界是否遮盖
    self.layer.masksToBounds = NO;
}

/// 创建圆角半径阴影
/// @param cornerRadius 圆角半径
/// @param offset 偏移量
/// @param opacity 透明度
/// @param radius 模糊程度
- (void)clKitSetCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius
                                            offset:(CGSize)offset
                                           opacity:(CGFloat)opacity
                                            radius:(CGFloat)radius
{
    // 设置阴影的颜色
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的透明度
    self.layer.shadowOpacity = opacity;
    // 设置阴影的偏移量
    self.layer.shadowOffset = offset;
    // 设置阴影的模糊程度
    self.layer.shadowRadius = radius;
    // 设置是否栅格化
    self.layer.shouldRasterize = YES;
    // 设置圆角半径
    self.layer.cornerRadius = cornerRadius;
    // 设置阴影的路径
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds]
                                                        cornerRadius:cornerRadius] CGPath];
    // 设置边界是否遮盖
    self.layer.masksToBounds = NO;
}

/// 摇摆动画
- (void)clKitShakeAnimation
{
    // 创建关键帧动画类
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    // 设置每个关键帧的值对象的数组
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)],
                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    // 设置是否自动翻转
    shake.autoreverses = YES;
    // 设置重复次数
    shake.repeatCount = 2.0f;
    // 设置间隔时间
    shake.duration = 0.07f;
    // 添加动画
    [self.layer addAnimation:shake
                      forKey:@"Shake"];
}

/// 脉冲动画
- (void)clKitPulseViewWithTime:(CGFloat)seconds
{
    [self pulseViewWithDuration:seconds];
}

#pragma mark ================私有方法=================
- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;

    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        CLKit_TapActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)handleActionForLongPressGesture:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        CLKit_LongPressActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

/// 脉冲动画
/// @param duration 动画时间
- (void)pulseViewWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration / 6 animations:^{
        [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:duration / 6 animations:^{
                [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:duration / 6 animations:^{
                        [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:duration / 6 animations:^{
                                [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    [UIView animateWithDuration:duration / 6 animations:^{
                                        [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
                                    } completion:^(BOOL finished) {
                                        if (finished) {
                                            [UIView animateWithDuration:duration / 6 animations:^{
                                                [self setTransform:CGAffineTransformMakeScale(1, 1)];
                                            } completion:nil];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

@end
