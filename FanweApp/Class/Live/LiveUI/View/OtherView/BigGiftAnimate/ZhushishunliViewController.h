//
//  ZhushishunliViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZhushishunliViewControllerDelegate <NSObject>
@required

- (void)zhushishunliAnimationFinished;

@end

@interface ZhushishunliViewController : UIViewController

@property (nonatomic, weak) id<ZhushishunliViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
