//
//  YTMySeatCollectionView.h
//  FanweApp
//
//  Created by hzc on 2019/2/19.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTAllMySeatModel.h"
@interface YTMySeatCollectionView : UICollectionView
-(void)updateView:(NSMutableArray<YTAllMySeatModel*>*)arr;
@property(nonatomic,copy)void (^refreshBlock)(void);
@property(nonatomic,copy)void (^buyBlock)(YTMySeatModel* model);
@end
