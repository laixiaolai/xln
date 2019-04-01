//
//  YTAllMySeatModel.m
//  FanweApp
//
//  Created by hzc on 2019/2/22.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTAllMySeatModel.h"

@implementation YTAllMySeatModel
-(NSMutableArray<YTAllMySeatModel *> *)arr{
    if (_arr==nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
@end
