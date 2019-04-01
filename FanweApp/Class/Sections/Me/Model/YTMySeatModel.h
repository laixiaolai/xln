//
//  YTMySeatModel.h
//  FanweApp
//
//  Created by Huang Zhicong on 2019/2/21.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTMySeatModel : NSObject
@property (nonatomic, assign) NSInteger driver_id;

@property (nonatomic, assign) int is_enabled;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *driver_url;

@property (nonatomic, assign) int driver_type;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *driver_expire_time;

@property (nonatomic, copy) NSString *driver_name;

@property (nonatomic, copy) NSString *driver_code;


@end
