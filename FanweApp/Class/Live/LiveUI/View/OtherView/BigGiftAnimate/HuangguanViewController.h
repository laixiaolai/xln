//
//  HuangguanViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HuangguanViewControllerDelegate <NSObject>
@required

- (void)huangguanAnimationFinished;

@end

@interface HuangguanViewController : UIViewController

@property (nonatomic, weak) id<HuangguanViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
