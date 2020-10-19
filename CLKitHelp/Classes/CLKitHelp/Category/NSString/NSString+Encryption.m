
/***

    当前的文件名
    NSString+Encryption.h

    不带后缀的文件名
    NSString+Encryption

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

#import "NSString+Encryption.h"
#import <CommonCrypto/CommonDigest.h>



@implementation NSString (Encryption)
#pragma mark ===================Method - 加密===================

/*
    MD5加密
*/
- (NSString *)clKitStringToMD5
{
    if (self == nil || [self length] == 0) {
        return nil;
    }

    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];

    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }

    return [ms copy];
}

/*
    16位MD5加密
*/
- (NSString *)clKitStringTo16MD5
{
    if (self == nil || [self length] == 0) {
        return nil;
    }

    return [[self clKitStringToMD5] substringWithRange:NSMakeRange(8, 16)];
}

/*
    哈希加密
*/
- (NSString *)clKitStringToSha1
{
    if (self == nil || [self length] == 0) {
        return nil;
    }

    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];

    for (i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }

    return [ms copy];
}

/*
    哈希值加密
*/
- (NSString *)clKitStringToSha256
{
    if (self == nil || [self length] == 0) {
        return nil;
    }

    unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
    CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];

    for (i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }

    return [ms copy];
}

/*
    哈希值加密
*/
- (NSString *)clKitStringToSha512
{
    if (self == nil || [self length] == 0) {
        return nil;
    }

    unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
    CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];

    for (i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }

    return [ms copy];
}
@end
