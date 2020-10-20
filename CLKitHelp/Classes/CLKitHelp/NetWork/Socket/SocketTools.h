/***

    当前的文件名
    SocketTools.h

    不带后缀的文件名
    SocketTools

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

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

// 连接状态
typedef NS_ENUM (NSInteger, SocketConnectStatus) {
    SocketConnectStatusDisconnected = 0,   // 未连接
    SocketConnectStatusConnecting   = 1,   // 连接中
    SocketConnectStatusConnected    = 2    // 已连接
};

typedef void (^ReadDataBlock)(NSData *data);

typedef void (^ConnectStatusBlock)(SocketConnectStatus status);

typedef void (^ConnectErrorBlock)(NSError *error);

@interface SocketTools : NSObject

#pragma mark ================Property-属性=================
/**
 *  URL
 */
@property (nonatomic, copy) NSString *apiUrl;

/**
 *  端口
 */
@property (nonatomic, assign) NSInteger portNumber;

#pragma mark ================Methods-方法=================

/**
 获取全局长连接(单例)
 */
+ (instancetype)sharedSocket;

/**
  连接服务器
 */
- (void)connectServerWithHeartBeat:(NSData *)data
                 withReadDataBlock:(ReadDataBlock)readDataBlock
                  withConnectError:(ConnectErrorBlock)error
                 withConnectStatus:(ConnectStatusBlock)statusBlock;

/**
 断开连接
 */
- (void)disConnectServer;

/**
 发送数据
 */
- (void)sendData:(NSData *)data;

/**
 发送心跳
 */
- (void)beginSendHeartbeatWithData:(NSData *)data;

@end
