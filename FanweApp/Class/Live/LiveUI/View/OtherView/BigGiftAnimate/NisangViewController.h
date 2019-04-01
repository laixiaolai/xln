//
//  NisangViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NisangViewControllerDelegate <NSObject>
@required

- (void)nisangAnimationFinished;

@end

@interface NisangViewController : UIViewController

@property (nonatomic, weak) id<NisangViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
