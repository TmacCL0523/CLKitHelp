/***

    当前的文件名
    CLTextField.m

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

#import "CLTextField.h"
#import <objc/runtime.h>

/*! 电话号码限制验证码限制(默认只能输入11位数字) */
static const void *phoneRestrictKey = &phoneRestrictKey;
/*! 长度限制 */
static const void *lengthRestrictKey = &lengthRestrictKey;
/*! 带小数点的数字限制(默认只能输入小数位后2位) */
static const void *decimalsRestrictKey = &decimalsRestrictKey;
/*! 验证码限制(默认只能输入6位数字) */
static const void *verCodeRestrictKey = &verCodeRestrictKey;
/*! 限制只能输入数字 */
static const void *numberRestrictKey = &numberRestrictKey;

static NSInteger byteNil = 3;
static NSInteger byteNilFlag = 0;
static NSInteger byteNilBank = 4;
static NSInteger byteNilFlagBank = 0;
//static NSInteger tableHeight = 30;
//static CGFloat keyHchange = 0;
//static CGFloat keyChangeTableH = 0;
//static CGFloat selfLocation_MAXy = 0;

@interface CLTextField ()<UITextFieldDelegate>

@end

@implementation CLTextField

#pragma mark ================Object - 对象=================

#pragma mark ================Initialize-初始化=================
- (instancetype)init
{
    if (self = [super init]) {
        [self performSelector:@selector(setup)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self performSelector:@selector(setup)];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self performSelector:@selector(setup)];
    }
    return self;
}

/*! 初始化配置 */
- (void)setup
{
    self.delegate = self;
    self.phoneRestrict = NO;
    self.decimalsRestrict = NO;
    self.verCodeRestrict = NO;
    self.lengthRestrict = 0;
    self.numberRestrict = NO;
}

#pragma mark - 银行卡格式化
- (BOOL)clKit_BankFormattingNumberTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length > 19 + 3 && ![string isEqualToString:@""]) {
        return NO;
    } else if ([string isEqualToString:@" "]) {
        NSLog(@"不能输入空格");
        return NO;
    } else if (![string isEqualToString:@""]) {
        //   NSLog(@"====%@    string = %@",textField.text,string);
        if ((textField.text.length - byteNilFlagBank) % byteNilBank == 0 && (textField.text.length - byteNilFlagBank) / byteNilBank != 0 && string.length > 0) {
            byteNilFlagBank = byteNilFlagBank + byteNilBank;
            byteNilBank = 5;

            NSMutableString *str = [NSMutableString stringWithFormat:@"%@ ", textField.text];
            textField.text = str;
        }
        NSString *str = [NSString stringWithFormat:@"%@%@", textField.text, string];
        NSLog(@"格式化结果：%@", str);
        return YES;
    } else {
        /*! 删除是遇到空格多删除一位 */
        if ([[textField.text substringWithRange:range] isEqualToString:@" "]) {
            NSRange deleteRange = NSMakeRange(0, textField.text.length - 1);
            NSString *str = [textField.text substringWithRange:deleteRange];
            textField.text = str;
        }
        if (textField.text.length < 4) {
            byteNilBank = 4;
            byteNilFlagBank = 0;
        }
        if (textField.text.length  <= byteNilFlagBank) {
            byteNilFlagBank = byteNilFlagBank - byteNilBank;
        }
        NSString *str = [NSString stringWithFormat:@"%@%@", textField.text, string];
        NSLog(@"格式化结果：%@", str);
        return YES;
    }
}

#pragma mark - 手机号码格式
- (BOOL)clKit_PhoneFormatNumberTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length > 12 && ![string isEqualToString:@""]) {
        return NO;
    } else if ([string isEqualToString:@" "]) {
        NSLog(@"不能输入空格");
        return NO;
    } else if (![string isEqualToString:@""]) {
        // NSLog(@"====%@    string = %@",textField.text,string);
        if ((textField.text.length - byteNilFlag) % byteNil == 0 && (textField.text.length - byteNilFlag) / byteNil != 0 && string.length > 0) {
            byteNilFlag = byteNilFlag + byteNil;
            byteNil = 5;

            NSMutableString *str = [NSMutableString stringWithFormat:@"%@ ", textField.text];
            textField.text = str;
        }
        NSString *str = [NSString stringWithFormat:@"%@%@", textField.text, string];
        NSLog(@"格式化结果：%@", str);
        return YES;
    } else {
        //删除是遇到空格多删除一位
        if ([[textField.text substringWithRange:range] isEqualToString:@" "]) {
            NSRange deleteRange = NSMakeRange(0, textField.text.length - 1);
            NSString *str = [textField.text substringWithRange:deleteRange];
            textField.text = str;
        }
        if (textField.text.length < 3) {
            byteNil = 3;
            byteNilFlag = 0;
        }
        if (textField.text.length  <= byteNilFlag) {
            byteNilFlag = byteNilFlag - byteNil;
        }
        NSString *str = [NSString stringWithFormat:@"%@%@", textField.text, string];
        NSLog(@"格式化结果：%@", str);
        return YES;
    }
}

