//
//  YTSeatCell.m
//  FanweApp
//
//  Created by hzc on 2019/2/18.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTSeatCell.h"
@interface YTSeatCell()
@property (nonatomic, strong) UIImageView* icon;
@property (nonatomic, strong) UILabel* nameLbl;
@property (nonatomic, strong) UILabel* priceLbl;
@property(nonatomic,copy)void (^buyBlock)(void);
@property(nonatomic,copy)void (^seeBlock)(void);
@property (nonatomic, strong) UIButton* btn;
@end
@implementation YTSeatCell
-(void) setUpView{
    self.icon = [[UIImageView alloc]init];
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(kadjust(15));
        make.height.width.mas_equalTo(kadjust(120));
        make.centerX.equalTo(self.contentView);
    }];
    self.icon.userInteractionEnabled=YES;
    [self.icon addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeAnimation)]];
    
    UIImageView* playIcon = [[UIImageView alloc]init];
    playIcon.image=[UIImage imageNamed:@"zj_play"];
    [self.contentView addSubview:playIcon];
    [playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kadjust(11));
        make.width.mas_equalTo(kadjust(18.5));
        make.height.mas_equalTo(kadjust(15.5));
        make.right.mas_equalTo(-20);
    }];
    
    self.nameLbl=[[UILabel alloc]init];
    self.nameLbl.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLbl];
    self.nameLbl.font=[UIFont systemFontOfSize:kadjust(12)];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(kadjust(5));
        make.centerX.equalTo(self.icon);
    }];
    
    self.priceLbl=[[UILabel alloc]init];
    self.priceLbl.textAlignment=NSTextAlignmentCenter;
    self.priceLbl.textColor=kAppMainColor;
    [self.contentView addSubview:self.priceLbl];
    self.priceLbl.font=[UIFont systemFontOfSize:kadjust(12)];
    [self.priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLbl.mas_bottom).offset(kadjust(5));
        make.centerX.equalTo(self.nameLbl);
    }];
    
    self.btn =[[UIButton alloc]init];
    self.btn.titleLabel.font=[UIFont systemFontOfSize:kadjust(12)];
    [self.btn setTitle:@"购买" forState:UIControlStateNormal];
    [self.btn setTitle:@"续费" forState:UIControlStateSelected];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"zj_buy_bt"] forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.priceLbl.mas_bottom).offset(kadjust(5));
        make.width.mas_equalTo(kadjust(120));
        make.height.mas_equalTo(kadjust(30));
        //make.bottom.mas_equalTo(kadjust(-5));
    }];
    self.btn.layer.cornerRadius=kadjust(15);
    self.btn.layer.masksToBounds=YES;
    [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bLine = [[UIView alloc] init];
    bLine.backgroundColor = RGBA(230, 230, 230, 1);
    [self.contentView addSubview:bLine];
    [bLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.btn.mas_bottom).offset(kadjust(12));
        make.width.mas_equalTo(kScreenW/2);
        make.height.mas_equalTo(kadjust(1));
        make.bottom.mas_equalTo(kadjust(0));
    }];
    
}
-(void)seeAnimation{
    self.seeBlock();
}
-(void)btnClick:(UIButton*)btn{
    self.buyBlock();
}
- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height= ceil(size.height);
    cellFrame.size.width = (SCREEN_WIDTH-15)/2;
    layoutAttributes.frame= cellFrame;
    return layoutAttributes;
}
-(void)updateCell:(YTSeatModel *)model buyBlock:(void (^)())buyblock seeAnimationBlock:(void (^)())seeblock{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.driver_url]];
    self.nameLbl.text=model.driver_name;
    self.priceLbl.text=[NSString stringWithFormat:@"%.2lf元/30天",model.driver_money];
    self.btn.selected=model.hasBuy;
    self.buyBlock = ^{
        buyblock();
    };
    self.seeBlock = ^{
        seeblock();
    };
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
