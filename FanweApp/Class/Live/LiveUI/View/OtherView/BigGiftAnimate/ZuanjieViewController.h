//
//  ZuanjieViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZuanjieViewControllerDelegate <NSObject>
@required

- (void)zuanjieAnimationFinished;

@end

@interface ZuanjieViewController : UIViewController

@property (nonatomic, weak) id<ZuanjieViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
