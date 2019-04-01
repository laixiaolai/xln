//
//  HuojianViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HuojianViewControllerDelegate <NSObject>
@required

- (void)huojianAnimationFinished;

@end

@interface HuojianViewController : UIViewController

@property (nonatomic, weak) id<HuojianViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
