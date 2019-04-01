//
//  JiebaochaopaoViewController.h
//  FanweApp
//
//  Created by Allen on 2019/3/26.
//  Copyright © 2019 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JiebaochaopaoViewControllerDelegate <NSObject>
@required

- (void)jiebaochaopaoAnimationFinished;

@end

@interface JiebaochaopaoViewController : UIViewController

@property (nonatomic, weak) id<JiebaochaopaoViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
