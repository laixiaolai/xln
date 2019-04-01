//
//  FalaliViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FalaliViewControllerDelegate <NSObject>
@required

- (void)falaliAnimationFinished;

@end

@interface FalaliViewController : UIViewController

@property (nonatomic, weak) id<FalaliViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
