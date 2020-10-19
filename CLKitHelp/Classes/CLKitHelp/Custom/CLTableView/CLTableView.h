/***

    当前的文件名
    CLTableView.h

    不带后缀的文件名
    CLTableView

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

typedef void (^mjheaderBlock) (void);
typedef void (^mjfooterBlock) (void);

#pragma mark ================Protocols-代理/协议=================

@interface CLTableView : UITableView

#pragma mark ================Property-属性=================

/// 数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

/// Row高度
@property (nonatomic, assign) CGFloat baseRowHeight;

/// Header 高度
@property (nonatomic, assign) CGFloat baseSectionHeaderHeight;

/// footer高度
@property (nonatomic, assign) CGFloat baseSectionFooterHeight;
// UITableViewDataSource

/// section 数量
@property (nonatomic, copy) NSInteger (^ numberOfSectionsInTableViewBlock)(UITableView *tableView);

/// row 数量
@property (nonatomic, copy) NSInteger (^ numberOfRowsInSectionBlock)(UITableView *tableView, NSInteger section);

/// cell 回调
@property (nonatomic, copy) UITableViewCell * (^ cellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);

/// Header View
@property (nonatomic, copy) UIView * (^ viewForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);

/// Footer View
@property (nonatomic, copy) UIView * (^ viewForFooterInSectionBlock)(UITableView *tableView, NSInteger section);

/// row 高度
@property (nonatomic, copy) CGFloat (^ heightForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);

/// Header 高度
@property (nonatomic, copy) CGFloat (^ heightForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);

/// Footer 高度
@property (nonatomic, copy) CGFloat (^ heightForFooterInSectionBlock)(UITableView *tableView, NSInteger section);

/// Cell 点击
@property (nonatomic, copy) void (^ didSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);

/// Cell 未点击
@property (nonatomic, copy) void (^ didDeselectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);

/// 空数据 - 标题
@property (nonatomic, copy) NSAttributedString * (^ emptyViewTitleBlock)(void);

/// 空数据 - 详情
@property (nonatomic, copy) NSAttributedString * (^ emptiyViewSubTitleBlock)(void);

/// 空数据 - 占位图
@property (nonatomic, copy) UIImage * (^ emptiyViewIconBlock)(void);

/// 空数据 - 背景颜色
@property (nonatomic, copy) UIColor * (^ emtiyViewBackgroundColorBlock)(void);

/// 空数据 - 自定义View
@property (nonatomic, copy) UIView * (^ emptiyViewCustomView)(void);

#pragma mark ================Methods-方法=================

/// 添加-上拉刷新
/// @param block 回调
- (void)addMJHeader:(mjheaderBlock)block;

/// 添加-加载更多
/// @param block 回调
- (void)addMJFooter:(mjfooterBlock)block;

/// 结束所有刷新
- (void)endMJRefresh;

/// 没有更多数据
- (void)notMoreData;

/// 刷新
- (void)baseReloadData;

/// 更多数据
/// @param array 数据模型
- (void)setTableViewData:(NSArray *)array;

/// 插入数据
/// @param array 数据模型
- (void)insetDataForTableView:(NSArray *)array;

/// 空数据 - 开关
/// @param isEmptiy 是否开启代理
- (void)openEmptiyDataSet:(BOOL)isEmptiy;

@end
