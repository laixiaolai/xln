//
//  YTSeatCell.h
//  FanweApp
//
//  Created by hzc on 2019/2/18.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTSeatModel.h"
@interface YTSeatCell : UICollectionViewCell

-(void)updateCell:(YTSeatModel*)model buyBlock:(void(^)())buyblock seeAnimationBlock:(void(^)())seeblock;
@end
