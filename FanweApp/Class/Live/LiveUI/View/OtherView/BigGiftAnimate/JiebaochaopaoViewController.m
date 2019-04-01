//
//  JiebaochaopaoViewController.m
//  FanweApp
//
//  Created by Allen on 2019/3/26.
//  Copyright © 2019 Allen. All rights reserved.
//

#import "JiebaochaopaoViewController.h"
#import "SVGA.h"

@interface JiebaochaopaoViewController ()<SVGAPlayerDelegate>
@property (nonatomic, strong) SVGAPlayer *aPlayer;
@end

@implementation JiebaochaopaoViewController{
    UILabel *senderNameLabel;
}

static SVGAParser *parser;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAnimation];
    // Do any additional setup after loading the view.
    senderNameLabel=[[UILabel alloc] init];
    senderNameLabel.frame=CGRectMake(0, 100, kScreenW, 30);
    senderNameLabel.textColor = kTextColorSenderName;
    senderNameLabel.text = @"";
    senderNameLabel.textAlignment = NSTextAlignmentCenter;
    //svga
    /**/
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.aPlayer];
    [self.aPlayer addSubview:senderNameLabel];
    [self.view bringSubviewToFront:senderNameLabel];
    self.aPlayer.delegate = self;
    self.aPlayer.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    self.aPlayer.loops = 1;
    self.aPlayer.clearsAfterStop = YES;
    parser = [[SVGAParser alloc] init];
    
    [parser parseWithNamed:@"jiebaochaopao" inBundle:nil
           completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
               if (videoItem != nil) {
                   self.aPlayer.videoItem = videoItem;
                   [self.aPlayer startAnimation];
               }
           } failureBlock:nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.aPlayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}
-(void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player{
    senderNameLabel.hidden=YES;
}

- (SVGAPlayer *)aPlayer {
    if (_aPlayer == nil) {
        _aPlayer = [[SVGAPlayer alloc] init];
    }
    return _aPlayer;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSString * value = [anim valueForKey:@"moveAnimation"];
    if ([value isEqualToString:@"moveAnimation"]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //淡出效果
            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
            animation.fromValue=[NSNumber numberWithFloat:1.0];
            animation.toValue=[NSNumber numberWithFloat:0];
            animation.repeatCount=1;
            animation.duration=4.0f;
            animation.removedOnCompletion=NO;
            animation.fillMode=kCAFillModeForwards;
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            //animation.autoreverses=YES;
            animation.delegate=self;
            [animation setValue:@"animation1" forKey:@"animation1"];
            [senderNameLabel.layer addAnimation:animation forKey:@"animation1"];
            //移动位置和原始位置一样
            CABasicAnimation * moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
            moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake([[UIScreen mainScreen] bounds].size.width / 2.0f, [[UIScreen mainScreen] bounds].size.height / 2.0f)];
            moveAnimation.duration = 4.3f;
            moveAnimation.removedOnCompletion = NO;
            moveAnimation.fillMode = kCAFillModeForwards;
            moveAnimation.repeatCount = 1;
            moveAnimation.delegate = self;
            [moveAnimation setValue:@"moveAnimation1" forKey:@"moveAnimation1"];
            [senderNameLabel.layer addAnimation:moveAnimation forKey:@"moveAnimation1"];
        });
    }else if([[anim valueForKey:@"moveAnimation1"] isEqualToString:@"moveAnimation1"]){
        
        [senderNameLabel setHidden:YES];
        if (_delegate && [_delegate respondsToSelector:@selector(jiebaochaopaoAnimationFinished)]) {
            [_delegate jiebaochaopaoAnimationFinished];
        }
        [senderNameLabel.layer removeAllAnimations];
        [self.view.layer removeAllAnimations];
        [self.view removeFromSuperview];
    }
}

-(void)setUpAnimation{
    //淡入效果
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.delegate=self;
    [animation setValue:@"animation" forKey:@"animation"];
    [self.view.layer addAnimation:animation forKey:@"animation"];
    CABasicAnimation * moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.delegate = self;
    [moveAnimation setValue:@"moveAnimation" forKey:@"moveAnimation"];
    [self.view.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
}

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
