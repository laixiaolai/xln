//
//  YInComeHeaderView.m
//  FanweApp
//
//  Created by 岳克奎 on 16/8/18.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "YInComeHeaderView.h"

@implementation YInComeHeaderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        //因没实例化，子控件要在from nib 写
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _fanweApp = [GlobalVariables sharedInstance];
    _ticketNum_Lab.textColor = kAppMainColor;
    _moneNum_Lab.textColor = kAppMainColor;
    
    [_ticketNum_Lab setFont:[UIFont systemFontOfSize:46]];
    _ticketName_Lab.text = [NSString stringWithFormat:@"获得%@",_fanweApp.appModel.ticket_name];
    [_moneNum_Lab setFont:[UIFont systemFontOfSize:46]];
    
    _ticketName_Lab.textColor = kAppGrayColor1;
    _moneyName_Lab.textColor = kAppGrayColor1;
    
    _ticketName_Lab.font = [UIFont systemFontOfSize:15];
    _moneyName_Lab.font = [UIFont systemFontOfSize:15];
    
    _sperataor_Lab.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_income_sperataor_Lab"]];
    imageView1.frame = CGRectMake(30,0, kScreenW-60, 1);
    [_sperataor_Lab addSubview:imageView1];
    
    _bottomSeparataor_Gray_Lab.backgroundColor = [UIColor clearColor];
    
    //隐藏
    if ([VersionNum isEqualToString: _fanweApp.appModel.ios_check_version])
    {
        //不要为0，iOS7会出现约束突破问题
        _moneyNumLab_Height_Constraints.constant =0.00001;
        _moneNum_Lab.hidden = YES;
        
        _moneyNameLab_Height_Constraints.constant = 0.00001;
        _moneyName_Lab.hidden = YES;
    }
}

+ (YInComeHeaderView *)createYInComeHeaderViewWithFram:(CGRect)rect
{
    YInComeHeaderView *header_View =[[[NSBundle mainBundle]loadNibNamed:@"YInComeHeaderView" owner:nil options:nil]firstObject];
    header_View.frame = rect;
    return header_View;
}

- (void)setModel:(BingdingStateModel *)model
{
    _model =model;
    if ([_model.ticket isEqual:[NSNull null]]||_model.ticket == nil)
    {
        _ticketNum_Lab.text = @"0";
    }
    else
    {
        _ticketNum_Lab.text =_model.useable_ticket;
    }
    if ([_model.money isEqual:[NSNull null]]||_model.money == nil)
    {
        _moneNum_Lab.text= @"0";
    }
    else
    {
        _moneNum_Lab.text = _model.money;
    }
}

@end
