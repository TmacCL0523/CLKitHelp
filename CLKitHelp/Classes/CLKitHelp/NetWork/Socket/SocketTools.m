/***

    当前的文件名
    SocketTools.m

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

#import "SocketTools.h"

@interface SocketTools ()<GCDAsyncSocketDelegate>
//链接
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
//心跳
@property (nonatomic, strong) NSTimer *heartbeatTimer;
//是否连接
@property (nonatomic, assign) BOOL isConnection;
//消息回调
@property (nonatomic, copy) ReadDataBlock readBlock;
//错误回调
@property (nonatomic, copy) ConnectErrorBlock errorBlock;
//状态回调
@property (nonatomic, copy) ConnectStatusBlock connectBlock;
//
@property (nonatomic, strong) NSData *heardBeatData;

@end

@implementation SocketTools

#pragma mark ================Model=================
/**
 获取全局长连接(单例)
 */
+ (instancetype)sharedSocket {
    static SocketTools *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark ================公有方法=================
/**
  连接服务器
 */
- (void)connectServerWithHeartBeat:(NSData *)data withReadDataBlock:(ReadDataBlock)readDataBlock withConnectError:(ConnectErrorBlock)error withConnectStatus:(ConnectStatusBlock)statusBlock
{
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    self.heardBeatData = data;
    self.readBlock = readDataBlock;
    self.errorBlock = error;
    self.connectBlock = statusBlock;
}

/**
 断开连接
 */
- (void)disConnectServer
{
    self.isConnection = NO;
    if (self.heartbeatTimer) {
        [self.heartbeatTimer invalidate];
        self.heartbeatTimer = nil;
    }
    [self.clientSocket disconnect];
    self.clientSocket.delegate = nil;
    self.clientSocket = nil;
    self.connectBlock(SocketConnectStatusDisconnected);
}

/**
 发送数据
 */
- (void)sendData:(NSData *)data
{
    if (self.isConnection) {
        [self.clientSocket writeData:data withTimeout:-1 tag:0];
    }
}

/**
 发送心跳
 */
- (void)beginSendHeartbeatWithData:(NSData *)data
{
    [self.heartbeatTimer invalidate];
    self.heartbeatTimer = nil;
    self.heartbeatTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(sendHeartbeat:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.heartbeatTimer forMode:NSRunLoopCommonModes];
}

#pragma mark ================私有方法=================
- (void)connectServer
{
    NSError *error = nil;
    [self.clientSocket connectToHost:self.apiUrl onPort:self.portNumber error:&error];

    if (error) {
        NSLog(@"socketError--%@", error);
        self.errorBlock(error);
    }
}

- (void)sendHeartbeat:(NSTimer *)timer
{
    if (timer != nil) {
        [self beginHeartBeat];
    }
}

- (void)beginHeartBeat
{
    [self.clientSocket writeData:self.heardBeatData withTimeout:-1 tag:0];
}

#pragma mark ================代理方法=================
#pragma mark - GCDSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"--连接成功--");
    self.isConnection = YES;

    [sock readDataWithTimeout:-1 tag:0];
    [self beginHeartBeat];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"--断开连接--");
    self.isConnection = NO;

    if (self.heartbeatTimer) {
        [self.heartbeatTimer invalidate];
        self.heartbeatTimer = nil;
    }
    self.clientSocket.delegate = nil;
    self.clientSocket = nil;
    self.connectBlock(SocketConnectStatusDisconnected);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    self.readBlock(data);
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"%ld", tag);
}

@end
