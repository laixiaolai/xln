//
//  LevelViewController.m
//  FanweApp
//
//  Created by Allen on 2018/12/25.
//  Copyright © 2018 xfg. All rights reserved.
//

#import "LevelViewController.h"

@interface LevelViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lTitle;
@property (strong, nonatomic) IBOutlet UIProgressView *levelProgress;
@property (strong, nonatomic) IBOutlet UITextView *lTips;

@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的等级";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(comeBack) image:@"com_arrow_vc_back_b" highImage:@"com_arrow_vc_back_b"];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationController.navigationBarHidden =NO;
    self.navigationItem.hidesBackButton = YES;
    
    NSMutableDictionary *parameterDic = [NSMutableDictionary new];
    [parameterDic setValue:@"user_center" forKey:@"ctl"];
    [parameterDic setValue:@"grade" forKey:@"act"];
    [parameterDic setValue:self.userID forKey:@"user_id"];
    [self.httpsManager POSTWithParameters:parameterDic SuccessBlock:^(NSDictionary *responseJson){
        if ([responseJson toInt:@"status"] == 1) {

            _lTitle.text=[responseJson objectForKey:@"leve_name"];
            NSString *u_score = [responseJson objectForKey:@"u_score"];
            NSString *l_score = [responseJson objectForKey:@"l_score"];
            NSString *up_score = [responseJson objectForKey:@"up_score"];
            //设置它的轨道颜色
            _levelProgress.trackTintColor = [UIColor grayColor];
            //设置进度的颜色
            _levelProgress.progressTintColor = kAppMainColor;
            
            float num = [u_score floatValue]-[l_score floatValue];
            float num2 = [up_score floatValue]-[u_score floatValue];
            float num3 = num/num2;
            
            //设置进度条进度的动画
            [_levelProgress setProgress:num3 animated:YES];
            
            UILabel *lScore = [[UILabel alloc] init];
            NSString *str_C = [NSString stringWithFormat:@"%@/%@",u_score,up_score];
            lScore.text  = str_C;
            lScore.textColor=[UIColor grayColor];
            lScore.textAlignment=NSTextAlignmentCenter;
            lScore.numberOfLines = 0;
            
            [lScore setFrame:CGRectMake(0, 10, _levelProgress.frame.size.width, 20)];
            [_levelProgress addSubview:lScore];
            [_lTips setEditable:NO];
        }
    } FailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

    
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回
- (void)comeBack
{
    //    if ([self.type isEqualToString:@"3"]){
    [self.navigationController popViewControllerAnimated:YES];
    //    }else{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //    }
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
