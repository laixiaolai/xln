//
//  ZCMultiSelectView.m
//  FanweApp
//
//  Created by Huang Zhicong on 2019/2/19.
//  Copyright © 2019 xfg. All rights reserved.
//

#import "ZCMultiSelectView.h"
#import "ZCTopSelectView.h"
#import "UIView+UIView_ZCExtension.h"

CGFloat topVHeight=45;
@interface ZCMultiSelectView ()<UIScrollViewDelegate>
@property(nonatomic,strong)ZCTopSelectView * topView;
//@property(nonatomic,weak)id<ZCMultiSelectControllerDelegate> delegate;

/** 用来显示所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
@end
@implementation ZCMultiSelectView

///init方法内部会自动调用-(instancetype)initWithFrame:(CGRect)frame  方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
/**
 * 这个方法专门用来布局子控件，一般在这里设置子控件的frame
 * 当控件本身的尺寸发生改变的时候，系统会自动调用这个方
 */
-(void)layoutSubviews{
    // 一定要调用super方法
    [super layoutSubviews];
    
}


-(void)setUp:(NSArray<NSString*>*)titleArr viewArr:(NSArray<UIView*>*)viewArr buttonWidth:(CGFloat)btnWidth{
    CGFloat SCREENWIDTH = [[UIScreen mainScreen] bounds].size.width;
    CGFloat SCREENHEIGHT = [[UIScreen mainScreen] bounds].size.height;

    __weak typeof(self) wself = self;
    self.topView=[[ZCTopSelectView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, topVHeight)];
    __weak typeof(self) weakSelf = self;
    self.topView.clickBlock = ^(NSInteger index) {
        CGPoint offset = weakSelf.scrollView.contentOffset;
        offset.x = index * self.scrollView.xmg_width;
        [weakSelf.scrollView setContentOffset:offset animated:YES];
        // 子控制器的索引
        NSInteger cIndex = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
        // 取出对应位置的子控制器
        wself.currentView = wself.subviews[cIndex];
    };
    [self.topView setButtonsWithArray:titleArr selectedIndex:0 andButtonWidth:btnWidth];
    [self addSubview:self.topView];
    
    [self setupScrollView:viewArr];
    
    for (NSInteger i=0; i<viewArr.count; i++) {
        [self.scrollView addSubview:viewArr[i]];
    }
    
    // 默认添加一个子控制器的view到scrollView中
//    [self addChildVcViewIntoScrollView];
    
}

/**
 *  添加中间的scrollView
 */
- (void)setupScrollView:(NSArray<UIView*>*)arr
{
    // 不要自动设置内边距
//    if(@available(iOS 11.0,*)){
//        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else{
//
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.bounds;
    
//    CGFloat SCREENHEIGHT = [[UIScreen mainScreen] bounds].size.height;
//    CGFloat Height_NavBar;
//    if (self.navigationController.isNavigationBarHidden||self.navigationController.navigationBar.hidden){
//        Height_NavBar=[[UIApplication sharedApplication] statusBarFrame].size.height;
//    }else{
//        Height_NavBar = [[UIApplication sharedApplication] statusBarFrame].size.height+44;
//    }
    
    scrollView.xmg_y=topVHeight;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
    // 设置scrollView的内容宽度（左右滚动）
    CGSize contentSize = scrollView.contentSize;
    contentSize.width = arr.count * scrollView.frame.size.width;
    scrollView.contentSize = contentSize;
    
    scrollView.pagingEnabled = YES;
    
    self.scrollView = scrollView;
}
/**
 *  添加对应位置的子控制器view到scrollView中
 */
- (void)addChildVcViewIntoScrollView
{
    // 子控制器的索引
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    
    // 取出对应位置的子控件
    UIView *childVc = self.subviews[index];
    self.currentView=childVc;
    // 如果这个子view已经添加过了，那么直接返回
    if (childVc.superview!=nil) return;
    
    // 添加子控制器的view到scrollView
    [self.scrollView addSubview:childVc];
    // 设置子控制器view的frame
    childVc.frame = self.scrollView.bounds;
}


#pragma mark - <UIScrollViewDelegate>
/**
 *  当scrollView停止滚动时调用
 *  前提：通过调用scrollView的以下2个方法导致停止滚动
 - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;
 - (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated;
 */
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
////    [self addChildVcViewIntoScrollView];
//}

/**
 *  当scrollView停止滚动时调用
 *  前提：通过拖拽的方式让scrollView滚动后减速完毕
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 按钮的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.topView btnClick:index];
//    // 添加对应位置的子控制器view到scrollView中
//    [self addChildVcViewIntoScrollView];
}

-(void)setTopViewColor:(UIColor*)color selectedColor:(UIColor*)selectColor{
    [self.topView setTopViewColor:color selectedColor:selectColor];
}
@end
