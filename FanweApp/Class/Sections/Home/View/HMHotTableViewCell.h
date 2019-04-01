//
//  HMHotTableViewCell.h
//  FanweApp
//
//  Created by xfg on 2017/7/5.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMHotItemModel.h"
#import "EdgeInsetsLabel.h"

@protocol HMHotTableViewCellDelegate <NSObject>
@required

/**
 点击跳转到话题

 @param rowIndex 当前行的下标
 */
- (void)pushToTopic:(NSInteger)rowIndex;

/**
 点击用户头像

 @param rowIndex 当前行的下标
 */
- (void)clickUserIcon:(NSInteger)rowIndex;
/**
 点击直播间图片
 
 @param rowIndex 当前行的下标
 */
-(void)clickRoomImg:(NSInteger)rowIndex;
@end

@interface HMHotTableViewCell : UITableViewCell
{
    NSInteger       _rowIndex;
    NSInteger       _rightRowIndex;
}

@property (nonatomic, weak) id<HMHotTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet MenuButton *headImgBtn;
@property (weak, nonatomic) IBOutlet UIImageView *autImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *liveImgView;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *liveStateLabel;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *livePriceLabel;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *gameStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveDecLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noDecLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gameStateSpaceTopLayout;
@property (strong, nonatomic) GlobalVariables           *fanweApp;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *liveStateLabelSpaceTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *liveStateLabelHeight;


@property (weak, nonatomic) IBOutlet MenuButton *rightheadImgBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rightautImgView;
@property (weak, nonatomic) IBOutlet UILabel *rightuserNameLabel;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *rightareaLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightwatchNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightliveImgView;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *rightliveStateLabel;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *rightlivePriceLabel;
@property (weak, nonatomic) IBOutlet EdgeInsetsLabel *rightgameStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightliveDecLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightlineLabel;

- (void)initWidthModel:(HMHotItemModel *)hotItemModel rowIndex:(NSInteger)rowIndex  rightModel:(HMHotItemModel *)rightM rightRowIndex:(NSInteger)rightIndex;

@end
