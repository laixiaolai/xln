//
//  HMHotTableViewCell.m
//  FanweApp
//
//  Created by xfg on 2017/7/5.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import "HMHotTableViewCell.h"

@implementation HMHotTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.fanweApp = [GlobalVariables sharedInstance];
    self.headImgBtn.layer.borderWidth = 1;
    self.headImgBtn.layer.borderColor = [kAppGrayColor4 CGColor];
    self.headImgBtn.layer.cornerRadius = CGRectGetWidth(self.headImgBtn.frame) / 2;
    self.headImgBtn.clipsToBounds = YES;

    
    self.userNameLabel.textColor = kAppGrayColor1;
    
    self.areaLabel.backgroundColor = kAppMainColor;
    self.areaLabel.layer.masksToBounds = YES;
    self.areaLabel.edgeInsets = UIEdgeInsetsMake(0 , 8, 0, 8);    // 设置内边距
    self.areaLabel.layer.cornerRadius = 8;
    
    self.watchNumLabel.textColor = kAppGrayColor3;
    
    self.liveStateLabel.layer.borderWidth = 1;
    self.liveStateLabel.clipsToBounds = YES;
    self.liveStateLabel.layer.cornerRadius = 10;
    self.liveStateLabel.layer.borderColor = kWhiteColor.CGColor;
    self.liveStateLabel.textColor = [UIColor whiteColor];
    self.liveStateLabel.backgroundColor = kGrayTransparentColor2_1;
    self.liveStateLabel.edgeInsets = UIEdgeInsetsMake(0 , 15, 0, 15);   // 设置内边距
    [self.liveStateLabel sizeToFit];                                    // 重新计算尺寸
    
    self.livePriceLabel.layer.borderWidth = 1;
    self.livePriceLabel.clipsToBounds = YES;
    self.livePriceLabel.layer.cornerRadius = 10;
    self.livePriceLabel.layer.borderColor = kWhiteColor.CGColor;
    self.livePriceLabel.textColor = [UIColor whiteColor];
    self.liveStateLabel.backgroundColor = kGrayTransparentColor2_1;
    self.liveStateLabel.edgeInsets = UIEdgeInsetsMake(0 , 15, 0, 15);   // 设置内边距
    [self.livePriceLabel sizeToFit];                                    // 重新计算尺寸
    
    self.gameStateLabel.layer.borderWidth = 1;
    self.gameStateLabel.clipsToBounds = YES;
    self.gameStateLabel.layer.cornerRadius = 10;
    self.gameStateLabel.layer.borderColor = kWhiteColor.CGColor;
    self.gameStateLabel.textColor = [UIColor whiteColor];
    self.gameStateLabel.backgroundColor = kGrayTransparentColor2_1;
    self.gameStateLabel.edgeInsets = UIEdgeInsetsMake(0 , 15, 0, 15);   // 设置内边距
    [self.gameStateLabel sizeToFit];                                    // 重新计算尺寸
    
    self.lineLabel.backgroundColor = kBackGroundColor;
    
    self.liveDecLabel.textColor = RGB(167, 167, 167);
    
    
    //右边
    self.rightheadImgBtn.layer.borderWidth = 1;
    self.rightheadImgBtn.layer.borderColor = [kAppGrayColor4 CGColor];
    self.rightheadImgBtn.layer.cornerRadius = CGRectGetWidth(self.rightheadImgBtn.frame) / 2;
    self.rightheadImgBtn.clipsToBounds = YES;
    
    self.rightuserNameLabel.textColor = kAppGrayColor1;
    
    self.rightareaLabel.backgroundColor = kAppMainColor;
    self.rightareaLabel.layer.masksToBounds = YES;
    self.rightareaLabel.edgeInsets = UIEdgeInsetsMake(0 , 8, 0, 8);    // 设置内边距
    self.rightareaLabel.layer.cornerRadius = 8;
    
    self.rightwatchNumLabel.textColor = kAppGrayColor3;
    
    self.rightliveStateLabel.layer.borderWidth = 1;
    self.rightliveStateLabel.clipsToBounds = YES;
    self.rightliveStateLabel.layer.cornerRadius = 10;
    self.rightliveStateLabel.layer.borderColor = kWhiteColor.CGColor;
    self.rightliveStateLabel.textColor = [UIColor whiteColor];
    self.rightliveStateLabel.backgroundColor = kGrayTransparentColor2_1;
    self.rightliveStateLabel.edgeInsets = UIEdgeInsetsMake(0 , 15, 0, 15);   // 设置内边距
    [self.rightliveStateLabel sizeToFit];                                    // 重新计算尺寸
    
    self.rightlivePriceLabel.layer.borderWidth = 1;
    self.rightlivePriceLabel.clipsToBounds = YES;
    self.rightlivePriceLabel.layer.cornerRadius = 10;
    self.rightlivePriceLabel.layer.borderColor = kWhiteColor.CGColor;
    self.rightlivePriceLabel.textColor = [UIColor whiteColor];
    self.rightliveStateLabel.backgroundColor = kGrayTransparentColor2_1;
    self.rightliveStateLabel.edgeInsets = UIEdgeInsetsMake(0 , 15, 0, 15);   // 设置内边距
    [self.rightlivePriceLabel sizeToFit];                                    // 重新计算尺寸
    
    self.rightgameStateLabel.layer.borderWidth = 1;
    self.rightgameStateLabel.clipsToBounds = YES;
    self.rightgameStateLabel.layer.cornerRadius = 10;
    self.rightgameStateLabel.layer.borderColor = kWhiteColor.CGColor;
    self.rightgameStateLabel.textColor = [UIColor whiteColor];
    self.rightgameStateLabel.backgroundColor = kGrayTransparentColor2_1;
    self.rightgameStateLabel.edgeInsets = UIEdgeInsetsMake(0 , 15, 0, 15);   // 设置内边距
    [self.rightgameStateLabel sizeToFit];                                    // 重新计算尺寸
    
    self.rightlineLabel.backgroundColor = kBackGroundColor;
    
    self.rightliveDecLabel.textColor = RGB(167, 167, 167);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)initWidthModel:(HMHotItemModel *)hotItemModel rowIndex:(NSInteger)rowIndex rightModel:(HMHotItemModel *)rightM rightRowIndex:(NSInteger)rightIndex
{
    _rowIndex = rowIndex;
    [self.headImgBtn sd_setImageWithURL:[NSURL URLWithString:hotItemModel.head_image] forState:UIControlStateNormal placeholderImage:kDefaultPreloadHeadImg];
    
    FWWeakify(self)
    [self.headImgBtn setClickAction:^(id<MenuAbleItem> menu) {
        
        FWStrongify(self)
        if ([self.delegate respondsToSelector:@selector(clickUserIcon:)])
        {
            [self.delegate clickUserIcon:_rowIndex];
        }
        
    }];
    
    [self.autImgView sd_setImageWithURL:[NSURL URLWithString:hotItemModel.v_icon] placeholderImage:nil];
    self.userNameLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:hotItemModel.nick_name];
    self.areaLabel.text = hotItemModel.city;
    self.watchNumLabel.text = [NSString stringWithFormat:@"%@ 在看",hotItemModel.watch_number];
    [self.liveImgView sd_setImageWithURL:[NSURL URLWithString:hotItemModel.live_image] placeholderImage:nil];
    self.liveImgView.userInteractionEnabled=YES;
    [self.liveImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToLiveRoomClick:)]];
    if (![FWUtils isBlankString:hotItemModel.title])
    {
        self.liveDecLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:hotItemModel.title];
    }
    
    if (hotItemModel.is_live_pay)
    {
        if (hotItemModel.live_in == FW_LIVE_STATE_ING && [hotItemModel.is_live_pay isEqualToString:@"0"])
        {
            self.livePriceLabel.hidden = YES;
            self.gameStateSpaceTopLayout.constant = 26;
        }
        else if (hotItemModel.live_in == FW_LIVE_STATE_RELIVE && [hotItemModel.is_live_pay isEqualToString:@"0"])
        {
            self.livePriceLabel.hidden = YES;
            self.gameStateSpaceTopLayout.constant = 26;
        }
        else if (hotItemModel.live_in == FW_LIVE_STATE_ING && [hotItemModel.is_live_pay isEqualToString:@"1"])
        {
            self.livePriceLabel.hidden = NO;
            self.gameStateSpaceTopLayout.constant = 52;
            if ([hotItemModel.live_pay_type isEqualToString:@"1"])
            {
                self.livePriceLabel.text = [NSString stringWithFormat:@"%@%@/场",hotItemModel.live_fee,self.fanweApp.appModel.diamond_name];
            }
            else
            {
                self.livePriceLabel.text = [NSString stringWithFormat:@"%@%@/分钟",hotItemModel.live_fee,self.fanweApp.appModel.diamond_name];
            }
        }
        else if (hotItemModel.live_in == FW_LIVE_STATE_RELIVE && [hotItemModel.is_live_pay isEqualToString:@"1"])
        {
            self.livePriceLabel.hidden = NO;
            self.gameStateSpaceTopLayout.constant = 52;
            if ([hotItemModel.live_pay_type isEqualToString:@"1"])
            {
                self.livePriceLabel.text = [NSString stringWithFormat:@"%@%@/场",hotItemModel.live_fee,self.fanweApp.appModel.diamond_name];
            }
            else
            {
                self.livePriceLabel.text = [NSString stringWithFormat:@"%@%@/分钟",hotItemModel.live_fee,self.fanweApp.appModel.diamond_name];
            }
        }
    }
    else
    {
        self.livePriceLabel.hidden = YES;
        self.gameStateSpaceTopLayout.constant = 26;
    }
    
    if (![FWUtils isBlankString:hotItemModel.live_state])
    {
        self.liveStateLabelHeight.constant = 20;
        self.liveStateLabelSpaceTop.constant = 13;
        self.liveStateLabel.hidden = NO;
        self.liveStateLabel.text = hotItemModel.live_state;
    }else
    {
        self.liveStateLabelHeight.constant = 0;
        self.liveStateLabelSpaceTop.constant = 0;
        self.liveStateLabel.hidden = YES;
    }
    
    if ([hotItemModel.title isEqualToString:@""])
    {
        self.liveDecLabel.hidden = YES;
        self.noDecLayout.constant = 0;
    }
    else
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleToTopicVC:)];
        [self.liveDecLabel addGestureRecognizer:tap];
        
        self.liveDecLabel.hidden = NO;
        self.noDecLayout.constant = 42;
    }
    
    if ([hotItemModel.is_gaming isEqualToString:@"1"])
    {
        self.gameStateLabel.hidden = NO;
        if (![FWUtils isBlankString:hotItemModel.game_name])
        {
            self.gameStateLabel.text = hotItemModel.game_name;
        }
    }
    else
    {
        self.gameStateLabel.hidden = YES;
    }
    
    //右边
    if (rightM==nil) {
        self.rightheadImgBtn.hidden=YES;
        self.rightautImgView.hidden=YES;
        self.rightuserNameLabel.hidden=YES;
        self.rightareaLabel.hidden=YES;
        self.rightwatchNumLabel.hidden=YES;
        self.rightliveImgView.hidden=YES;
        self.rightliveStateLabel.hidden=YES;
        self.rightlivePriceLabel.hidden=YES;
        self.rightgameStateLabel.hidden=YES;
        self.rightliveDecLabel.hidden=YES;
        self.rightlineLabel.hidden=YES;
        return;
    }else{
        self.rightheadImgBtn.hidden=NO;
        self.rightautImgView.hidden=NO;
        self.rightuserNameLabel.hidden=NO;
        self.rightareaLabel.hidden=NO;
        self.rightwatchNumLabel.hidden=NO;
        self.rightliveImgView.hidden=NO;
        self.rightliveStateLabel.hidden=NO;
        self.rightlivePriceLabel.hidden=NO;
        self.rightgameStateLabel.hidden=NO;
        self.rightliveDecLabel.hidden=NO;
        self.rightlineLabel.hidden=NO;
    }
    
    _rightRowIndex = rightIndex;
    [self.rightheadImgBtn sd_setImageWithURL:[NSURL URLWithString:rightM.head_image] forState:UIControlStateNormal placeholderImage:kDefaultPreloadHeadImg];
    
    [self.rightheadImgBtn setClickAction:^(id<MenuAbleItem> menu) {
        
        FWStrongify(self)
        if ([self.delegate respondsToSelector:@selector(clickUserIcon:)])
        {
            [self.delegate clickUserIcon:_rightRowIndex];
        }
        
    }];
    
    [self.rightautImgView sd_setImageWithURL:[NSURL URLWithString:rightM.v_icon] placeholderImage:nil];
    self.rightuserNameLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:rightM.nick_name];
    self.rightareaLabel.text = rightM.city;
    self.rightwatchNumLabel.text = [NSString stringWithFormat:@"%@ 在看",rightM.watch_number];
    self.rightliveImgView.userInteractionEnabled=YES;
    [self.rightliveImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToLiveRoomClick:)]];
    [self.rightliveImgView sd_setImageWithURL:[NSURL URLWithString:rightM.live_image] placeholderImage:nil];
    if (![FWUtils isBlankString:rightM.title])
    {
        self.rightliveDecLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:rightM.title];
    }
    
    if (rightM.is_live_pay)
    {
        if (rightM.live_in == FW_LIVE_STATE_ING && [rightM.is_live_pay isEqualToString:@"0"])
        {
            self.rightlivePriceLabel.hidden = YES;
            self.gameStateSpaceTopLayout.constant = 26;
        }
        else if (rightM.live_in == FW_LIVE_STATE_RELIVE && [rightM.is_live_pay isEqualToString:@"0"])
        {
            self.rightlivePriceLabel.hidden = YES;
            self.gameStateSpaceTopLayout.constant = 26;
        }
        else if (rightM.live_in == FW_LIVE_STATE_ING && [rightM.is_live_pay isEqualToString:@"1"])
        {
            self.rightlivePriceLabel.hidden = NO;
            self.gameStateSpaceTopLayout.constant = 52;
            if ([rightM.live_pay_type isEqualToString:@"1"])
            {
                self.rightlivePriceLabel.text = [NSString stringWithFormat:@"%@%@/场",rightM.live_fee,self.fanweApp.appModel.diamond_name];
            }
            else
            {
                self.rightlivePriceLabel.text = [NSString stringWithFormat:@"%@%@/分钟",rightM.live_fee,self.fanweApp.appModel.diamond_name];
            }
        }
        else if (rightM.live_in == FW_LIVE_STATE_RELIVE && [rightM.is_live_pay isEqualToString:@"1"])
        {
            self.rightlivePriceLabel.hidden = NO;
            self.gameStateSpaceTopLayout.constant = 52;
            if ([rightM.live_pay_type isEqualToString:@"1"])
            {
                self.rightlivePriceLabel.text = [NSString stringWithFormat:@"%@%@/场",rightM.live_fee,self.fanweApp.appModel.diamond_name];
            }
            else
            {
                self.rightlivePriceLabel.text = [NSString stringWithFormat:@"%@%@/分钟",rightM.live_fee,self.fanweApp.appModel.diamond_name];
            }
        }
    }
    else
    {
        self.rightlivePriceLabel.hidden = YES;
        self.gameStateSpaceTopLayout.constant = 26;
    }
    
    if (![FWUtils isBlankString:hotItemModel.live_state])
    {
        self.liveStateLabelHeight.constant = 20;
        self.liveStateLabelSpaceTop.constant = 13;
        self.rightliveStateLabel.hidden = NO;
        self.rightliveStateLabel.text = rightM.live_state;
    }else
    {
        self.liveStateLabelHeight.constant = 0;
        self.liveStateLabelSpaceTop.constant = 0;
        self.rightliveStateLabel.hidden = YES;
    }
    
    if ([rightM.title isEqualToString:@""])
    {
        self.rightliveDecLabel.hidden = YES;
        self.noDecLayout.constant = 0;
    }
    else
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleToTopicVC:)];
        [self.rightliveDecLabel addGestureRecognizer:tap];
        
        self.rightliveDecLabel.hidden = NO;
        self.noDecLayout.constant = 42;
    }
    
    if ([rightM.is_gaming isEqualToString:@"1"])
    {
        self.rightgameStateLabel.hidden = NO;
        if (![FWUtils isBlankString:rightM.game_name])
        {
            self.rightgameStateLabel.text = rightM.game_name;
        }
    }
    else
    {
        self.rightgameStateLabel.hidden = YES;
    }
    
    [self layoutIfNeeded];
}

#pragma mark -- 点击话题题目的点击事件
- (void)handleToTopicVC:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(pushToTopic:)])
    {
        if (tap.view == self.liveDecLabel) {
            [self.delegate pushToTopic:_rowIndex];
        }else{
            [self.delegate pushToTopic:_rightRowIndex];
        }
        
    }
}

-(void)goToLiveRoomClick:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(clickRoomImg:)])
    {
        if (tap.view == self.liveImgView) {
            [self.delegate clickRoomImg:_rowIndex];
        }else{
            [self.delegate clickRoomImg:_rightRowIndex];
        }
    }
}

@end
