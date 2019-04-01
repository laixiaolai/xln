//
//  YTMallViewController.m
//  FanweApp
//
//  Created by Huang Zhicong on 2018/12/3.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "YTMallViewController.h"
#import "AccountRechargeVC.h"
#import "YTSeatViewController.h"
@interface YTMallViewController ()

@end

@implementation YTMallViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //button 的title
    NSArray *titleArr;
    if ([GlobalVariables sharedInstance].appModel.open_driver) {
        titleArr=@[@"钻石充值",@"座驾商城",@"VIP充值"];
    }else{
        titleArr=@[@"钻石充值",@"VIP充值"];
    }
    
    //对应的子控制器
    NSMutableArray* controllerArr = [NSMutableArray array];
    AccountRechargeVC* diamondVC=[[AccountRechargeVC alloc]init];
    diamondVC.is_vip=NO;
    AccountRechargeVC* vipVC=[[AccountRechargeVC alloc]init];
    vipVC.is_vip=YES;
    [controllerArr addObject:diamondVC];
    if ([GlobalVariables sharedInstance].appModel.open_driver) {
        YTSeatViewController *seatVC =[[YTSeatViewController alloc]init];
        [controllerArr addObject:seatVC];
    }
    [controllerArr addObject:vipVC];
    
    [self setUp:titleArr controllerArr:controllerArr buttonWidth:kScreenW/controllerArr.count];
    [self setTopViewColor:[UIColor grayColor] selectedColor:kAppMainColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置顶部按钮和下划线颜色
    //    [self setTopViewColor:[UIColor grayColor] selectedColor:[UIColor orangeColor]];
    
//    self.navigationItem.title=@"充值";
//    self.navigationController.navigationBar.translucent=YES;    //self.navigationController.navigationBarHidden=YES;
//    // 右上角按钮
//    UIView *rightViewContrainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 73, kNavigationBarHeight)];
//    rightViewContrainer.backgroundColor = kClearColor;
//    
//    UIButton *chatButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 8, 93, 31)];
//    [chatButton setImage:[UIImage imageNamed:@"hm_kefu"] forState:UIControlStateNormal];
//    [chatButton addTarget:self action:@selector(goToLiveChat:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:chatButton];
//    [rightViewContrainer addSubview:chatButton];
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightViewContrainer];
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
////    self.edgesForExtendedLayout = UIRectEdgeNone;
//
//    if (!_is_hasBack) {
//        //self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(returnCenterVC) image:@"com_arrow_vc_back_b" highImage:@"com_arrow_vc_back_b"];
//    }
    // Do any additional setup after loading the view.
}
//跳转到客服聊天浏览器方法
-(void)goToLiveChat:(UIButton *)chatButton{
    GlobalVariables *fanweApp = [GlobalVariables sharedInstance];
    NSString *str = fanweApp.appModel.live_chat_url;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)returnCenterVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden=YES;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden=NO;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
