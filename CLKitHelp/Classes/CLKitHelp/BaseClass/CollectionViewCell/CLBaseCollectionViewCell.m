/***

    当前的文件名
    CLBaseCollectionViewCell.m

    不带后缀的文件名
    CLBaseCollectionViewCell
     
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


#import "CLBaseCollectionViewCell.h"

@implementation CLBaseCollectionViewCell
#pragma mark ================Object - 对象=================


#pragma mark ================Initialize-初始化=================
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self clSetupViews];
        [self clLayoutViews];
    }
    return self;
}
#pragma mark ================Private - 私有=================

#pragma mark ================Methods - 方法=================

#pragma mark ================Delegate - 代理=================
/// 添加控件
- (void)clSetupViews{}

/// 添加布局
- (void)clLayoutViews{}

/// 添加数据
/// @param model 数据
- (void)clLoadDataWithModel:(id)model{}


@end
