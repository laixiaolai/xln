//
//  BaseViewController.m
//  CommonLibrary
//
//  Created by Alexi on 14-1-15.
//  Copyright (c) 2014年 CommonLibrary. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>

@interface BaseViewController ()


@end

@implementation BaseViewController

- (void)dealloc
{
    DebugLog(@"======>>>>> [%@] %@ 释放成功 <<<<======", [self class], self);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _fanweApp = [GlobalVariables sharedInstance];
    _httpsManager = [NetHttpsManager manager];
}

- (void)addTapBlankToHideKeyboardGesture;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlankToHideKeyboard:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)onTapBlankToHideKeyboard:(UITapGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateEnded)
    {
        [FWUtils closeKeyboard];
    }
}

- (void)callImagePickerActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    actionSheet.cancelButtonIndex = 2;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if (buttonIndex == 1 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    self.logoImageView.image = info[UIImagePickerControllerEditedImage];
//    isHasLogo = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
//    //显示在最上方
//    [self.view bringSubviewToFront:_HUD];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

