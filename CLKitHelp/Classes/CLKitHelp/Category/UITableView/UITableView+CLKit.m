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

#import "UITableView+CLKit.h"

@implementation UITableView (CLKit)

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
                                      delegate:(id <UITableViewDelegate>)delegate
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.separatorStyle = cellSeparatorStyle;
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;

    return tableView;
}

/// 更新tableview
/// @param block 回调
- (void)clKitUpdateWithBlock:(void (^)(UITableView *tableView))block
{
    [self beginUpdates];
    block(self);
    [self endUpdates];
}

//TODO: ---------- Section && Row ----------

/// 滑动
/// @param row 个数
/// @param section 组数
/// @param scrollPosition 动画效果
/// @param animated 是否动画
- (void)clKitScrollToRow:(NSUInteger)row
               inSection:(NSUInteger)section
        atScrollPosition:(UITableViewScrollPosition)scrollPosition
                animated:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}

/// 插入
/// @param row 下标位置
/// @param section 组下标
/// @param animation 动画效果
- (void)clKitInsertRow:(NSUInteger)row
             inSection:(NSUInteger)section
      withRowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *toInsert = [NSIndexPath indexPathForRow:row inSection:section];
    [self clKitInsertRowAtIndexPath:toInsert withRowAnimation:animation];
}

/// 刷新
/// @param row 下标位置
/// @param section 组下标位置
/// @param animation 动画效果
- (void)clKitReloadRow:(NSUInteger)row
             inSection:(NSUInteger)section
      withRowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *toReload = [NSIndexPath indexPathForRow:row inSection:section];
    [self clKitReloadRowAtIndexPath:toReload withRowAnimation:animation];
}

/// 删除
/// @param row 下标
/// @param section 组下标
/// @param animation 动画效果
- (void)clKitDeleteRow:(NSUInteger)row
             inSection:(NSUInteger)section
      withRowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *toDelete = [NSIndexPath indexPathForRow:row inSection:section];
    [self clKitDeleteRowAtIndexPath:toDelete withRowAnimation:animation];
}

//TODO: ----------Row----------

/// 插入  indexPath
/// @param indexPath 下标元素
/// @param animation 动画效果
- (void)clKitInsertRowAtIndexPath:(NSIndexPath *)indexPath
                 withRowAnimation:(UITableViewRowAnimation)animation
{
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

/// 刷新  indexPath
/// @param indexPath 下标元素
/// @param animation 动画效果
- (void)clKitReloadRowAtIndexPath:(NSIndexPath *)indexPath
                 withRowAnimation:(UITableViewRowAnimation)animation
{
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

/// 删除  indexPath
/// @param indexPath 下标元素
/// @param animation 动画效果
- (void)clKitDeleteRowAtIndexPath:(NSIndexPath *)indexPath
                 withRowAnimation:(UITableViewRowAnimation)animation
{
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

//TODO: ----------Section----------

/// 插入  section
/// @param section 组元素
/// @param animation 动画效果
- (void)clKitInsertSection:(NSUInteger)section
          withRowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self insertSections:sections withRowAnimation:animation];
}

/// 删除  section
/// @param section 组元素
/// @param animation 动画效果
- (void)clKitDeleteSection:(NSUInteger)section
          withRowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self deleteSections:sections withRowAnimation:animation];
}

/// 刷新  section
/// @param section 组元素
/// @param animation 动画效果
- (void)clKitReloadSection:(NSUInteger)section
          withRowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:animation];
}

/// 清楚选中动画
/// @param animated YES NO
- (void)clKitClearSelectedRowsAnimated:(BOOL)animated
{
    NSArray *indexs = [self indexPathsForSelectedRows];
    [indexs enumerateObjectsUsingBlock:^(NSIndexPath *path, NSUInteger idx, BOOL *stop) {
        [self deselectRowAtIndexPath:path animated:animated];
    }];
}

@end
