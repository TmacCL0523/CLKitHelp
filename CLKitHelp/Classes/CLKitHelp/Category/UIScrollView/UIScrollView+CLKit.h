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

@interface UIScrollView (CLKit)
/// 初始化
/// @param frame 坐标
/// @param contentSize 内容大小
/// @param clipsToBounds 剪切边界，默认NO
/// @param pagingEnabled 翻页 默认NO
/// @param showScrollIndicators 指标显示 默认YES
/// @param delegate 代理
+ (UIScrollView *)clKitCreateScrollViewWithFrame:(CGRect)frame
                                     contentSize:(CGSize)contentSize
                                   clipsToBounds:(BOOL)clipsToBounds
                                   pagingEnabled:(BOOL)pagingEnabled
                            showScrollIndicators:(BOOL)showScrollIndicators
                                        delegate:(id<UIScrollViewDelegate>)delegate;

/// 滚动到顶部
- (void)clKitScrollToTop;

/// 滚动到底部
- (void)clKitScrollToBottom;

/// 滚动到左边
- (void)clKitScrollToLeft;

/// 滚动到右边
- (void)clKitScrollToRight;

/// 滚动到顶部 - 动画
/// @param animated 是否开启动画
- (void)clKitScrollToTopAnimated:(BOOL)animated;

/// 滚动到底部 - 动画
/// @param animated 是否开启动画
- (void)clKitScrollToBottomAnimated:(BOOL)animated;

/// 滚动到左边 - 动画
/// @param animated 是否开启动画
- (void)clKitScrollToLeftAnimated:(BOOL)animated;

/// 滚动到右边 - 动画
/// @param animated 是否开启动画
- (void)clKitScrollToRightAnimated:(BOOL)animated;

@end
