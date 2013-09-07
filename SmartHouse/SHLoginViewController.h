//
//  ViewController.h
//  SmartHouse
//
//  Created by Roc on 13-8-13.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHLoginViewController : UIViewController<UIGestureRecognizerDelegate, UITextFieldDelegate>
{
    UILabel *loginLabel;
}

@property (nonatomic, strong)UITextField *passwordField;
@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UIImageView *loginbox;

- (void)loginCheck;
- (void)onTouch;

@end
