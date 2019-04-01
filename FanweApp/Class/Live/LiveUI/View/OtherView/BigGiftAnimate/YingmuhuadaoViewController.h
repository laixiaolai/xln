//
//  YingmuhuadaoViewController.h
//  FanweApp
//
//  Created by Allen on 2019/3/26.
//  Copyright © 2019 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YingmuhuadaoViewControllerDelegate <NSObject>
@required

- (void)yingmuhuadaoAnimationFinished;

@end

@interface YingmuhuadaoViewController : UIViewController

@property (nonatomic, weak) id<YingmuhuadaoViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