#pragma mark ================共有方法=================

#pragma mark ================代理方法=================

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger lengthOfString = string.length;
    NSUInteger proposedNewLength = textField.text.length - range.length + lengthOfString;

    /*! 限制字符串长度 */
    if (self.lengthRestrict > 0) {
        if (proposedNewLength > self.lengthRestrict) {
            return NO;
        }
    }

    if (self.decimalsRestrict) {
        /*! 只允许数字输入 */
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            /*! 46 unichar for " . " */
            if (character < 46) {
                return NO;
            }
            /*! 47 unichar for " / " */
            if (character == 47) {
                return NO;
            }
            /*! 48 ~ 57 unichar for 0 ~ 9 */
            if (character > 57) {
                return NO;
            }
        }

        /*! 获取Textfield实际内容 */
        NSString *currentText = @"";
        if (range.length) {
            currentText = [textField.text substringWithRange:NSMakeRange(0, textField.text.length - range.length)];
        } else {
            currentText = [textField.text stringByAppendingString:string];
        }

        /*! 判断是否已经输入小数点 */
        if ([currentText rangeOfString:@"."].location != NSNotFound) {
            /*! 不能重复输入小数点(判断当前输入的字符是否是" . ",再判断原内容是否已经有" . ") */
            if ([string isEqualToString:@"."] && [textField.text rangeOfString:@"."].location != NSNotFound) {
                return false;
            }
            /*! 获取小数点在当前内容的坐标 */
            NSRange pointRange = [currentText rangeOfString:@"."];
            if ((currentText.length - 1) - pointRange.location > 2) {
                return false;
            }
        }
    }

    if (self.phoneRestrict || self.verCodeRestrict) {
        /*! 只允许数字输入 */
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48 || character > 57) {
                return NO;
            }
        }

        if (self.phoneRestrict) {
            if (_textfieldStyle == CLKitTextFieldStylePhoneNumber) {
                if (proposedNewLength > 13) {
                    return NO;
                }
                [self clKit_PhoneFormatNumberTextField:textField shouldChangeCharactersInRange:range replacementString:string];
            } else {
                if (proposedNewLength > 11) {
                    return NO;
                }
            }
        } else if (self.verCodeRestrict) {
            if (proposedNewLength > 6) {
                return NO;
            }
        }
    }

    /*! 只允许数字输入 */
    if (self.numberRestrict) {
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            int character = [string characterAtIndex:loopIndex];
            if (character < 48 || character > 57) {
                return NO;
            } else {
                if (self.lengthRestrict > 0) {
                    if (proposedNewLength > self.lengthRestrict) {
                        return NO;
                    }
                }
                if (_textfieldStyle == CLKitTextFieldStyleBankNumber) {
                    [self clKit_BankFormattingNumberTextField:textField shouldChangeCharactersInRange:range replacementString:string];
                }
            }
        }
    }
    return YES;
}

#pragma mark ================成员变量=================

#pragma mark - 重写电话号码限制getter和setter的方法
- (void)setPhoneRestrict:(BOOL)phoneRestrict
{
    objc_setAssociatedObject(self, phoneRestrictKey, @(phoneRestrict), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)phoneRestrict
{
    return [objc_getAssociatedObject(self, phoneRestrictKey) boolValue];
}

#pragma mark - 重写限制输入长度getter和setter的方法
- (void)setLengthRestrict:(NSInteger)lengthRestrict
{
    objc_setAssociatedObject(self, lengthRestrictKey, @(lengthRestrict), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)lengthRestrict
{
    return [objc_getAssociatedObject(self, lengthRestrictKey) integerValue];
}

#pragma mark - 重写带小数点的数字限制getter和setter的方法
- (void)setDecimalsRestrict:(BOOL)decimalsRestrict
{
    objc_setAssociatedObject(self, decimalsRestrictKey, @(decimalsRestrict), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)decimalsRestrict
{
    return [objc_getAssociatedObject(self, decimalsRestrictKey) boolValue];
}

#pragma mark - 重写验证码限制getter和setter的方法
- (void)setVerCodeRestrict:(BOOL)verCodeRestrict
{
    objc_setAssociatedObject(self, verCodeRestrictKey, @(verCodeRestrict), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)verCodeRestrict
{
    return [objc_getAssociatedObject(self, verCodeRestrictKey) boolValue];
}

#pragma mark - 限制只能输入数子
- (void)setNumberRestrict:(BOOL)numberRestrict
{
    objc_setAssociatedObject(self, numberRestrictKey, @(numberRestrict), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)numberRestrict
{
    return [objc_getAssociatedObject(self, numberRestrictKey) boolValue];
}

- (void)setTextfieldStyle:(CLKitTextFieldStyle)textfieldStyle
{
    _textfieldStyle = textfieldStyle;
}

@end
