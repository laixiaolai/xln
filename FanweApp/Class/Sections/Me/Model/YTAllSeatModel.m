//
//  YTAllSeatModel.m
//  FanweApp
//
//  Created by hzc on 2019/2/20.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTAllSeatModel.h"

@implementation YTAllSeatModel
-(NSMutableArray<YTSeatModel *> *)arr{
    if (_arr==nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
@end
