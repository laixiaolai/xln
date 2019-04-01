//
//  JiaziguViewController.h
//  FanweApp
//
//  Created by Allen on 2019/3/26.
//  Copyright © 2019 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JiaziguViewControllerDelegate <NSObject>
@required

- (void)jiaziguAnimationFinished;

@end

@interface JiaziguViewController : UIViewController

@property (nonatomic, weak) id<JiaziguViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
