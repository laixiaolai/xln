//
//  YTMySeatCollectionViewCell.m
//  FanweApp
//
//  Created by hzc on 2019/2/19.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTMySeatCollectionViewCell.h"
@interface YTMySeatCollectionViewCell()
@property (nonatomic, strong) UIImageView* icon;
@property (nonatomic, strong) UILabel* nameLbl;
@property (nonatomic, strong) UILabel* leftTimeLbl;
@property (nonatomic, strong) UILabel* timeLbl;
@property (nonatomic, strong) UILabel* priceLbl;
@property (nonatomic, strong) UIButton* btn;
@property (nonatomic, strong) YTMySeatModel* model;
@property (nonatomic, strong) NetHttpsManager *httpsManager;
@end
@implementation YTMySeatCollectionViewCell
-(void) setUpView{
    self.icon = [[UIImageView alloc]init];
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kadjust(10));
        make.height.width.mas_equalTo(kadjust(80));
        make.left.mas_equalTo(kadjust(10));
    }];
    
    self.nameLbl=[[UILabel alloc]init];
    self.nameLbl.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLbl];
    self.nameLbl.font=[UIFont systemFontOfSize:kadjust(13)];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon);
        make.left.equalTo(self.icon.mas_right).offset(10);
    }];
    
    self.leftTimeLbl=[[UILabel alloc]init];
    self.leftTimeLbl.textColor=[UIColor redColor];
    [self.contentView addSubview:self.leftTimeLbl];
    self.leftTimeLbl.font=[UIFont systemFontOfSize:kadjust(12)];
    [self.leftTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLbl.mas_bottom).offset(kadjust(10));
        make.left.equalTo(self.nameLbl);
    }];
    
    self.btn =[[UIButton alloc]init];
    self.btn.titleLabel.font=[UIFont systemFontOfSize:kadjust(12)];
    [self.btn setTitle:@"使用中" forState:UIControlStateSelected];
    [self.btn setTitle:@"启用" forState:UIControlStateNormal];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"zj_nor_bt"] forState:UIControlStateSelected];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"zj_buy_bt"] forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.icon);
        make.width.mas_equalTo(kadjust(80));
        make.height.mas_equalTo(kadjust(24));
        make.right.mas_equalTo(kadjust(-10));
    }];
    self.btn.layer.cornerRadius=kadjust(12);
    self.btn.layer.masksToBounds=YES;
    [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* line = [[UIView alloc]init];
    line.backgroundColor = kAppGrayColor4;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.icon.mas_bottom).offset(kadjust(10));
    }];
    
    self.timeLbl=[[UILabel alloc]init];
    self.timeLbl.textColor=kAppGrayColor3;
    [self.contentView addSubview:self.timeLbl];
    self.timeLbl.font=[UIFont systemFontOfSize:kadjust(12)];
    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(kadjust(12));
        make.left.equalTo(self.icon);
    }];
    
    self.priceLbl=[[UILabel alloc]init];
    self.priceLbl.textAlignment=NSTextAlignmentCenter;
    self.priceLbl.textColor=kAppMainColor;
    [self.contentView addSubview:self.priceLbl];
    self.priceLbl.font=[UIFont systemFontOfSize:kadjust(12)];
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLbl);
        make.right.mas_equalTo(-15);
        make.left.greaterThanOrEqualTo(self.timeLbl.mas_right).offset(10);
    }];
    [self.priceLbl setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    self.priceLbl.userInteractionEnabled=YES;
    self.priceLbl.text=@"续费";
    [self.priceLbl addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(renewClick)]];
    
    
    UIView* line2 = [[UIView alloc]init];
    line2.backgroundColor = RGBA(230, 230, 230, 1);
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-10);
        //make.right.mas_equalTo(-10);
        make.width.mas_equalTo(kScreenW+12);
        make.height.mas_equalTo(10);
        make.top.equalTo(self.timeLbl.mas_bottom).offset(kadjust(12));
        make.bottom.mas_equalTo(0);
    }];
}

-(void)renewClick{
    self.buyBlock(self.model);
}

-(void)btnClick:(UIButton*)btn{
    if (btn.selected) {
        [FanweMessage alertHUD:@"您已启用该座驾!"];
        return;
    }
    btn.selected=!btn.selected;
    [self useSeat];
}
- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height= size.height;
    cellFrame.size.width = SCREEN_WIDTH-15;
    layoutAttributes.frame= cellFrame;
    return layoutAttributes;
}

-(void)updateMySeat:(YTMySeatModel *)model{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.driver_url]];
    self.nameLbl.text=model.driver_name;
    self.timeLbl.text=[NSString stringWithFormat:@"到期时间：%@",model.driver_expire_time];
    NSDate * offDate = [NSDate getDateFromString:model.driver_expire_time format:@"yyyy-MM-dd HH:mm"];
    NSTimeInterval time = [offDate timeIntervalSinceDate:[NSDate date]];
    int days = ceil(time/(3600 * 24));
    NSString* leftTimeStr ;
    if (days<=0) {
        leftTimeStr = @"已过期";
        self.btn.hidden = YES;
    }else{
        leftTimeStr=[NSString stringWithFormat:@"剩余%d天",days];
        self.btn.hidden = NO;
    }
    self.leftTimeLbl.text = leftTimeStr;
    
    self.btn.selected=model.is_enabled?YES:NO;
    
    self.model=model;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}


-(void)useSeat{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
    [parmDict setObject:@"driver_pay" forKey:@"ctl"];
    [parmDict setObject:@"use_driver" forKey:@"act"];
    [parmDict setObject:@(self.model.driver_id) forKey:@"driver_id"];
    [parmDict setObject:@(self.model.ID) forKey:@"id"];
//    [parmDict setObject:@(isUse) forKey:@"is_enable"];
    [self.httpsManager POSTWithParameters:parmDict SuccessBlock:^(NSDictionary *responseJson)
     {
         if ([responseJson toInt:@"status"] == 1)
         {
             MJRefreshLog(@"%@",responseJson);
             [[GlobalVariables sharedInstance] storageDriverCode:self.model.driver_code ];
             [[GlobalVariables sharedInstance] storageDriverName:self.model.driver_name];
             self.refreshBlock();
         }else
         {
             [FanweMessage alertHUD:[responseJson toString:@"error"]];
         }

     } FailureBlock:^(NSError *error)
     {
         MJRefreshLog(@"error");
     }];
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
