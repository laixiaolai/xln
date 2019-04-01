//
//  FWFUBeautyView.m
//  FanweApp
//
//  Created by hzc on 2018/12/21.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "FWFUBeautyView.h"
@interface FWFUBeautyView()<UIGestureRecognizerDelegate,FUAPIDemoBarDelegate>
@property (nonatomic, strong) UIView *beautyBgView;      // 美颜背景视图
@end
@implementation FWFUBeautyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    self.backgroundColor = [UIColor clearColor];
    self.hidden=YES;
    _beautyBgView = [[UIView alloc]initWithFrame:self.frame];
    _beautyBgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_beautyBgView];
    //添加fu美颜面板
    [self addSubview:self.demoBar];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

#pragma mark  - ----------------------- 单击 -----------------------
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    self.hidden = YES;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == _beautyBgView)
    {
        return YES;
    }
    return NO;
//    if ([touch.view isDescendantOfView:_beautyBgView])
//    {
//        return NO;
//    }
//    return YES;
}
// demobar 初始化
-(FUAPIDemoBar *)demoBar {
    if (!_demoBar) {
        _demoBar = [[FUAPIDemoBar alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 164, self.frame.size.width, 164)];
        
        _demoBar.skinDetect = [FUManager shareManager].skinDetectEnable;
        _demoBar.blurLevel = [FUManager shareManager].blurShape ;
        _demoBar.blurLevel = [FUManager shareManager].blurLevel ;
        _demoBar.colorLevel = [FUManager shareManager].whiteLevel ;
        _demoBar.redLevel = [FUManager shareManager].redLevel;
        _demoBar.eyeBrightLevel = [FUManager shareManager].eyelightingLevel ;
        _demoBar.toothWhitenLevel = [FUManager shareManager].beautyToothLevel ;
        _demoBar.faceShape = [FUManager shareManager].faceShape ;
        _demoBar.enlargingLevel = [FUManager shareManager].enlargingLevel ;
        _demoBar.thinningLevel = [FUManager shareManager].thinningLevel ;
        _demoBar.enlargingLevel_new = [FUManager shareManager].enlargingLevel_new ;
        _demoBar.thinningLevel_new = [FUManager shareManager].thinningLevel_new ;
        _demoBar.chinLevel = [FUManager shareManager].jewLevel ;
        _demoBar.foreheadLevel = [FUManager shareManager].foreheadLevel ;
        _demoBar.noseLevel = [FUManager shareManager].noseLevel ;
        _demoBar.mouthLevel = [FUManager shareManager].mouthLevel ;
        
        _demoBar.filtersDataSource = [FUManager shareManager].filtersDataSource ;
        _demoBar.beautyFiltersDataSource = [FUManager shareManager].beautyFiltersDataSource ;
        _demoBar.filtersCHName = [FUManager shareManager].filtersCHName ;
        _demoBar.selectedFilter = [FUManager shareManager].selectedFilter ;
        _demoBar.performance = NO ;
        _demoBar.delegate = self;
    }
    return _demoBar ;
}

#pragma mark- FUAPIDemoBarDelegate
// 更新美颜参数
- (void)demoBarBeautyParamChanged {
    
    [FUManager shareManager].skinDetectEnable = _demoBar.skinDetect;
    [FUManager shareManager].blurShape = _demoBar.heavyBlur;
    [FUManager shareManager].blurLevel = _demoBar.blurLevel ;
    [FUManager shareManager].whiteLevel = _demoBar.colorLevel;
    [FUManager shareManager].redLevel = _demoBar.redLevel;
    [FUManager shareManager].eyelightingLevel = _demoBar.eyeBrightLevel;
    [FUManager shareManager].beautyToothLevel = _demoBar.toothWhitenLevel;
    [FUManager shareManager].faceShape = _demoBar.faceShape;
    [FUManager shareManager].enlargingLevel = _demoBar.enlargingLevel;
    [FUManager shareManager].thinningLevel = _demoBar.thinningLevel;
    [FUManager shareManager].enlargingLevel_new = _demoBar.enlargingLevel_new;
    [FUManager shareManager].thinningLevel_new = _demoBar.thinningLevel_new;
    [FUManager shareManager].jewLevel = _demoBar.chinLevel;
    [FUManager shareManager].foreheadLevel = _demoBar.foreheadLevel;
    [FUManager shareManager].noseLevel = _demoBar.noseLevel;
    [FUManager shareManager].mouthLevel = _demoBar.mouthLevel;
    
    [FUManager shareManager].selectedFilter = _demoBar.selectedFilter ;
    [FUManager shareManager].selectedFilterLevel = _demoBar.selectedFilterLevel;
}
-(void)dealloc{
    [[FUManager shareManager] destoryItems];
}
@end
