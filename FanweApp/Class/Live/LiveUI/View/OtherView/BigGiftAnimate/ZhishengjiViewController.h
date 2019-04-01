//
//  ZhishengjiViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZhishengjiViewControllerDelegate <NSObject>
@required

- (void)zhishengjiAnimationFinished;

@end

@interface ZhishengjiViewController : UIViewController

@property (nonatomic, weak) id<ZhishengjiViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
