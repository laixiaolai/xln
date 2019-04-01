//
//  YTSeatViewController.m
//  FanweApp
//
//  Created by hzc on 2019/2/18.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTSeatViewController.h"
#import "ZCTopSelectView.h"
#import "YTSeatCollectionVIew.h"
#import "ZCMultiSelectView.h"
#import "YTMySeatCollectionView.h"
#import "NSObject+AutoProperty.h"
#import "YTAllSeatModel.h"
#import "YTSeatBuyView.h"
#import "Pay_Model.h"
#import "JuBaoModel.h"
#import <StoreKit/StoreKit.h>
#import "FWInterface.h"
#import "YTAllMySeatModel.h"
#import "YTSeeAnimationView.h"
@interface YTSeatViewController ()<FWInterfaceDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>
/**
 网络请求
 */
@property (nonatomic, strong) NetHttpsManager *httpsManager;
@property (nonatomic, strong) YTSeatCollectionVIew* mallV;
@property(nonatomic,strong)YTMySeatCollectionView * myV;
@property (nonatomic, strong) JuBaoModel * juBaoModel;
@property (nonatomic, strong) NSString *pro_id;
@property (nonatomic, strong) SKProductsRequest * request;

@property (nonatomic, strong) NSArray<YTSeatModel*>* seatArr;
@end
//CGFloat topVHeight = 45;
@implementation YTSeatViewController
-(void)loadView{
    self.view = [[ZCMultiSelectView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-StatusHight-45)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    MJWeakSelf;
    //button 的title
    NSArray *titleArr=@[@"座驾商城",@"我的座驾"];
    
    //对应的子view
    NSMutableArray* viewArr = [NSMutableArray array];
    self.mallV = [[YTSeatCollectionVIew alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusHight-45-45-49)];
    self.mallV.buyBlock = ^(YTSeatModel *model) {
        YTSeatBuyView* buyV = [[YTSeatBuyView alloc]init];
        [buyV showBuyView:model.driver_name icon:model.driver_url money:model.money ruleID:model.ID];
        buyV.buyBlock = ^(NSMutableDictionary *param) {
            [weakSelf buySeat:param];
        };
    };
    self.mallV.seeAnimationBlock = ^(YTSeatModel *model) {
        YTSeeAnimationView* seeV=[[YTSeeAnimationView alloc]init];
        NSString* myName = [GlobalVariables sharedInstance].nick_name;
        [seeV showAnimation:model.driver_code text:[NSString stringWithFormat:@"%@乘坐【%@】来了",myName,model.driver_name]];
    };
    
    self.myV =[[YTMySeatCollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusHight-45-45-49)];
    self.myV.refreshBlock = ^{
        [weakSelf.myV.mj_header beginRefreshing];
    };
    self.myV.buyBlock = ^(YTMySeatModel *model) {
        YTSeatBuyView* buyV = [[YTSeatBuyView alloc]init];
        [buyV showBuyView:model.driver_name icon:model.driver_url money:[weakSelf getSeatModel:model].money ruleID:[weakSelf getSeatModel:model].ID];
        buyV.buyBlock = ^(NSMutableDictionary *param) {
            [weakSelf buySeat:param];
        };
    };
    [viewArr addObject:self.mallV];
    [viewArr addObject:self.myV];

    ZCMultiSelectView* selectV = (ZCMultiSelectView*)self.view;
    
    [selectV setUp:titleArr viewArr:viewArr buttonWidth:kScreenW/2];
    [selectV setTopViewColor:[UIColor grayColor] selectedColor:kAppMainColor];
    
    self.mallV.mj_header=[MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf getAllSeat];
    }];
    [self.mallV.mj_header beginRefreshing];
    
    self.myV.mj_header=[MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf getAllSeat];
    }];

