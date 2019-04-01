//
//  QianlichuanqingViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QianlichuanqingViewControllerDelegate <NSObject>
@required

- (void)qianlichuanqingAnimationFinished;

@end

@interface QianlichuanqingViewController : UIViewController

@property (nonatomic, weak) id<QianlichuanqingViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
