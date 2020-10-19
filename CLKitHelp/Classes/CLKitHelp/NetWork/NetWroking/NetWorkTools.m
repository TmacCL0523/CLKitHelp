/***

    当前的文件名
    NetWorkTools.m

    不带后缀的文件名
    NetWorkTools

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

#import "NetWorkTools.h"

#ifdef DEBUG
#define NetLog(...)                 printf("%s [第%d行]: %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define NetLog(...)
#endif

#define NSStringFormat(format, ...) [NSString stringWithFormat:format, ## __VA_ARGS__]

@implementation NetWorkTools

static BOOL _isOpenLog;   // 是否已开启日志打印
static NSMutableArray *_allSessionTask;//所有请求数组
static AFHTTPSessionManager *_sessionManager;//请求manager

/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/*
init
*/
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = 10;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark ================网络方法=================

/*
有网YES, 无网:NO
*/
+ (BOOL)isNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

/*
手机网络:YES, 反之:NO
*/
+ (BOOL)isWWANNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

/*
WiFi网络:YES, 反之:NO
*/
+ (BOOL)isWiFiNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

/*
取消所有HTTP请求
*/
+ (void)cancelAllRequest
{
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask *_Nonnull task, NSUInteger idx, BOOL *_Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

/*
实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
*/
+ (void)networkStatusWithBlock:(CLNetWorkStatus)networkStatus
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *msg = @"";
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                msg = @"位置网络";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                msg = @"无网络";

                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                msg = @"手机网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                msg = @"WIFI";
                break;
        }
        if (_isOpenLog) NetLog(@"%@", msg);
        networkStatus ? networkStatus(msg, status) : nil;
    }];
}

/**
取消指定URL的HTTP请求
*/
+ (void)cancelRequestWithURL:(NSString *)URL
{
    if (!URL) {
        return;
    }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask *_Nonnull task, NSUInteger idx, BOOL *_Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

/*
/// 开启日志打印 (Debug级别)
*/
+ (void)openLog
{
    _isOpenLog = YES;
}

/*
/// 关闭日志打印,默认关闭
*/
+ (void)closeLog
{
    _isOpenLog = NO;
}

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

#pragma mark ================manager=================

/**
 在开发中,如果以下的设置方式不满足项目的需求,就调用此方法获取AFHTTPSessionManager实例进行自定义设置
 (注意: 调用此方法时在要导入AFNetworking.h头文件,否则可能会报找不到AFHTTPSessionManager的❌)
 @param sessionManager AFHTTPSessionManager的实例
 */
+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *sessionManager))sessionManager
{
    sessionManager ? sessionManager(_sessionManager) : nil;
}

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer PPRequestSerializerJSON(JSON格式),PPRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(RequestSerializer)requestSerializer
{
    _sessionManager.requestSerializer = requestSerializer == RequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer PPResponseSerializerJSON(JSON格式),PPResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(ResponseSerializer)responseSerializer
{
    _sessionManager.responseSerializer = responseSerializer == ResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time
{
    _sessionManager.requestSerializer.timeoutInterval = time;
}

/*
/// 设置请求头
*/
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

/**
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103

 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发
        的证书，也可以建立连接，这个非常危险, 建议打开.validatesDomainName=NO, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外
        一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 */
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName
{
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];

    [_sessionManager setSecurityPolicy:securityPolicy];
}

#pragma mark ================网络操作=================
#pragma mark GET    -----方法-----
/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)netWorkGET:(NSString *)URL
                               parameters:(id)parameters
                            requestHeader:(NSDictionary *)header
                                  success:(HttpSuccess)success
                                  failure:(HttpFailed)failure
{
    return [self netWorkGET:URL parameters:parameters requestHeader:header responseCache:nil success:success failure:failure];
}

