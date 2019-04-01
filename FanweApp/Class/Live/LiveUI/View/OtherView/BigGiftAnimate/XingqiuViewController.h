//
//  XingqiuViewController.h
//  FanweApp
//
//  Created by Allen on 2019/3/26.
//  Copyright © 2019 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XingqiuViewControllerDelegate <NSObject>
@required

- (void)xingqiuAnimationFinished;

@end

@interface XingqiuViewController : UIViewController

@property (nonatomic, weak) id<XingqiuViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
