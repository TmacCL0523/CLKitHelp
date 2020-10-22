
#import "CLCollectionLayout.h"

@interface CLCollectionLayout ()

/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArr;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;

- (NSUInteger)colunmCount;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation CLCollectionLayout

#pragma mark ===================私有方法===================
#pragma mark 懒加载
- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }

    return _attrsArr;
}

- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }

    return _columnHeights;
}

#pragma mark - 数据处理
/**
 * 列数
 */
- (NSUInteger)colunmCount
{
    NSUInteger count;
    if ([self.delegate respondsToSelector:@selector(numberOfItemWithColumnForCollectionLayout:)]) {
        count = [self.delegate numberOfItemWithColumnForCollectionLayout:self];
    } else {
        count = 3;
    }
    return count;
}

/**
 * 列间距
 */
- (CGFloat)columnMargin
{
    CGFloat spac;
    if ([self.delegate respondsToSelector:@selector(spacValueInCollectionLayout:)]) {
        spac =  [self.delegate spacValueInCollectionLayout:self];
    } else {
        spac = 10;
    }
    return spac;
}

/**
 * 行间距
 */
- (CGFloat)rowMargin
{
    CGFloat spac;
    if ([self.delegate respondsToSelector:@selector(rowSpacValueInCollectionLayout:)]) {
        spac =  [self.delegate rowSpacValueInCollectionLayout:self];
    } else {
        spac = 10;
    }
    return spac;
}

/**
 * item的内边距
 */
- (UIEdgeInsets)edgeInsets
{
    UIEdgeInsets edge;
    if ([self.delegate respondsToSelector:@selector(edgeInsetInCollectionLayout:)]) {
        edge = [self.delegate edgeInsetInCollectionLayout:self];
    } else {
        edge = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return edge;
}

#pragma mark ===================初始化===================
/**
 * 初始化
 */
- (void)prepareLayout {
    [super prepareLayout];

    self.contentHeight = 0;

    // 清楚之前计算的所有高度
    [self.columnHeights removeAllObjects];

    // 设置每一列默认的高度
    for (NSInteger i = 0; i < self.colunmCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }

    NSLog(@"%lu", (unsigned long)self.colunmCount);
    // 清楚之前所有的布局属性
    [self.attrsArr removeAllObjects];

    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];

    for (int i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

        // 获取indexPath位置上cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];

        [self.attrsArr addObject:attrs];
    }
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    //collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;

    // 设置布局属性的frame

    CGFloat cellW = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.colunmCount - 1) * self.columnMargin) / self.colunmCount;
    CGFloat cellH = [self.delegate collectionViewLayout:self heightForItemAtIndexPath:indexPath.item itemWith:cellW];

    // 找出最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];

    for (int i = 1; i < self.colunmCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];

        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }

    CGFloat cellX = self.edgeInsets.left + destColumn * (cellW + self.columnMargin);
    CGFloat cellY = minColumnHeight;
    if (cellY != self.edgeInsets.top) {
        cellY += self.rowMargin;
    }

    attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);

    // 更新最短那一列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));

    // 记录内容的高度 - 即最长那一列的高度
    CGFloat maxColumnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < maxColumnHeight) {
        self.contentHeight = maxColumnHeight;
    }

    return attrs;
}

/**
 * 决定cell的高度
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArr;
}

/**
 * 内容的高度
 */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

@end
