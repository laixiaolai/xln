//
//  YTSeatModel.h
//  FanweApp
//
//  Created by hzc on 2019/2/20.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTSeatModel : NSObject
@property (copy, nonatomic) NSString *day_num;
@property (copy, nonatomic) NSString *driver_code;
@property (nonatomic, assign) double  driver_money;
@property (copy, nonatomic) NSString *driver_name;
@property (nonatomic, assign) int  driver_type;
@property (copy, nonatomic) NSString *driver_url;
@property (nonatomic, assign) double  iap_money;
@property (nonatomic, assign) NSInteger  ID;
@property (nonatomic, assign) int  is_effect;
@property (nonatomic, assign) double  money;
@property (nonatomic, assign) NSInteger  product_id;
@property (nonatomic, assign) int  sort;

//自定义属性  是否已经购买
@property (nonatomic, assign) BOOL  hasBuy;
@end
