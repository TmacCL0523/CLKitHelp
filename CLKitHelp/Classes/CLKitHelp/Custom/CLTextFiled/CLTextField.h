/***

    当前的文件名
    CLTextField.h

    不带后缀的文件名
    CLTextField

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

typedef NS_ENUM (NSInteger, CLKitTextFieldStyle) {
    /// 默认
    CLKitTextFieldStyleNone,
    /// 手机号码格式化 格式化结果：138 1111 1111
    CLKitTextFieldStylePhoneNumber,
    /// 银行卡卡号格式化【格式化结果：1111 1111 1111 1234】
    CLKitTextFieldStyleBankNumber
};

#pragma mark ================Protocols-代理/协议=================

@interface CLTextField : UITextField

#pragma mark ================Property-属性=================
///  键盘输入样式
@property (nonatomic) CLKitTextFieldStyle textfieldStyle;

///  电话号码限制验证码限制(默认只能输入11位数字)
@property (assign, nonatomic) IBInspectable BOOL phoneRestrict;
///  限制输入长度
@property (assign, nonatomic) IBInspectable NSInteger lengthRestrict;
///  带小数点的数字限制(默认只能输入小数位后2位)
@property (assign, nonatomic) IBInspectable BOOL decimalsRestrict;
///  验证码限制(默认只能输入6位数字)
@property (assign, nonatomic) IBInspectable BOOL verCodeRestrict;
///  限制只能输入数字
@property (assign, nonatomic) IBInspectable BOOL numberRestrict;
#pragma mark ================Methods-方法=================

@end
