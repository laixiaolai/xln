//
//  YTSeatHeader.m
//  FanweApp
//
//  Created by hzc on 2019/2/19.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTSeatHeader.h"
@interface YTSeatHeader()
@property (nonatomic, strong) UILabel* lbl;
@end
@implementation YTSeatHeader

///init方法内部会自动调用-(instancetype)initWithFrame:(CGRect)frame  方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

-(void) setUpView{
    self.backgroundColor=ZCRGBColor(230, 230, 230, 1);
    UIImageView* icon =[[UIImageView alloc]init];
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(15);
    }];
    icon.image = [UIImage imageWithColor:kAppMainColor];
    
    self.lbl=[[UILabel alloc]init];
    [self addSubview:self.lbl];
    self.lbl.font=[UIFont systemFontOfSize:kadjust(14)];
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(icon.mas_right).offset(5);
    }];
    
}

-(void)updateCell:(NSString *)txt{
    self.lbl.text=txt;
}

@end
