//
//  UpgradeView.m
//  FanweApp
//
//  Created by yy on 16/10/9.
//  Copyright © 2016年 xfg. All rights reserved.
//

#import "UpgradeView.h"

@implementation UpgradeView

+ (instancetype)EditNibFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (IBAction)buttonClick:(UIButton *)sender
{
    if (self.upgradeBlock)
    {
        self.upgradeBlock();
    }
}


@end
