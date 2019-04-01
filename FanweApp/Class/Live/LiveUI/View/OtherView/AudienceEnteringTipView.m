//
//  AudienceEnteringTipView.m
//  FanweApp
//
//  Created by xfg on 16/6/20.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "AudienceEnteringTipView.h"

@implementation AudienceEnteringTipView{
    UIImageView             *_vipImgView;  // vip图标
}

- (id)initWithMyFrame:(CGRect)frame
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"AudienceEnteringTipView" owner:self options:nil] lastObject];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.frame = frame;
        
        //vip图标
        _vipImgView = [[UIImageView alloc]init];
        [_vipImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"lr_vip"]]];
        _vipImgView.frame=CGRectMake(8, 11, 13, 13);
        _vipImgView.hidden=YES;
        _vipImgView.userInteractionEnabled=YES;
        [self addSubview:_vipImgView];
    }
    return self;
}

- (void)setContent:(UserModel *) userModel
{
    [self.rankImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"rank_%@",userModel.user_level]]];
    self.userNameLabel.text = userModel.nick_name;
    
    if([userModel.is_vip isEqualToString:@"1"]){
        _vipImgView.hidden = NO;
        //更改等级图标约束
        self.left.constant=24;
    }
    else{
        _vipImgView.hidden = YES;
        self.left.constant=8;
    }
}

@end
