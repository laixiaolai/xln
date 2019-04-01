#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class KSYGPUStreamerKit;
@class KSYRTCClient;

@interface KSYRTCStreamerKit: KSYGPUStreamerKit
/**
 @abstract 初始化方法
 @discussion 创建带有默认参数的 kit
 
 @warning kit只支持单实例推流，构造多个实例会出现异常
 */
- (instancetype) initWithDefaultCfg;
/**
 @abstract rtc接口类
 */
@property (nonatomic, strong) KSYRTCClient * rtcClient;

/*
 @abstract start call的回调函数
 */
@property (nonatomic, copy)void (^onCallStart)(int status);
/*
 @abstract stop call的回调函数
 */
@property (nonatomic, copy)void (^onCallStop)(int status);
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

/**
 @abstract 主窗口和小窗口切换
 */
@property (nonatomic, readwrite) BOOL selfInFront;

/**
 @abstract 当前连麦是否已经开始
 */
@property (nonatomic, readwrite) BOOL   callstarted;

/**
 @abstract 圆角的图片
 */
@property GPUImagePicture *  maskPicture;

/**
 @abstract 停止图层渲染
 */
- (void)stopRTCView;

#pragma 美颜操作函数

@property (nonatomic, readwrite) GPUImageOutput<GPUImageInput>* curfilter;
/**
 @abstract 加入rtc窗口滤镜
 */
- (void) setupRtcFilter:(GPUImageOutput<GPUImageInput> *) filter;
@end
