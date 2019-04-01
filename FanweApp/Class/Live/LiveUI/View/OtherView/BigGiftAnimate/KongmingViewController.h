//
//  KongmingViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KongmingViewControllerDelegate <NSObject>
@required

- (void)kongmingAnimationFinished;

@end

@interface KongmingViewController : UIViewController

@property (nonatomic, weak) id<KongmingViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
