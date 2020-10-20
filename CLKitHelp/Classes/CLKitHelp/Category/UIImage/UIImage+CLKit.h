/***

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


@interface UIImage (CLKit)


#pragma mark ===================类方法===================
/// 截屏
+ (instancetype)clKitSnapshotCurrentScreen;

/// 根据传入的图片,生成一终带有边框的圆形图片.
/// @param borderW 边框宽度
/// @param color 边框颜色
/// @param image 要生成的原始图片
+ (UIImage *)clKitImageCreateWithBorderW:(CGFloat)borderW
                  borderColor:(UIColor *)color
                        image:(UIImage *)image;

/// 生成一张纯色图片
/// @param color 颜色
+ (UIImage *)clKitImageCreateWithColor:(UIColor *)color;

/// 合成图片
/// @param firstImage 第一张图片
/// @param secondImage 第二章图片
+ (UIImage *)clKitMergeImage:(UIImage *)firstImage
                    withImage:(UIImage *)secondImage;


/// 压缩 - 图片尺寸大小
/// @param sourceImage 图片
/// @param targetWidth 希望要的大小
+ (UIImage *)clKitCompressionImage:(UIImage *)sourceImage
                      toTargetWidth:(CGFloat)targetWidth;


#pragma mark ===================对象方法===================
/// 图片模糊
- (UIImage *)clKitImageFuzzy;

/// 圆角图片
/// @param radius 角度
- (UIImage *)cKitCreateCornerRadius:(CGFloat)radius;

/// 设置角度和大小圆角图片
/// @param radius 角度
/// @param size 大小
- (UIImage *)clKitImageAddCornerWithRadius:(CGFloat)radius
                                    andSize:(CGSize)size;
/// 在图片上加居中的文字
/// @param title 文字
/// @param fontSize 大小
/// @param titleColor 字体颜色
- (UIImage *)clKitImageWithTitle:(NSString *)title
                         fontSize:(CGFloat)fontSize
                       titleColor:(UIColor *)titleColor;
/// 压缩图片
/// @param maxLength 最大字节大小
- (NSData *)clKitCompressWithMaxLength:(NSInteger)maxLength;



/// 圆形图片
- (UIImage *)clKitRoundImagewithImage;






@end