//    ZCTopSelectView* topV = [[ZCTopSelectView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topVHeight)];
//    [topV setTopViewColor:[UIColor grayColor] selectedColor:kAppMainColor];
//    [self.view addSubview:topV];
//    [topV setButtonsWithArray:@[@"座驾商城",@"我的商城"] selectedIndex:0 andButtonWidth:(SCREEN_WIDTH/2)];
//    topV.clickBlock = ^(NSInteger index) {
//
//    };
//
//    YTSeatCollectionVIew* mallV = [[YTSeatCollectionVIew alloc]init];
//    [self.view addSubview:mallV];
//    [mallV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.top.equalTo(topV.mas_bottom);
//    }];
    
    // Do any additional setup after loading the view.
}
-(void)getAllSeat{
    MJWeakSelf;
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
    [parmDict setObject:@"driver_pay" forKey:@"ctl"];
    [parmDict setObject:@"purchase" forKey:@"act"];
    [self.httpsManager POSTWithParameters:parmDict SuccessBlock:^(NSDictionary *responseJson)
     {
         if ([responseJson toInt:@"status"] == 1)
         {
             MJRefreshLog(@"%@",responseJson);
             NSArray<YTSeatModel*>* seatArr = [YTSeatModel mj_objectArrayWithKeyValuesArray:responseJson[@"rule_list"]];
             self.seatArr=seatArr;
             NSArray<YTMySeatModel*>* myArr = [YTMySeatModel mj_objectArrayWithKeyValuesArray:responseJson[@"user_driver_list"]];
             for (YTMySeatModel* myModel in myArr) {//判断座驾是否已经被购买
                 for (YTSeatModel* model in seatArr) {
                     if ([model.driver_code isEqualToString:myModel.driver_code]) {
                         model.hasBuy=YES;
                         break;
                     }
                 }
             }
             
             NSMutableArray<YTAllSeatModel*>* newArr = [weakSelf sortArr:seatArr];
             [self.mallV updateView:newArr];
             
             NSMutableArray<YTAllMySeatModel*>* newMyArr = [weakSelf sortMyArr:myArr];
             [self.myV updateView:newMyArr];
             
         }else
         {
             [FanweMessage alertHUD:[responseJson toString:@"error"]];
         }
         [self.mallV.mj_header endRefreshing];
         [self.myV.mj_header endRefreshing];
     } FailureBlock:^(NSError *error)
     {
         MJRefreshLog(@"error");
         [self.mallV.mj_header endRefreshing];
         [self.myV.mj_header endRefreshing];
     }];
}
-(YTSeatModel*)getSeatModel:(YTMySeatModel*)model{
    for (YTSeatModel* subm in self.seatArr) {
        if ([subm.driver_code isEqualToString:model.driver_code]) {
            return subm;
        }
    }
    return [[YTSeatModel alloc]init];
}
//-(void)getMySeat{
//    MJWeakSelf;
//    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
//    [parmDict setObject:@"driver_pay" forKey:@"ctl"];
//    [parmDict setObject:@"get_user_driver" forKey:@"act"];
//    [self.httpsManager POSTWithParameters:parmDict SuccessBlock:^(NSDictionary *responseJson)
//     {
//         if ([responseJson toInt:@"status"] == 1)
//         {
//             MJRefreshLog(@"%@",responseJson);
//             NSArray<YTSeatModel*>* seatArr = [YTSeatModel mj_objectArrayWithKeyValuesArray:responseJson[@"get_user_driver"]];
//             NSMutableArray<YTAllSeatModel*>* newArr = [weakSelf sortArr:seatArr];
//             [self.mallV updateView:newArr];
//         }else
//         {
//             [FanweMessage alertHUD:[responseJson toString:@"error"]];
//         }
//         [self.mallV.mj_header endRefreshing];
//     } FailureBlock:^(NSError *error)
//     {
//         MJRefreshLog(@"error");
//         [self.mallV.mj_header endRefreshing];
//     }];
//}


