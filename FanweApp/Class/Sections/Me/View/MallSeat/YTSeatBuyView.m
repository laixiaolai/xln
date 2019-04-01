//
//  YTSeatBuyView.m
//  FanweApp
//
//  Created by hzc on 2019/2/21.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTSeatBuyView.h"
#import "AccountRechargeModel.h"

@interface YTSeatBuyView()
@property (nonatomic, strong) UIImageView* icon;
@property (nonatomic, strong) UILabel* nameLbl;
@property (nonatomic, strong) UIStackView* stackV;
@property (nonatomic, strong) UILabel* priceLbl;
@property(nonatomic,strong)UIButton * btn;
/**
 网络请求
 */
@property (nonatomic, strong) NetHttpsManager *httpsManager;
@property (nonatomic, strong) AccountRechargeModel *model;
@property (nonatomic, assign) NSInteger  payWayID;
//@property(nonatomic,strong)YTSeatModel * seatM;
@property (nonatomic, assign) NSInteger  ruleID;
@end
@implementation YTSeatBuyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    UIView *cover=[[UIView alloc]init];
    cover.backgroundColor=ZCRGBColor(0, 0, 0, 0.5);
    [self addSubview:cover];
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        
    }];
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)]];
    
    UIView *bgView=[[UIView alloc]init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    UIImage *bgImage = [UIImage imageNamed:@"zj_pay_bg"];
    bgView.layer.contents = (id) bgImage.CGImage;
    // 如果需要背景透明加上下面这句
    bgView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    self.icon = [[UIImageView alloc]init];
    self.icon.layer.borderColor=[kAppMainColor CGColor];
    self.icon.layer.cornerRadius=10;
    self.icon.layer.borderWidth=3;
    self.icon.layer.backgroundColor = kWhiteColor.CGColor;
    self.icon.layer.masksToBounds=YES;
    [bgView addSubview:self.icon];
    SafeAreaBottomHeight;
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(kadjust(-36));
        make.height.width.mas_equalTo(kadjust(104));
        make.centerX.equalTo(bgView);
    }];
    
    self.nameLbl=[[UILabel alloc]init];
    self.nameLbl.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:self.nameLbl];
    self.nameLbl.font=[UIFont systemFontOfSize:kadjust(14)];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(kadjust(16));
        make.centerX.equalTo(self.icon);
    }];
    
    self.stackV=[[UIStackView alloc]init];
    [bgView addSubview:self.stackV];
    
    [self.stackV mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(kAdjustRatio(50));
        //        make.right.mas_equalTo(-kAdjustRatio(50));
        //        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.nameLbl.mas_top).offset(35);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    self.stackV.distribution =UIStackViewDistributionEqualSpacing;
    self.stackV.alignment=UIStackViewAlignmentCenter;
    self.stackV.spacing=5;
    
    self.priceLbl=[[UILabel alloc]init];
    self.priceLbl.textAlignment=NSTextAlignmentCenter;
    self.priceLbl.textColor=kAppGrayColor2;
    [bgView addSubview:self.priceLbl];
    self.priceLbl.font=[UIFont systemFontOfSize:kadjust(12)];
    self.priceLbl.layer.borderColor=kAppMainColor.CGColor;
    self.priceLbl.layer.cornerRadius=3;
    self.priceLbl.layer.borderWidth=1;
    self.priceLbl.layer.masksToBounds=YES;
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stackV.mas_bottom).offset(kadjust(10));
        make.centerX.equalTo(self.nameLbl);
        make.height.mas_equalTo(50);
    }];
    
    self.btn =[[UIButton alloc]init];
    self.btn.selected=YES;
    self.btn.titleLabel.font=[UIFont systemFontOfSize:kadjust(14)];
    [self.btn setTitle:@"购买后自动启用该座驾" forState:UIControlStateNormal];
    [self.btn setImage:[UIImage imageNamed:@"com_radio_normal_2"] forState:UIControlStateNormal];
    [self.btn setImage:[UIImage imageNamed:@"com_radio_selected_2"] forState:UIControlStateSelected];
    [self.btn setTitleColor:kAppGrayColor1 forState:UIControlStateNormal];
    [bgView addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(self.priceLbl.mas_bottom).offset(kadjust(10));
    }];
    [self.btn addTarget:self action:@selector(useClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* buyBtn =[[UIButton alloc]init];
    buyBtn.titleLabel.font=[UIFont systemFontOfSize:kadjust(14)];
    [buyBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    buyBtn.backgroundColor = kAppMainColor;
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(self.btn.mas_bottom).offset(kadjust(16));
        make.width.mas_equalTo(kadjust(184));
        make.height.mas_equalTo(kadjust(44));
        make.bottom.mas_equalTo(kadjust(-15-SafeAreaBottomHeight));
    }];
    buyBtn.layer.cornerRadius=kadjust(22);
    buyBtn.layer.masksToBounds=YES;
    [buyBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self loadNet];
}
-(void)buyClick{
    NSString* payID = [NSString stringWithFormat:@"%ld",(long)self.payWayID];
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
    [parmDict setObject:@"driver_pay" forKey:@"ctl"];
    [parmDict setObject:@"pay" forKey:@"act"];
    [parmDict setObject:payID forKey:@"pay_id"];
    [parmDict setObject:@(self.ruleID) forKey:@"rule_id"];
    [parmDict setObject:@(self.btn.selected?1:0) forKey:@"is_enabled"];
    
    self.buyBlock(parmDict);
}
-(void)useClick:(UIButton*)btn{
    btn.selected=!btn.selected;
}
-(void)btnClick{
    [self removeFromSuperview];
}
//-(void)showBuyView:(YTSeatModel *)model{
//    self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.driver_url]];
//    self.nameLbl.text=model.driver_name;
//    self.priceLbl.text=[NSString stringWithFormat:@" %.2lf元/天   ",model.driver_money];
//    self.seatM=model;
//}
-(void)showBuyView:(NSString *)name icon:(NSString *)icon money:(double)money ruleID:(NSInteger)ruleID{
    self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:icon]];
    self.nameLbl.text=name;
    self.priceLbl.text=[NSString stringWithFormat:@" %.2lf元/30天   ",money];
    self.ruleID=ruleID;
}

