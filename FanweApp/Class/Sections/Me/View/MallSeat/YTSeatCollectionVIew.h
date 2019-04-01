//
//  YTSeatCollectionVIew.h
//  FanweApp
//
//  Created by hzc on 2019/2/19.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTAllSeatModel.h"
@interface YTSeatCollectionVIew : UICollectionView
@property(nonatomic,copy)void (^buyBlock)(YTSeatModel* model);
@property(nonatomic,copy)void (^seeAnimationBlock)(YTSeatModel* model);
-(void)updateView:(NSMutableArray<YTAllSeatModel*>*)arr;

@end
