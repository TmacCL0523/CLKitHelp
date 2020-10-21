
#import <UIKit/UIKit.h>

@class CLCollectionLayout;

@protocol CLCollectionLayoutDelegate <NSObject>

//TODO: ----------必须要实现 - 协议----------
@required

/// 设置每个item的高度
/// @param collectionLayout 当前layout
/// @param indexPath 下标
/// @param itemWidth 宽度
- (CGFloat)collectionViewLayout:(CLCollectionLayout *)collectionLayout
       heightForItemAtIndexPath:(NSUInteger)indexPath
                       itemWith:(CGFloat)itemWidth;
//TODO: ----------选择是否需要实现 - 协议----------
@optional

/// 列 - 个数
/// @param layout 当前layout
- (NSUInteger)numberOfItemWithColumnForCollectionLayout:(CLCollectionLayout *)layout;

/// 列 - 间距
/// @param layout 当前layout
- (CGFloat)spacValueInCollectionLayout:(CLCollectionLayout *)layout;

/// 行 - 间距
/// @param layout 当前layout
- (CGFloat)rowSpacValueInCollectionLayout:(CLCollectionLayout *)layout;

/// item - 内边距（UIEdgeInsets）
/// @param layout 当前layout
- (UIEdgeInsets)edgeInsetInCollectionLayout:(CLCollectionLayout *)layout;
@end

@interface CLCollectionLayout : UICollectionViewLayout

#pragma mark ================Property-属性=================
@property (nonatomic, weak) id<CLCollectionLayoutDelegate> delegate;

@end
