//
//  HaidiyoulingViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HaidiyoulingViewControllerDelegate <NSObject>
@required

- (void)haidiyoulingAnimationFinished;

@end

@interface HaidiyoulingViewController : UIViewController

@property (nonatomic, weak) id<HaidiyoulingViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
