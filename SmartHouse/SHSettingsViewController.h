//
//  SHSettingsViewController.h
//  SmartHouse
//
//  Created by Roc on 13-8-14.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHControlViewController.h"

@interface SHSettingsViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>

@property(nonatomic, strong)UIButton *commit;
@property(nonatomic, strong)UIButton *cancel;
@property(nonatomic, strong)UIView *settingbox;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UITextField *oldpassword;
@property(nonatomic, strong)UITextField *newpassword;
@property(nonatomic, strong)UITextField *newpassword_again;
@property(nonatomic)BOOL isKeybroadShowing;

@property(nonatomic, retain)SHControlViewController *controller;

- (void)onBackButtonClick:(id)sender;
- (void)onCommitClick:(id)sender;
- (void)keyboardWillShow:(NSNotification*)notification;
- (void)keyboardWillHide:(NSNotification*)notification;


@end
