//
//  JitaViewController.h
//  FanweApp
//
//  Created by Allen on 2019/3/26.
//  Copyright © 2019 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JitaViewControllerDelegate <NSObject>
@required

- (void)jitaAnimationFinished;

@end

@interface JitaViewController : UIViewController

@property (nonatomic, weak) id<JitaViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
