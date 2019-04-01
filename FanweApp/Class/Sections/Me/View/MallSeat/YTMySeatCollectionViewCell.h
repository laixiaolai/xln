//
//  YTMySeatCollectionViewCell.h
//  FanweApp
//
//  Created by hzc on 2019/2/19.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTMySeatModel.h"
@interface YTMySeatCollectionViewCell : UICollectionViewCell
-(void)updateMySeat:(YTMySeatModel*)model;
@property(nonatomic,copy)void (^renewBlock)(NSMutableDictionary* param);
@property(nonatomic,copy)void (^refreshBlock)(void);
@property(nonatomic,copy)void (^buyBlock)(YTMySeatModel* model);
@end
