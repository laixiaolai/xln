//
//  YoulunViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YoulunViewControllerDelegate <NSObject>
@required

- (void)youlunAnimationFinished;

@end

@interface YoulunViewController : UIViewController

@property (nonatomic, weak) id<YoulunViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