-(NSMutableArray<YTAllSeatModel*>*)sortArr:(NSArray<YTSeatModel*>*)arr{
    NSMutableArray<YTAllSeatModel*>* newArr = [NSMutableArray array];
    for (YTSeatModel* seat in arr) {
        BOOL isExist = NO;
        for (YTAllSeatModel* allSeat in newArr) {
            if (allSeat.driver_type==seat.driver_type) {
                [allSeat.arr addObject:seat];
                isExist=YES;
                break;
            }
        }
        if (!isExist) {
            YTAllSeatModel * allSeat = [[YTAllSeatModel alloc]init];
            allSeat.driver_type = seat.driver_type;
            [allSeat.arr addObject:seat];
            [newArr addObject:allSeat];
        }
    }
    return newArr;
}
-(NSMutableArray<YTAllMySeatModel*>*)sortMyArr:(NSArray<YTMySeatModel*>*)arr{
    NSMutableArray<YTAllMySeatModel*>* newArr = [NSMutableArray array];
    for (YTMySeatModel* seat in arr) {
        BOOL isExist = NO;
        for (YTAllMySeatModel* allSeat in newArr) {
            if (allSeat.driver_type==seat.driver_type) {
                [allSeat.arr addObject:seat];
                isExist=YES;
                break;
            }
        }
        if (!isExist) {
            YTAllMySeatModel * allSeat = [[YTAllMySeatModel alloc]init];
            allSeat.driver_type = seat.driver_type;
            [allSeat.arr addObject:seat];
            [newArr addObject:allSeat];
        }
    }
    return newArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 支付相关
-(void)buySeat:(NSMutableDictionary*)parmDict{
    MJWeakSelf;
    [weakSelf.httpsManager POSTWithParameters:parmDict SuccessBlock:^(NSDictionary *responseJson)
     {
         if ([responseJson toInt:@"status"]==1)
         {
             NSDictionary *payDic =[responseJson objectForKey:@"pay"];
             NSDictionary *sdkDic =[payDic objectForKey:@"sdk_code"];
             NSString *sdkType =[sdkDic objectForKey:@"pay_sdk_type"];
             if ([sdkType isEqualToString:@"alipay"])
             {
                 //支付宝支付
                 NSDictionary *configDic =[sdkDic objectForKey:@"config"];
                 Pay_Model * model2 =[Pay_Model mj_objectWithKeyValues: configDic];
                 NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",model2.order_spec, model2.sign, model2.sign_type];
                 [weakSelf alipay:orderString block:nil];
             }
             else if ([sdkType isEqualToString:@"wxpay"])
             {
                 //微信支付
                 NSDictionary *configDic =[payDic objectForKey:@"config"];
                 NSDictionary *iosDic =[configDic objectForKey:@"ios"];
                 Mwxpay * wxmodel =[Mwxpay mj_objectWithKeyValues: iosDic];
                 PayReq* req = [[PayReq alloc] init];
                 req.openID = wxmodel.appid;
                 req.partnerId = wxmodel.partnerid;
                 req.prepayId = wxmodel.prepayid;
                 req.nonceStr = wxmodel.noncestr;
                 req.timeStamp = [wxmodel.timestamp intValue];
                 req.package = wxmodel.package;
                 req.sign = wxmodel.sign;
                 [WXApi sendReq:req];
             }
             else if ([sdkType isEqualToString:@"JubaoWxsdk"] || [sdkType isEqualToString:@"JubaoAlisdk"])
             {
                 NSDictionary *configDic =[sdkDic objectForKey:@"config"];
                 _juBaoModel = [JuBaoModel mj_objectWithKeyValues: configDic];
                 FWParam *param = [[FWParam alloc] init];
                 // playerid：用户在第三方平台上的用户名
                 param.playerid  = _juBaoModel.playerid;
                 // goodsname：购买商品名称
                 param.goodsname = _juBaoModel.goodsname;
                 // amount：购买商品价格，单位是元
                 param.amount    = _juBaoModel.amount;
                 // payid：第三方平台上的订单号，请传真实订单号，方便后续对账，例子里采用随机数，
                 param.payid     = _juBaoModel.payid;
                 
                 [FWInterface start:weakSelf withParams:param  withDelegate:weakSelf];
                 //[FWInterface start:self withParams:param withType:model.withType withDelegate:self];
                 // 凡伟支付 end
                 
             }
             else if ([sdkType isEqualToString:@"iappay"])
             {
                 [SVProgressHUD showWithStatus:@"正在提交iTunes Store,请等待..."];
                 // 监听购买结果
                 [[SKPaymentQueue defaultQueue] addTransactionObserver:weakSelf];
                 NSMutableDictionary *configDic = [NSMutableDictionary new];
                 configDic = sdkDic[@"config"];
                 weakSelf.pro_id = configDic[@"product_id"];
                 //查询是否允许内付费
                 if ([SKPaymentQueue canMakePayments])
                 {
                     // 执行下面提到的第5步：
                     [weakSelf getProductInfowithprotectId:weakSelf.pro_id];
                 }
                 else
                 {
                     [FanweMessage alert:@"您已禁止应用内付费购买商品"];
                 }
             }
             else if ([payDic toInt:@"is_wap"] == 1)
             {
                 if ([payDic toInt:@"is_without"] == 1) // 跳转外部浏览器
                 {
                     NSURL *url=[NSURL URLWithString:[payDic stringForKey:@"url"]];
                     [[UIApplication sharedApplication] openURL:url];
                 }
                 else
                 {
                     FWMainWebViewController *vc = [FWMainWebViewController webControlerWithUrlStr:[payDic stringForKey:@"url"] isShowIndicator:YES isShowNavBar:YES isShowBackBtn:YES];
                     [[AppDelegate sharedAppDelegate] pushViewController:vc];
                 }
             }
             else
             {
                 NSLog(@"错误");
             }
         }
         else
         {
             NSLog(@"请求失败");
         }
         
     }FailureBlock:^(NSError *error){
         
         [SVProgressHUD dismiss];
         
     }];
}
#pragma marlk  支付宝支付
     - (void)alipay:(NSString*)payinfo  block:(void(^)(SResBase* resb))block
     {
         NSString *appScheme = AlipayScheme;
         
         [[AlipaySDK defaultService] payOrder:payinfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
             
             SResBase* retobj = nil;
             
             if ( resultDic )
             {
                 if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                 {
                     retobj = [[SResBase alloc]init];
                     retobj.msuccess = YES;
                     retobj.mmsg = @"支付成功";
                     retobj.mcode = 1;
                     //                block(retobj);
                     [FanweMessage alert:[NSString stringWithFormat:@"%@",retobj.mmsg]];
                     
                     [self reloadAcount];
                 }
                 else
                 {
                     retobj = [SResBase infoWithString: [resultDic objectForKey:@"memo" ]];
                     [FanweMessage alert:@"支付失败"];
                 }
             }
             else
             {
                 retobj = [SResBase infoWithString: @"支付出现异常"];
                 [FanweMessage alert:@"支付异常"];
             }
             
         }];
     }
     
