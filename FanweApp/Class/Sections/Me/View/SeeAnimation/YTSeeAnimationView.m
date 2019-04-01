//
//  YTSeeAnimationView.m
//  FanweApp
//
//  Created by hzc on 2019/2/22.
//  Copyright © 2019年 xfg. All rights reserved.
//

#import "YTSeeAnimationView.h"
#import "SVGA.h"
@interface YTSeeAnimationView()<SVGAPlayerDelegate>
@property (nonatomic, strong) SVGAPlayer *aPlayer;

@property (copy, nonatomic) NSString *animationName;
@property (nonatomic, strong) UIButton* btn;
@end
@implementation YTSeeAnimationView{
    UILabel *senderNameLabel;
}
static SVGAParser *parser;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    [self addSubview:self.aPlayer];
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [bgImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zj_lb_bg"]]];
    bgImgView.frame=CGRectMake(0, kScreenH/2-kScreenW*79/1012*6, kScreenW, kScreenW*79/506);
    
    bgImgView.userInteractionEnabled=YES;
    
    [self addSubview:bgImgView];
    //头像圆角背景
    UIImageView *coverImgView = [[UIImageView alloc] init];
    [coverImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zj_cover_head"]]];
    coverImgView.frame=CGRectMake(0, -10, kScreenW*79/506+20, kScreenW*79/506+20);
    [bgImgView addSubview:coverImgView];
    //头像
    UIImageView *headImgView = [[UIImageView alloc] init];
    NSString *head_image = [GlobalVariables sharedInstance].head_image;
    [headImgView sd_setImageWithURL:[NSURL URLWithString:head_image] placeholderImage:kDefaultPreloadHeadImg];
    headImgView.frame=CGRectMake(5, 5, coverImgView.width-10, coverImgView.height-10);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:headImgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:headImgView.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = headImgView.bounds;
    maskLayer.path = maskPath.CGPath;
    headImgView.layer.mask = maskLayer;
    [coverImgView addSubview:headImgView];
    
    senderNameLabel=[[UILabel alloc] init];
    senderNameLabel.frame=CGRectMake(coverImgView.width+5, 0, kScreenW-coverImgView.width-5, kScreenW*79/506);
    senderNameLabel.textColor = kTextColorSenderName;
    senderNameLabel.text = @"";
    senderNameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.backgroundColor = ZCRGBColor(0, 0, 0, 0.3);
    [bgImgView addSubview:senderNameLabel];
    [self bringSubviewToFront:senderNameLabel];
    self.aPlayer.delegate = self;
    self.aPlayer.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    self.aPlayer.loops = 1;
    self.aPlayer.clearsAfterStop = YES;
    parser = [[SVGAParser alloc] init];

    self.btn =[[UIButton alloc]init];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"Animationclose"] forState:UIControlStateNormal];
    [self addSubview:self.btn];
    [self bringSubviewToFront:self.btn];
    self.btn.frame=CGRectMake((SCREEN_WIDTH-30)/2, SCREEN_HEIGHT-StatusHight-30-49, 30, 30);
    [self.btn addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnCloseClick{
    [self.aPlayer stopAnimation];
    [self.aPlayer clear];
    [self removeFromSuperview];
}

-(void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player{
    senderNameLabel.hidden=YES;
    [self btnCloseClick];
    if (self.completeBlock) {
        self.completeBlock();
    }
    
}

- (SVGAPlayer *)aPlayer {
    if (_aPlayer == nil) {
        _aPlayer = [[SVGAPlayer alloc] init];
    }
    return _aPlayer;
}

-(void)showAnimation:(NSString *)name text:(NSString *)txt{
    senderNameLabel.text=txt;
    self.animationName=name;
    self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    self.animationName
    NSString *animationPath = [[NSBundle mainBundle] pathForResource:self.animationName ofType:@"svga"];
    if (animationPath!=nil) {
        [parser parseWithNamed:self.animationName inBundle:nil
               completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
                   if (videoItem != nil) {
                       self.aPlayer.videoItem = videoItem;
                       [self.aPlayer startAnimation];
                   }
               } failureBlock:nil];
    }else{
        [FanweMessage alertHUD:@"暂无本地资源动画!"];
        [self btnCloseClick];
    }
    
}
-(void)shouldShowCloseBtn:(BOOL)isShow{
    self.btn.hidden=!isShow;
}
@end
