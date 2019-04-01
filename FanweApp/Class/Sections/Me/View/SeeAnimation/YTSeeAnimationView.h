//
//  YTSeeAnimationView.h
//  FanweApp
//
//  Created by hzc on 2019/2/22.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTSeeAnimationView : UIView
-(void)showAnimation:(NSString*)name text:(NSString*)txt;
@property(nonatomic,copy)void (^completeBlock)(void);
-(void)shouldShowCloseBtn:(BOOL)isShow;
@end
