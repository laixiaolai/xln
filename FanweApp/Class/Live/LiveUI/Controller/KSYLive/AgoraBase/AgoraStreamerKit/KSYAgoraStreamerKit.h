#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class KSYGPUStreamerKit;
@class KSYAgoraClient;

@interface KSYAgoraStreamerKit: KSYGPUStreamerKit
/**
 @abstract 初始化方法
 @discussion 创建带有默认参数的 kit
 
 @warning kit只支持单实例推流，构造多个实例会出现异常
 */
- (instancetype) initWithDefaultCfg;
/**
 @abstract rtc接口类
 */
@property (nonatomic, strong) KSYAgoraClient * agoraKit;
/*
 @abstract start call的回调函数
 */
@property (nonatomic, copy)void (^onCallStart)(int status);
/*
 @abstract stop call的回调函数
 */
@property (nonatomic, copy)void (^onCallStop)(int status);
/*
 @abstract 加入channel回调
 */
@property (nonatomic, copy)void (^onChannelJoin)(int status);

#pragma 小窗口相关配置
/*
 @abstract 小窗口图层
 */
@property (nonatomic, readwrite) NSInteger rtcLayer;
/**
 @abstract 小窗口图层的大小
 */
@property (nonatomic, readwrite) CGRect winRect;
/*
 @abstract 用户自定义图层
 */
@property (nonatomic, readwrite) NSInteger customViewLayer;
/*
 @abstract 用户自定义图层的大小
 */
@property (nonatomic, readwrite) CGRect customViewRect;
/*
 @abstract 自定义图层母类，可往里addview
 */
@property (nonatomic, readwrite)UIView * contentView;

/*
 @abstract 美颜滤镜
 */
@property GPUImageOutput<GPUImageInput>* curfilter;
/**
 @abstract 主窗口和小窗口切换
 */
@property (nonatomic, readwrite) BOOL selfInFront;

@property (nonatomic, readwrite) BOOL   callstarted;
#pragma 操作函数
/**
 @abstract 加入rtc窗口滤镜
 */
- (void) setupRtcFilter:(GPUImageOutput<GPUImageInput> *) filter;

/*
 @abstract 加入通道
 */
- (void)joinChannel:(NSString *)channelName;
/*
 @abstract 离开通道
 */
- (void)leaveChannel;

@end

