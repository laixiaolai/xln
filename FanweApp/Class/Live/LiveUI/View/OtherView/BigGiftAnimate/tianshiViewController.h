//
//  tianshiViewController.h
//  FanweApp
//
//  Created by Allen on 2019/3/24.
//  Copyright © 2019 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TianshiViewControllerDelegate <NSObject>
@required

- (void)tianshiAnimationFinished;

@end

@interface TianshiViewController : UIViewController

@property (nonatomic, weak) id<TianshiViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
