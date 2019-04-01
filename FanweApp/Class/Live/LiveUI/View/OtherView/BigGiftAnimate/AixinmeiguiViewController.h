//
//  AixinmeiguiViewController.h
//  FanweApp
//
//  Created by Allen on 2019/1/29.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AixinmeiguiViewControllerDelegate <NSObject>
@required

- (void)aixinmeiguiAnimationFinished;

@end


@interface AixinmeiguiViewController : UIViewController

@property (nonatomic, weak) id<AixinmeiguiViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *senderNameStr;

@end