/**
 *  GET请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)netWorkGET:(NSString *)URL
                               parameters:(id)parameters
                            requestHeader:(NSDictionary *)header
                            responseCache:(HttpCache)responseCache
                                  success:(HttpSuccess)success
                                  failure:(HttpFailed)failure
{
    //读取缓存
    responseCache != nil ? responseCache([NetWorkCache httpCacheForURL:URL parameters:parameters]) : nil;

    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters headers:header progress:^(NSProgress *_Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if (_isOpenLog) { NetLog(@"请求结果:\n%@\n", responseObject); }
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache != nil ? [NetWorkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (_isOpenLog) { NetLog(@"失败结果:\n%@\n", error); }
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;

    return sessionTask;
}

#pragma mark POST   -----方法-----
/**
 *  POST请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)netWorkPOST:(NSString *)URL
                                parameters:(id)parameters
                             requestHeader:(NSDictionary *)header
                                   success:(HttpSuccess)success
                                   failure:(HttpFailed)failure
{
    return [self netWorkPOST:URL parameters:parameters requestHeader:header responseCache:nil success:success failure:failure];
}

/**
 *  POST请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)netWorkPOST:(NSString *)URL
                                parameters:(id)parameters
                             requestHeader:(NSDictionary *)header
                             responseCache:(HttpCache)responseCache
                                   success:(HttpSuccess)success
                                   failure:(HttpFailed)failure
{
    //读取缓存
    responseCache != nil ? responseCache([NetWorkCache httpCacheForURL:URL parameters:parameters]) : nil;

    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters headers:header progress:^(NSProgress *_Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if (_isOpenLog) { NetLog(@"请求成功:\n%@\n", responseObject); }

        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache != nil ? [NetWorkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (_isOpenLog) {
            NetLog(@"请求失败:\n%@\n", error);
        }
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];

    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    return sessionTask;
}

#pragma mark UpLoad     -----方法-----
/**
 *  上传文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)netWorkUploadFileWithURL:(NSString *)URL
                                             parameters:(id)parameters
                                                   name:(NSString *)name
                                               filePath:(NSString *)filePath
                                               progress:(HttpProgress)progress
                                                success:(HttpSuccess)success
                                                failure:(HttpFailed)failure
{
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
                          progress ? progress(uploadProgress) : nil;
                      });
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if (_isOpenLog) { NetLog(@"请求成功:\n%@\n", responseObject); }
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (_isOpenLog) { NetLog(@"请求失败:\n%@\n", error); }
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];

    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;

    return sessionTask;
}

/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)netWorkUploadImagesWithURL:(NSString *)URL
                                               parameters:(id)parameters
                                                     name:(NSString *)name
                                                   images:(NSArray<UIImage *> *)images
                                                fileNames:(NSArray<NSString *> *)fileNames
                                               imageScale:(CGFloat)imageScale
                                                imageType:(NSString *)imageType
                                                 progress:(HttpProgress)progress
                                                  success:(HttpSuccess)success
                                                  failure:(HttpFailed)failure
{
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ? : 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            NetLog(@"%@", imageData);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%ld.%@", str, i, imageType ? : @"jpg");
            if (imageData != nil) {
                [formData appendPartWithFileData:imageData
                                            name:name
                                        fileName:fileNames ? NSStringFormat(@"%@.%@", fileNames[i], imageType ? : @"jpg") : imageFileName
                                        mimeType:NSStringFormat(@"image/%@", imageType ? : @"jpg")];
            }
        }
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
                          progress ? progress(uploadProgress) : nil;
                      });
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if (_isOpenLog) { NetLog(@"请求成功:\n%@\n", responseObject); }
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (_isOpenLog) { NetLog(@"请求失败:\n%@\n", error); }
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];

    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;

    return sessionTask;
}

#pragma mark DownLoad   -----方法-----
/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)netWorkDownloadWithURL:(NSString *)URL
                                              fileDir:(NSString *)fileDir
                                             progress:(HttpProgress)progress
                                              success:(void (^)(NSString *filePath))success
                                              failure:(HttpFailed)failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress *_Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
                          progress ? progress(downloadProgress) : nil;
                      });
    } destination:^NSURL *_Nonnull (NSURL *_Nonnull targetPath, NSURLResponse *_Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse *_Nonnull response, NSURL *_Nullable filePath, NSError *_Nullable error) {
        [[self allSessionTask] removeObject:downloadTask];
        if (failure && error) { failure(error); return; }
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil;

    return downloadTask;
}

@end