#pragma mark -- 苹果内购服务，下面的ProductId应该是事先在itunesConnect中添加好的，已存在的付费项目。否则查询会失败。
     - (void)getProductInfowithprotectId:(NSString *)proId
     {
         //这里填你的产品id，根据创建的名字
         //ProductIdofvip
         //ProductId
         NSMutableArray *proArr = [NSMutableArray new];
         [proArr addObject:proId];
         NSSet * set = [NSSet setWithArray:proArr];
         
         self.request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
         self.request.delegate = self;
         [self.request start];
         
         NSLog(@"%@",set);
         NSLog(@"请求开始请等待...");
     }

#pragma marlk 刷新账户
- (void)reloadAcount
{
    NSMutableDictionary *parmDict = [NSMutableDictionary dictionary];
    [parmDict setObject:@"vip_pay" forKey:@"ctl"];
    [parmDict setObject:@"purchase" forKey:@"act"];

    __weak YTSeatViewController *weakSelf = self;
    [self.httpsManager POSTWithParameters:parmDict SuccessBlock:^(NSDictionary *responseJson)
     {
         if ((NSNull *)responseJson != [NSNull null])
         {
             
         }
     } FailureBlock:^(NSError *error)
     {
     }];
}
#pragma mark - others SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
                NSLog(@"transactionIdentifier = %@", transaction.transactionIdentifier);
                [SVProgressHUD dismiss];
                [self completeTransaction:transaction];
                //[queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                NSLog(@"交易失败");
                [self failedTransaction:transaction];
                //[queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://恢复已购买商品
                NSLog(@"恢复已购买商品");
                [self restoreTransaction:transaction];
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing://商品添加进列表
                NSLog(@"商品添加进列表");
                break;
            default:
                break;
        }
    }
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    // Your application should implement these two methods.
    NSLog(@"---------进入了这里");
    //    NSString * productIdentifier = transaction.payment.productIdentifier;
    NSString * productIdentifier = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    NSData *data = [productIdentifier dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    if ([productIdentifier length] > 0) {
        // 向自己的服务器验证购买凭证
        [self shoppingValidation:base64String];
    }
    // Remove the transaction from the payment queue.
    [SVProgressHUD dismiss];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    [SVProgressHUD dismiss];
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"购买失败");
    }
    else
    {
        NSLog(@"用户取消交易");
        //[FanweMessage alert:@"您已经取消交易"];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    // 对于已购商品，处理恢复购买的逻辑
    //[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}
#pragma mark -- 向自己的服务器验证购买凭证
- (void)shoppingValidation : (NSString *)base64Str
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:@"vip_pay" forKey:@"ctl"];
    [dict setObject:@"iappay" forKey:@"act"];
    NSString *userid = [IMAPlatform sharedInstance].host.imUserId;
    [dict setObject:userid forKey:@"user_id"];
    [dict setObject:base64Str forKey:@"receipt-data"];
    [self.httpsManager POSTWithParameters:dict SuccessBlock:^(NSDictionary *responseJson) {
        [self reloadAcount];
        // [FanweMessage alert:@"充值成功"];
    } FailureBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 以上查询的回调函数，以上查询的回调函数
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *myProduct = response.products;
    if (myProduct.count == 0)
    {
        [FanweMessage alert:@"无法获取产品信息，购买失败。"];
        [SVProgressHUD dismiss];
        return;
    }
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[myProduct count]);
    SKPayment * payment = [SKPayment paymentWithProduct:myProduct[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
#pragma mark- FWInterfaceDelegate
// 支付结果的通知：
- (void)receiveResult:(NSString*)payid result:(BOOL)success message:(NSString*)message
{
    if ( success == YES )
    {
        [self reloadAcount];
        [FanweMessage alert:@"支付成功"];
    }
    else
    {
        [FanweMessage alert:@"支付失败"];
    }
}
- (void)receiveChannelTypes:(NSArray<NSNumber *>*)types
{
    [FWInterface selectChannel:_juBaoModel.withType];
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
