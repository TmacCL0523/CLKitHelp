

#import "CLCollectionLayout.h"

@interface CLCollectionLayout ()

/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray * attrsArr;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;

/// 列数
@property (nonatomic , assign) NSInteger colunmNumber;

/// 每列 - 边距
@property (nonatomic , assign) CGFloat colunmSpac;

/// 每行 - 间距
@property (nonatomic , assign) CGFloat rowSpac;

/// 内边距
@property (nonatomic , assign) UIEdgeInsets edgeIset;


- (NSUInteger)colunmCount;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation CLCollectionLayout

#pragma mark ===================私有方法===================
#pragma mark 懒加载
- (NSMutableArray *)attrsArr{
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    
    return _attrsArr;
}

- (NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    
    return _columnHeights;
}

#pragma mark - 数据处理
/**
 * 列数
 */
- (NSUInteger)colunmCount{
    
    if ([self.delegate respondsToSelector:@selector(numberOfItemWithColumnForCollectionLayout:)]) {
        self.colunmNumber = [self.delegate numberOfItemWithColumnForCollectionLayout:self];
    }else{
         self.colunmNumber = 3;
    }
    return self.colunmNumber;
}

/**
 * 列间距
 */
- (CGFloat)columnMargin{
    if ([self.delegate respondsToSelector:@selector(spacValueInCollectionLayout:)]) {
        self.colunmSpac =  [self.delegate spacValueInCollectionLayout:self];
    }else{
        self.colunmSpac = 10;
    }
    return self.colunmSpac;
}

/**
 * 行间距
 */
- (CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(rowSpacValueInCollectionLayout:)]) {
        self.rowSpac =  [self.delegate rowSpacValueInCollectionLayout:self];
    }else{
        self.rowSpac = 10;
    }
    return self.rowSpac;
}

/**
 * item的内边距
 */
- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetInCollectionLayout:)]) {
        self.edgeIset = [self.delegate edgeInsetInCollectionLayout:self];
    }else{
        self.edgeIset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self.edgeIset;
}
#pragma mark ===================初始化===================
/**
 * 初始化
 */
- (void)prepareLayout{
    
    [super prepareLayout];
    
    self.contentHeight = 0;
    
    // 清楚之前计算的所有高度
    [self.columnHeights removeAllObjects];
    
    // 设置每一列默认的高度
    for (NSInteger i = 0; i < self.colunmCount ; i ++) {
        [self.columnHeights addObject:@(self.edgeIset.top)];
    }
    
    NSLog(@"%d",self.colunmCount);
    // 清楚之前所有的布局属性
    [self.attrsArr removeAllObjects];
    
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        
        // 创建位置
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 获取indexPath位置上cell对应的布局属性
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArr addObject:attrs];
    }
    
}


/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 创建布局属性
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
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
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
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
