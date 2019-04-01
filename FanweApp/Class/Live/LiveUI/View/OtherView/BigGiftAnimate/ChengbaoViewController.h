//
//  ChengbaoViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChengbaoViewControllerDelegate <NSObject>
@required

- (void)chengbaoAnimationFinished;

@end


@interface ChengbaoViewController : UIViewController

@property (nonatomic, weak) id<ChengbaoViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
