//
//  QiubiteViewController.h
//  FanweApp
//
//  Created by Allen on 2019/3/24.
//  Copyright © 2019 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QiubiteViewControllerDelegate <NSObject>
@required

- (void)qiubiteAnimationFinished;

@end

@interface QiubiteViewController : UIViewController

@property (nonatomic, weak) id<QiubiteViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
