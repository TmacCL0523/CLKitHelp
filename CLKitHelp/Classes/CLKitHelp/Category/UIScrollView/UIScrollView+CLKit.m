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

#import "UIScrollView+CLKit.h"

@implementation UIScrollView (CLKit)

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
                                        delegate:(id<UIScrollViewDelegate>)delegate
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [scrollView setDelegate:delegate];
    [scrollView setPagingEnabled:pagingEnabled];
    [scrollView setClipsToBounds:clipsToBounds];
    [scrollView setShowsVerticalScrollIndicator:showScrollIndicators];
    [scrollView setShowsHorizontalScrollIndicator:showScrollIndicators];
    [scrollView setContentSize:contentSize];

    return scrollView;
}

/// 滚动到顶部
- (void)clKitScrollToTop
{
    [self clKitScrollToTopAnimated:YES];
}

/// 滚动到底部
- (void)clKitScrollToBottom
{
    [self clKitScrollToBottomAnimated:YES];
}

/// 滚动到左边
- (void)clKitScrollToLeft
{
    [self clKitScrollToLeftAnimated:YES];
}

/// 滚动到右边
- (void)clKitScrollToRight
{
    [self clKitScrollToRightAnimated:YES];
}

/// 滚动到顶部 - 动画
/// @param animated 是否开启动画
- (void)clKitScrollToTopAnimated:(BOOL)animated
{
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

/// 滚动到底部 - 动画
/// @param animated 是否开启动画
- (void)clKitScrollToBottomAnimated:(BOOL)animated
{
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

/// 滚动到左边 - 动画
/// @param animated 是否开启动画
- (void)clKitScrollToLeftAnimated:(BOOL)animated
{
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

/// 滚动到右边 - 动画
/// @param animated 是否开启动画
- (void)clKitScrollToRightAnimated:(BOOL)animated
{
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
