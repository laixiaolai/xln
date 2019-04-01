//
//  YTAllMySeatModel.h
//  FanweApp
//
//  Created by hzc on 2019/2/22.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTMySeatModel.h"
@interface YTAllMySeatModel : NSObject
@property (nonatomic, assign) int  driver_type;//1.帝王 2.豪华 3.普通
@property (nonatomic, strong) NSMutableArray<YTMySeatModel*>* arr;
@end
