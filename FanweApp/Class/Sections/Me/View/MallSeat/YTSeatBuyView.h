//
//  YTSeatBuyView.h
//  FanweApp
//
//  Created by hzc on 2019/2/21.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YTSeatModel.h"
@interface YTSeatBuyView : UIView
//-(void)showBuyView:(YTSeatModel*)model;
@property(nonatomic,copy)void (^buyBlock)(NSMutableDictionary* param);

-(void)showBuyView:(NSString*)name icon:(NSString*)icon money:(double)money ruleID:(NSInteger)ruleID;
@end
