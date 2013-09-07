//
//  SHSettingsViewController.m
//  SmartHouse
//
//  Created by Roc on 13-8-14.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHSettingsViewController.h"

@interface SHSettingsViewController ()

@end

@implementation SHSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouch)];
    [gesture setNumberOfTouchesRequired:1];
    [gesture setNumberOfTapsRequired:1];
    [gesture setDelegate:self];
    [self.view addGestureRecognizer:gesture];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:30.0]];
    [self.titleLabel setTextColor:[UIColor colorWithRed:0.694 green:0.278 blue:0.020 alpha:1.0]];
    [self.titleLabel setText:@"密码设置"];
    [self.titleLabel sizeToFit];
    [self.titleLabel setFrame:CGRectMake((473 - self.titleLabel.frame.size.width)/2.0, 28, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
    
    self.oldpassword = [[UITextField alloc] initWithFrame:CGRectMake(55, 120, 363, 60)];
    [self.oldpassword setSecureTextEntry:YES];
    [self.oldpassword setPlaceholder:@"输入旧密码"];
    [self.oldpassword setFont:[UIFont systemFontOfSize:20.0]];
    [self.oldpassword setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.oldpassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.oldpassword setTextAlignment:NSTextAlignmentCenter];
    [self.oldpassword setDelegate:self];
    [self.oldpassword setBackground:[UIImage imageNamed:@"input_box"]];
    
    self.newpassword = [[UITextField alloc] initWithFrame:CGRectMake(55, 200, 363, 60)];
    [self.newpassword setSecureTextEntry:YES];
    [self.newpassword setPlaceholder:@"输入新密码"];
    [self.newpassword setFont:[UIFont systemFontOfSize:20.0]];
    [self.newpassword setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.newpassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.newpassword setTextAlignment:NSTextAlignmentCenter];
    [self.newpassword setDelegate:self];
    [self.newpassword setBackground:[UIImage imageNamed:@"input_box"]];
    
    self.newpassword_again = [[UITextField alloc] initWithFrame:CGRectMake(55, 280, 363, 60)];
    [self.newpassword_again setSecureTextEntry:YES];
    [self.newpassword_again setPlaceholder:@"再次输入新密码"];
    [self.newpassword_again setFont:[UIFont systemFontOfSize:20.0]];
    [self.newpassword_again setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.newpassword_again setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.newpassword_again setTextAlignment:NSTextAlignmentCenter];
    [self.newpassword_again setDelegate:self];
    [self.newpassword_again setBackground:[UIImage imageNamed:@"input_box"]];
    
    self.commit = [[UIButton alloc] init];
    [self.commit setBackgroundImage:[UIImage imageNamed:@"btn_commit_normal"] forState:UIControlStateNormal];
    [self.commit setBackgroundImage:[UIImage imageNamed:@"btn_commit_pressed"] forState:UIControlStateHighlighted];
    [self.commit addTarget:self action:@selector(onCommitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancel = [[UIButton alloc] init];
    [self.cancel setBackgroundImage:[UIImage imageNamed:@"btn_cancel_normal"] forState:UIControlStateNormal];
    [self.cancel setBackgroundImage:[UIImage imageNamed:@"btn_cancel_pressed"] forState:UIControlStateHighlighted];
    [self.cancel addTarget:self action:@selector(onBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.settingbox = [[UIView alloc] init];
    [self.settingbox setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"setup_box"]]];
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]]];
        [self.settingbox setFrame:CGRectMake(275.5, 120.0, 473.0, 508.0)];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg_p"]]];
        [self.settingbox setFrame:CGRectMake(147.5, 220.0, 473.0, 508.0)];
    }
    
    [self.commit setFrame:CGRectMake(238.0f, 380.0f, 191.0f, 74.0f)];
    [self.cancel setFrame:CGRectMake(44.0f, 380.0f, 191.0f, 74.0f)];
    [self.settingbox addSubview:self.titleLabel];
    [self.settingbox addSubview:self.oldpassword];
    [self.settingbox addSubview:self.newpassword];
    [self.settingbox addSubview:self.newpassword_again];
    [self.settingbox addSubview:self.cancel];
    [self.settingbox addSubview:self.commit];
    
    [self.view addSubview:self.settingbox];
}

- (void)onBackButtonClick:(id)sender
{
    [self.controller willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1.0];
    [self dismissViewControllerAnimated:YES completion:^(void){
        self.controller.needquery = YES;
    }];
}

- (void)onCommitClick:(id)sender
{
    if (![self.newpassword.text isEqualToString:self.newpassword_again.text]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"两次输入的新密码不一致" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
        return;
    }
    if (self.newpassword.text.length < 4) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码长度不能小于4位" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
        return;
    }
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    if (password) {
        if ([password isEqualToString:[self.oldpassword text]]) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"修改密码成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
            [[NSUserDefaults standardUserDefaults] setObject:self.newpassword.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismissViewControllerAnimated:YES completion:^(void){
                self.controller.needquery = YES;
            }];
        } else {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"旧密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
            return;
        }
    } else {
        if ([[self.oldpassword text] isEqualToString:@"0000"]) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"修改密码成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
            [[NSUserDefaults standardUserDefaults] setObject:self.newpassword.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismissViewControllerAnimated:YES completion:^(void){
                self.controller.needquery = YES;
            }];
        } else {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"旧密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

- (void)onTouch
{
    [self.oldpassword resignFirstResponder];
    [self.newpassword resignFirstResponder];
    [self.newpassword_again resignFirstResponder];
    if (self.oldpassword.text.length == 0) {
        [self.oldpassword setBackground:[UIImage imageNamed:@"input_box"]];
        [self.oldpassword setPlaceholder:@"输入旧密码"];
    }
    if (self.newpassword.text.length == 0) {
        [self.newpassword setBackground:[UIImage imageNamed:@"input_box"]];
        [self.newpassword setPlaceholder:@"输入新密码"];
    }
    if (self.newpassword_again.text.length == 0) {
        [self.newpassword_again setBackground:[UIImage imageNamed:@"input_box"]];
        [self.newpassword_again setPlaceholder:@"再次输入新密码"];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.oldpassword.text.length == 0) {
        [self.oldpassword setBackground:[UIImage imageNamed:@"input_box"]];
        [self.oldpassword setPlaceholder:@"输入旧密码"];
    }
    if (self.newpassword.text.length == 0) {
        [self.newpassword setBackground:[UIImage imageNamed:@"input_box"]];
        [self.newpassword setPlaceholder:@"输入新密码"];
    }
    if (self.newpassword_again.text.length == 0) {
        [self.newpassword_again setBackground:[UIImage imageNamed:@"input_box"]];
        [self.newpassword_again setPlaceholder:@"再次输入新密码"];
    }
    [textField setBackground:[UIImage imageNamed:@"input_box_focused"]];
    [textField setPlaceholder:@""];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [self.settingbox setFrame:CGRectMake(275.5, 120.0, 473.0, 508.0)];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]]];
    } else {
        [self.settingbox setFrame:CGRectMake(147.5, 220.0, 473.0, 508.0)];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg_p"]]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
