//
//  YTAllSeatModel.h
//  FanweApp
//
//  Created by hzc on 2019/2/20.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTSeatModel.h"
@interface YTAllSeatModel : NSObject
@property (nonatomic, assign) int  driver_type;//1.帝王 2.豪华 3.普通
@property (nonatomic, strong) NSMutableArray<YTSeatModel*>* arr;
@end
