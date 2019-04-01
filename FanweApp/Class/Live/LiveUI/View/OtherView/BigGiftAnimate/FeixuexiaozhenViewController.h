//
//  FeixuexiaozhenViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeixuexiaozhenViewControllerDelegate <NSObject>
@required

- (void)feixuexiaozhenAnimationFinished;

@end

@interface FeixuexiaozhenViewController : UIViewController

@property (nonatomic, weak) id<FeixuexiaozhenViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
