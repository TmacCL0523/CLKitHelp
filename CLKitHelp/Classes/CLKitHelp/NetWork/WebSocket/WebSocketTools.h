/***

    当前的文件名
    WebSocketTools.h

    不带后缀的文件名
    WebSocketTools

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
#import "SRWebSocket.h"

typedef NS_ENUM (NSInteger, WebSocketStatus) {
    WebSocketStatusDefault = 0, //初始状态，未连接
    WebSocketStatusConnect,     //已连接
    WebSocketStatusDisConnect,  //断开连接
};

#pragma mark ================Protocols-代理/协议=================

@protocol WebSocketToolsDelegate <NSObject>

/// 消息回调
/// @param string 字符串
- (void)webSocketDidReceiveMessage:(NSString *)string;

@end

@interface WebSocketTools : NSObject

#pragma mark ================Property-属性=================
@property (nonatomic, weak) id<WebSocketToolsDelegate> delegate;
@property (nonatomic, strong) SRWebSocket *webScoket;
@property (nonatomic, assign) BOOL isConnect; //是否连接
@property (nonatomic, assign) WebSocketStatus socketStatus;
#pragma mark ================Methods-方法=================

+ (instancetype)shared;
- (void)setPort:(NSString *)port;
- (void)connectServer;//建立长连接
- (void)reConnectServer;//重新连接
- (void)webSocketClose;//关闭连接
- (void)sendDataToServer:(NSString *)data; //向服务器发送数据
@end
