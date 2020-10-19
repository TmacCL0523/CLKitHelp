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

@interface UITableView (CLKit)

/// 初始化tableview
/// @param frame 大小
/// @param style 样式      UITableViewStylePlain,       UITableViewStyleGrouped(组）
/// @param cellSeparatorStyle 分割线样式
/// @param dataSource 数据源代理
/// @param delegate 代理
+ (UITableView *)clKitCreateTableViewWithFrame:(CGRect)frame
                                         style:(UITableViewStyle)style
                            cellSeparatorStyle:(UITableViewCellSeparatorStyle)cellSeparatorStyle
                                    dataSource:(id <UITableViewDataSource>)dataSource
                                      delegate:(id <UITableViewDelegate>)delegate;

/// 更新tableview
/// @param block 回调
- (void)clKitUpdateWithBlock:(void (^)(UITableView *tableView))block;



//TODO: ---------- Section && Row ----------

/// 滑动
/// @param row 个数
/// @param section 组数
/// @param scrollPosition 动画效果
/// @param animated 是否动画
- (void)clKitScrollToRow:(NSUInteger)row
               inSection:(NSUInteger)section
        atScrollPosition:(UITableViewScrollPosition)scrollPosition
                animated:(BOOL)animated;

/// 插入
/// @param row 下标位置
/// @param section 组下标
/// @param animation 动画效果
- (void)clKitInsertRow:(NSUInteger)row
             inSection:(NSUInteger)section
      withRowAnimation:(UITableViewRowAnimation)animation;

/// 刷新
/// @param row 下标位置
/// @param section 组下标位置
/// @param animation 动画效果
- (void)clKitReloadRow:(NSUInteger)row
             inSection:(NSUInteger)section
      withRowAnimation:(UITableViewRowAnimation)animation;

/// 删除
/// @param row 下标
/// @param section 组下标
/// @param animation 动画效果
- (void)clKitDeleteRow:(NSUInteger)row
             inSection:(NSUInteger)section
      withRowAnimation:(UITableViewRowAnimation)animation;



//TODO: ----------Row----------

/// 插入  indexPath
/// @param indexPath 下标元素
/// @param animation 动画效果
- (void)clKitInsertRowAtIndexPath:(NSIndexPath *)indexPath
                 withRowAnimation:(UITableViewRowAnimation)animation;

/// 刷新  indexPath
/// @param indexPath 下标元素
/// @param animation 动画效果
- (void)clKitReloadRowAtIndexPath:(NSIndexPath *)indexPath
                 withRowAnimation:(UITableViewRowAnimation)animation;

/// 删除  indexPath
/// @param indexPath 下标元素
/// @param animation 动画效果
- (void)clKitDeleteRowAtIndexPath:(NSIndexPath *)indexPath
                 withRowAnimation:(UITableViewRowAnimation)animation;



//TODO: ----------Section----------

/// 插入  section
/// @param section 组元素
/// @param animation 动画效果
- (void)clKitInsertSection:(NSUInteger)section
          withRowAnimation:(UITableViewRowAnimation)animation;

/// 删除  section
/// @param section 组元素
/// @param animation 动画效果
- (void)clKitDeleteSection:(NSUInteger)section
          withRowAnimation:(UITableViewRowAnimation)animation;

/// 刷新  section
/// @param section 组元素
/// @param animation 动画效果
- (void)clKitReloadSection:(NSUInteger)section
          withRowAnimation:(UITableViewRowAnimation)animation;

/// 清楚选中动画
/// @param animated YES NO
- (void)clKitClearSelectedRowsAnimated:(BOOL)animated;

@end
