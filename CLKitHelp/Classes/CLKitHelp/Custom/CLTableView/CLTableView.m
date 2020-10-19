/***

    当前的文件名
    CLTableView.m

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

#import "CLTableView.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MJRefresh.h"

@interface CLTableView ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation CLTableView

#pragma mark ================Object - 对象=================
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

#pragma mark ================Initialize-初始化=================
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initWithConfig];
}

#pragma mark ================Delegate - 代理=================
 #pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.numberOfSectionsInTableViewBlock) {
        return self.numberOfSectionsInTableViewBlock(tableView);
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.numberOfRowsInSectionBlock) {
        return self.numberOfRowsInSectionBlock(tableView, section);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellForRowAtIndexPathBlock) {
        return self.cellForRowAtIndexPathBlock(tableView, indexPath);
    }
    return nil;
}

#pragma mark UITableViewDelegate
#pragma mark UITableViewDelegate -- Section header & footer
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.viewForHeaderInSectionBlock) {
        return self.viewForHeaderInSectionBlock(tableView, section);
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.viewForFooterInSectionBlock) {
        return self.viewForFooterInSectionBlock(tableView, section);
    }
    return [UIView new];
}

#pragma mark UITableViewDelegate -- Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.heightForRowAtIndexPathBlock) {
        return self.heightForRowAtIndexPathBlock(tableView, indexPath);
    }
    if (self.baseRowHeight) {
        return self.baseRowHeight;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.heightForHeaderInSectionBlock) {
        return self.heightForHeaderInSectionBlock(tableView, section);
    }
    if (self.baseSectionHeaderHeight) {
        return self.baseSectionHeaderHeight;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.heightForFooterInSectionBlock) {
        return self.heightForFooterInSectionBlock(tableView, section);
    }
    if (self.baseSectionFooterHeight) {
        return self.baseSectionFooterHeight;
    }
    return CGFLOAT_MIN;
}

#pragma mark UITableViewDelegate -- The user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectRowAtIndexPathBlock) {
        self.didSelectRowAtIndexPathBlock(tableView, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didDeselectRowAtIndexPathBlock) {
        self.didDeselectRowAtIndexPathBlock(tableView, indexPath);
    }
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.emptyViewTitleBlock) {
        return self.emptyViewTitleBlock();
    }
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.emptiyViewSubTitleBlock) {
        return self.emptiyViewSubTitleBlock();
    }
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.emptiyViewIconBlock) {
        return self.emptiyViewIconBlock();
    }
    return nil;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.emtiyViewBackgroundColorBlock) {
        return self.emtiyViewBackgroundColorBlock();
    }
    return nil;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.emptiyViewCustomView) {
        return self.emptiyViewCustomView();
    }
    return nil;
}

#pragma mark ================Methods - 方法=================
///添加MJHeader
- (void)addMJHeader:(mjheaderBlock)block
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        block();
    }];
    [self.mj_header beginRefreshing];
}

///添加MJFooter
- (void)addMJFooter:(mjfooterBlock)block
{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        block();
    }];
}

//结束刷新
- (void)endMJRefresh
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)notMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}

//数据
- (void)setTableViewData:(NSArray *)array
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    [self reloadData];
}

- (void)insetDataForTableView:(NSArray *)array
{
    NSMutableArray *insetList = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx + self.dataArray.count inSection:0];
        [insetList addObject:indexPath];
    }];
    [self.dataArray addObjectsFromArray:array];
    [self beginUpdates];
    [self insertRowsAtIndexPaths:insetList withRowAnimation:UITableViewRowAnimationNone]; // 插入新row
    [self endUpdates];
}

#pragma mark ================Private - 私有=================
- (void)initWithConfig
{
    self.delegate = self;
    self.dataSource = self;

    self.backgroundColor = [UIColor whiteColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

// UITableView -- reloadData
- (void)baseReloadData
{
    [self reloadData];
    [self endMJRefresh];
}

- (void)setBaseRowHeight:(CGFloat)baseRowHeight
{
    _baseRowHeight = baseRowHeight;
    self.rowHeight = _baseRowHeight;
}

- (void)setBaseSectionHeaderHeight:(CGFloat)baseSectionHeaderHeight {
    _baseSectionHeaderHeight = baseSectionHeaderHeight;
    self.sectionHeaderHeight = _baseSectionHeaderHeight;
}

- (void)setBaseSectionFooterHeight:(CGFloat)baseSectionFooterHeight {
    _baseSectionFooterHeight = baseSectionFooterHeight;
    self.sectionFooterHeight = _baseSectionFooterHeight;
}

- (void)openEmptiyDataSet:(BOOL)isEmptiy
{
    if (isEmptiy == YES) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    }
    [self reloadData];
}

@end