- (void)loadNet
{
    MJWeakSelf;
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
    [parmDict setObject:@"vip_pay" forKey:@"ctl"];
    [parmDict setObject:@"purchase" forKey:@"act"];
    
    [self.httpsManager POSTWithParameters:parmDict SuccessBlock:^(NSDictionary *responseJson) {
        
        weakSelf.model = [AccountRechargeModel mj_objectWithKeyValues:responseJson];
        if (weakSelf.model.pay_list.count)
        {
            PayTypeModel *model = [weakSelf.model.pay_list firstObject];
            if (model)
            {
                model.isSelect = YES;
            }
        }
        [self setPayTypeButtons];
    } FailureBlock:^(NSError *error) {

    }];
}

-(void)setPayTypeButtons{
    NSInteger num = self.model.pay_list.count;
    CGFloat btnW = ceil((SCREEN_WIDTH -(num+1)*5)/num);
    for (int i=0; i<self.model.pay_list.count; i++) {
        PayTypeModel * subM = self.model.pay_list[i];
        
        UIButton* btn =[[UIButton alloc]init];
        btn.titleLabel.adjustsFontSizeToFitWidth=YES;
        btn.titleLabel.numberOfLines=0;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.layer.borderColor=[kAppMainColor CGColor];
        btn.layer.borderWidth=1;
        btn.layer.cornerRadius=15;
        btn.layer.masksToBounds=YES;
        [btn setTitleColor:kAppMainColor forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setTitle:subM.name forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:kAppMainColor] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(payTypeSelect:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=subM.payWayID ;
        [self.stackV addArrangedSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            //        make.top.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(btnW);
        }];
        [btn.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
        }];
        if (i==0) {
            btn.selected=YES;
            self.payWayID=subM.payWayID;
        }
    }

}
-(void)payTypeSelect:(UIButton*)btn{
    for (UIButton* btn in self.stackV.subviews) {
        btn.selected=NO;
    }
    btn.selected=YES;
    self.payWayID=btn.tag;
}
#pragma mark ------------------------ GET -----------------------
- (NetHttpsManager *)httpsManager
{
    if (!_httpsManager)
    {
        _httpsManager = [NetHttpsManager manager];
    }
    return _httpsManager;
}
@end
