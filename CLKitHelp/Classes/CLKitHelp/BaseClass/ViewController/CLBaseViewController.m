/***

    当前的文件名
    CLBaseViewController.m

    不带后缀的文件名
    CLBaseViewController
     
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

#import "CLBaseViewController.h"

@interface CLBaseViewController ()

@end

@implementation CLBaseViewController

#pragma mark ================Object - 对象=================

#pragma mark ================Initialize-初始化=================

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self clSetupViews];
    [self clLayoutViews];
}

#pragma mark ================Methods - 方法=================

#pragma mark ================Delegate - 代理=================

#pragma mark ================Private - 私有=================
#pragma 即将显示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma 已显示
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma 即将消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma 已经消失
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

/// 添加控件
- (void)clSetupViews{}

/// 添加布局
- (void)clLayoutViews{}

/// 添加数据
- (void)clLoadDataWithModel{}

@end
