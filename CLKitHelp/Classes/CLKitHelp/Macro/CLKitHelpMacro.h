//
//  CLKitHelpMacro.h
//  Tools
//
//  Created by QiYue on 2020/10/16.
//

#ifndef CLKitHelpMacro_h
#define CLKitHelpMacro_h

#ifdef DEBUG
//#define CLLog(fmt, ...)       NSLog(@"Log打印\n[%@:%d] \n" fmt @"\n--------------\n", [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__, ## __VA_ARGS__)

#define CLLog(FORMAT, ...)    fprintf(stderr, "🙏BUG🙏\t[⌚️：%s] [文件: %s\t 方法: %s\t Line: %d] \t打印开始 LOG👉\t%s\t 👈\n", __TIME__, [[NSString stringWithFormat:@"%@", NSStringFromClass([self class])] UTF8String] ,[[NSString stringWithFormat:@"%@", NSStringFromSelector(_cmd)] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ## __VA_ARGS__] UTF8String]);

#else
#define CLLog(fmt, ...)
#endif

#define CLLogBounds(view)     CLLog(@"%s bounds: %@", #view, NSStringFromCGRect([view bounds]))
#define CLLogFrame(view)      CLLog(@"%s frame: %@", #view, NSStringFromCGRect([view frame]))
#define CLLogRect(rect)       CLLog(@"%s : %@", #rect, NSStringFromCGRect(rect))
#define CLLogSize(size)       CLLog(@"%s : %@", #size, NSStringFromCGSize(size))
#define CLLogPoint(point)     CLLog(@"%s : %@", #point, NSStringFromCGPoint(point))
#define CLLogString(str)      CLLog(@"%s : %@", #str, str)
#define CLLogObj(obj)         CLLog(@"%s : %@", #obj, obj)
#define CLLogInteger(integer) CLLog(@"%s : %ld", #integer, (long)integer)
#define CLLogFloat(float)     CLLog(@"%s : %f", #float, float)
#define CLLogBool(Bool)       CLLog(@"%s : %@", #Bool, (Bool ? @"YES" : @"NO"))

#pragma mark ================屏幕属性=================
//屏幕尺寸
#define CLScreenSize           [UIScreen mainScreen].bounds.size
//宽
#define CLScreenWidth          [UIScreen mainScreen].bounds.size.width
//高
#define CLScreenHeight         [UIScreen mainScreen].bounds.size.height
//字体适配
#define CLScaleFont(fontSize) [UIFont systemFontOfSize:fontSize * CLScreenWidth / 375]
//状态栏高度
#define CLStatusBarHeight      [[UIApplication sharedApplication] statusBarFrame].size.height
//状态栏高度
#define CLStatusBarHeightX     (CLISiPhoneXX ? 44 : 20)
//标签栏高度
#define CLTabBarHeight         (CLStatusBarHeight > 20 ? 83 : 49)
//导航栏高度
#define CLNavBarHeight         (CLStatusBarHeight + 44)
//安全区高度
#define CLSafeAreaBottom       (CLISiPhoneXX ? 34 : 0)
// 底部安全距离
#define CLSafeAreaBottomHeight (CLISiPhoneX ? 34.f : 0.f)
// 状态栏高度 + 顶部导航栏高度
#define CLSafeAreaTopHeight    UIApplication.sharedApplication.statusBarFrame.size.height + 44

#pragma mark ================Application=================
// APP对象 （单例对象）
#define CLSharedApplication    [UIApplication sharedApplication]
// APP对象
#define CLSharedAppDelegate    (AppDelegate *)[[UIApplication sharedApplication] delegate]
// 主窗口 （keyWindow）
#define CLSharedKeyWindow      [UIApplication sharedApplication].keyWindow
// NSUserDefaults实例化
#define CLUserDefaults         [NSUserDefaults standardUserDefaults]
// 通知中心 （单例对象）
#define CLNotificationCenter   [NSNotificationCenter defaultCenter]
//获取temp
#define CLPathTemp             NSTemporaryDirectory()
//获取沙盒 Document
#define CLPathDocument         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define CLPathCache            [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#pragma mark ================手机属性=================
//是否iPhone
#define CLISiPhone             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//最大屏幕尺寸
#define CLScreenMaxLength      (MAX(CLScreenWidth, CLScreenHeight))
//最小屏幕尺寸
#define CLScreenMinLength      (MIN(CLScreenWidth, CLScreenHeight))
//是否iPhone X
#define CLISiPhoneX            (CLISiPhone && CLScreenMaxLength == 812.0)
//是否iPhone XR
#define CLISiPhoneXr           (CLISiPhone && CLScreenMaxLength == 896.0)

#define CLISiPhoneXX           (CLISiPhone && CLScreenMaxLength > 811.0)
//是否iOS 9
#define CLIosVersion(a)             ([[[UIDevice currentDevice] systemVersion] doubleValue] >= a)

#pragma mark ================字体属性=================
//字体
#define CLBoldFont(x)               [UIFont boldSystemFontOfSize:x]
#define CLFont(x)                   [UIFont systemFontOfSize:x]
#define CLNameFont(fontName, x)     [UIFont fontWithName:fontName size:x]

#pragma mark ================判断是否为空=================
#define CLISEmptyString(str)        ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO)
#define CLISEmptyArray(array)       (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 || [array isEqual:[NSNull null]])
#define CLISEmptyDict(dic)          (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])
#define CLISEmptyObject(_object)    (_object == nil \
                                     || [_object isKindOfClass:[NSNull class]] \
                                     || ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
                                     || ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#pragma mark ================self=================
/*! weakSelf */
#define CLWEAKSELF    typeof(self) __weak weakSelf = self
#define CLWeakSelf(type)            __weak typeof(type) weak ## type = type;
/*! strongSelf */
#define CLStrongSelf(type)          __strong typeof(type) type = weak ## type;

#pragma mark ================颜色=================
/// 随机颜色
#define CLRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]
#define CLRGBColor(r, g, b)         [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1.0]
#define CLRGBAColor(r, g, b, a)     [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:a]
#define CLRGBColor16Value(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

// clear背景颜色
#define CLClearColor  [UIColor clearColor]

#define CLRadianFrom(degree)        (M_PI * (degree) / 180.0)
#define CLDegreeFrom(radian)        (radian * 180.0) / (M_PI)
#define CLGetImage(imageName)       [UIImage imageNamed:imageName]

#endif /* CLKitHelpMacro_h */
