/***

    当前的文件名
    CLBaseTableViewCell.m

    不带后缀的文件名
    CLBaseTableViewCell

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

#import "CLBaseTableViewCell.h"

@interface CLBaseTableViewCell ()

@end

@implementation CLBaseTableViewCell
#pragma mark ================Object - 对象=================

#pragma mark ================Initialize-初始化=================
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self clSetupViews];
        [self clLayoutViews];
    }
    return self;
}



#pragma mark ================Methods - 方法=================

#pragma mark ================Delegate - 代理=================

#pragma mark ================Private - 私有=================
/// 添加控件
- (void)clSetupViews{}

/// 添加布局
- (void)clLayoutViews{}

/// 添加数据
/// @param model 数据
- (void)clLoadDataWithModel:(id)model{}
@end
