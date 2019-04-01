//
//  FWTabBarController.m
//  FanweApp
//
//  Created by xfg on 2017/6/26.
//  Copyright © 2017年 xfg. All rights reserved.
//

#import "FWTabBarController.h"
#import "FWTabBar.h"
#import "FWNavigationController.h"
#import "HMHomeViewController.h"
#import "PublishLivestViewController.h"
#import "AgreementViewController.h"
#import "MPersonCenterVC.h"
#import "MSmallVideoVC.h"
#import "ListDayViewController.h"
#import "LeaderboardViewController.h"
#import "SChargerVC.h"
#import "YTMallViewController.h"

@interface FWTabBarController ()<UITabBarControllerDelegate>

@end

@implementation FWTabBarController

FanweSingletonM(Instance);

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    [self setUpChildViewControllers];
}

#pragma mark - 设置子控制器
- (void)setUpChildViewControllers
{
#if kSupportH5Shopping
    
    // 首页
    [self addChildViewController:[[UIViewController alloc] init] image:@"ic_H5_tab_home_un_select" seletedImage:@"ic_H5_tab_home_select" title:@"首页"];
    // 推荐
    [self addChildViewController:[[HMHomeViewController alloc] init] image:@"ic_H5_recommend_un_select" seletedImage:@"ic_H5_recommend_select" title:@"推荐"];
    // 发布直播==》放在FWTabBar里面
    [self setupTabBar];
    // 消息
    IMChat *chatlist = [[IMChat alloc] initWithNibName:@"IMChat" bundle:nil];
    chatlist.mBackBtnHidden = YES;
    [self addChildViewController:chatlist image:@"ic_H5_tab_msg_un_select" seletedImage:@"ic_H5_tab_msg_select" title:@"消息"];
    // 我的
    [self addChildViewController:[[MPersonCenterVC alloc] init] image:@"ic_H5_me_un_select" seletedImage:@"ic_H5_me_select" title:@"我的"];
    
#else
    
    // 首页
    [self addChildViewController:[[HMHomeViewController alloc] init] image:@"ic_live_tab_live_normal" seletedImage:@"ic_live_tab_live_selected" title:nil];
    // 排行榜
    [self addChildViewController:[[LeaderboardViewController alloc] init] image:@"ic_live_tab_rank_normal" seletedImage:@"ic_live_tab_rank_selected" title:nil];
    // 发布直播==》放在FWTabBar里面
    [self setupTabBar];
    // 小视频
    //[self addChildViewController:[[MSmallVideoVC alloc] init] image:@"ic_live_tab_video_normal" seletedImage:@"ic_live_tab_video_selected" title:nil];
    //充值
    [self addChildViewController:[[YTMallViewController alloc] init] image:@"ic_live_tab_video_normal" seletedImage:@"ic_live_tab_video_selected" title:nil];
    // 我的
    [self addChildViewController:[[MPersonCenterVC alloc] init] image:@"ic_live_tab_me_normal"  seletedImage:@"ic_live_tab_me_selected"  title:nil];
    
#endif
}

#pragma mark - 添加子控制器
- (UIViewController *)addChildViewController:(UIViewController *)childController image:(NSString *)image seletedImage:(NSString *)selectedImage title:(NSString *)title
{
    if (![FWUtils isBlankString:title])
    {
        childController.title = title;
        
        NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
        normalAttrs[NSForegroundColorAttributeName] = kAppGrayColor3;
        [childController.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        
        NSMutableDictionary *selectedAtrrs = [NSMutableDictionary dictionary];
        selectedAtrrs[NSForegroundColorAttributeName] = kAppMainColor;
        [childController.tabBarItem setTitleTextAttributes:selectedAtrrs forState:UIControlStateSelected];
    }
    else
    {
        childController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
    
    // 设置图片
    [childController.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [childController.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 导航条
    FWNavigationController *nav = [[FWNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
    return childController;
}

- (void)setupTabBar
{
    FWTabBar *tabbar = [[FWTabBar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
    FWWeakify(self)
    [tabbar setCenterBtnClickBlock:^{
        FWStrongify(self)
        [self onClickedCenterTabBar];
    }];
}

#pragma mark 点击直播
- (void)onClickedCenterTabBar
{
//    以下注释是跳转到中间页面，其中可以选择 发起直播还是发布小视频
//    PopMenuCenter *popMenuCenter = [PopMenuCenter sharePopMenuCenter];
//    [popMenuCenter setTabBarC:self];
//    [popMenuCenter setStPopMenuShowState:STPopMenuShow];
    //直接跳转到开发起直播页面开始直播
    IMALoginParam *loginParam = [IMALoginParam loadFromLocal];
    if (loginParam.isAgree ==1)
    {
        PublishLivestViewController *pvc = [[PublishLivestViewController alloc] init];
        [[AppDelegate sharedAppDelegate] presentViewController:pvc animated:YES completion:^{
            
        }];
    }
    else
    {
        //点击直播按钮默认勾选已阅读协议
        NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
        [parmDict setObject:@"user" forKey:@"ctl"];
        [parmDict setObject:@"agree" forKey:@"act"];
        
        FWWeakify(self)
        
        
        [[NetHttpsManager manager] POSTWithParameters:parmDict SuccessBlock:^(NSDictionary *responseJson)
         {
             FWStrongify(self)
             if ([responseJson toInt:@"status"]==1)
             {
                 IMALoginParam *loginParam = [IMALoginParam loadFromLocal];
                 loginParam.isAgree = 1;
                 [loginParam saveToLocal];
                 
                 PublishLivestViewController *pushVC = [[PublishLivestViewController alloc] init];
                 
                 [self presentViewController:pushVC animated:YES completion:nil];
             }
             
         } FailureBlock:^(NSError *error){
         }];
//        AgreementViewController *agreeVC = [AgreementViewController webControlerWithUrlStr:[GlobalVariables sharedInstance].appModel.agreement_link isShowIndicator:YES isShowNavBar:YES];
//        [[AppDelegate sharedAppDelegate] presentViewController:agreeVC animated:YES completion:^{
//
//        }];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(nonnull UIViewController *)viewController
{
    
#if kSupportH5Shopping
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    if (index == 0)
    {
        [APP_DELEGATE beginEnterMianUI];
        return NO;
    }
    return YES;
#else
    return YES;
#endif
}

@end
