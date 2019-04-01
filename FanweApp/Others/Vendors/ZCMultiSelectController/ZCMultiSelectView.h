//
//  ZCMultiSelectView.h
//  FanweApp
//
//  Created by Huang Zhicong on 2019/2/19.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCMultiSelectView : UIView
@property(nonatomic,strong)UIView * currentView;
-(void)setUp:(NSArray<NSString*>*)titleArr viewArr:(NSArray<UIView*>*)viewArr buttonWidth:(CGFloat)btnWidth;

-(void)setTopViewColor:(UIColor*)color selectedColor:(UIColor*)selectColor;
@end
