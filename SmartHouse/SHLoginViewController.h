//
//  ViewController.h
//  SmartHouse
//
//  Created by Roc on 13-8-13.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface SHLoginViewController : UIViewController

@property (nonatomic, strong)UIView *loginView;
@property (nonatomic, strong)UITextField *passwordField;
@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)TPKeyboardAvoidingScrollView *tpView;

- (void)loginCheck;

@end
