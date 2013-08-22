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
        //[self setupNavigationBar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.commit = [[UIButton alloc] initWithFrame:CGRectMake(677.0f, 428.0f, 150.0f, 48.0f)];
    [self.commit setBackgroundImage:[UIImage imageNamed:@"bg_btn_commit"] forState:UIControlStateNormal];
    [self.commit setBackgroundImage:[UIImage imageNamed:@"bg_btn_commit"] forState:UIControlStateSelected];
    [self.commit addTarget:self action:@selector(onCommitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commit];
    
    self.cancel = [[UIButton alloc] initWithFrame:CGRectMake(517.0f, 428.0f, 150.0f, 48.0f)];
    [self.cancel setBackgroundImage:[UIImage imageNamed:@"bg_btn_commit"] forState:UIControlStateNormal];
    [self.cancel setBackgroundImage:[UIImage imageNamed:@"bg_btn_commit"] forState:UIControlStateSelected];
    [self.cancel addTarget:self action:@selector(onBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancel];
    
    [self.oldpassword setSecureTextEntry:YES];
    [self.newpassword setSecureTextEntry:YES];
    [self.newpassword_again setSecureTextEntry:YES];
    // Do any additional setup after loading the view from its nib.
}
/*
//设置导航栏
- (void)setupNavigationBar
{
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background_black"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"用户设置"];
    [titleLabel setFont:[UIFont systemFontOfSize:24.0]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel sizeToFit];
    
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [leftButton addTarget:self action:@selector(onBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UINavigationItem *item = [[UINavigationItem alloc] init];
    [item setTitleView:titleLabel];
    [item setLeftBarButtonItem:leftBarButton];
    
    [self.navigationBar pushNavigationItem:item animated:YES];
    [self.view addSubview:self.navigationBar];
}
*/
- (void)onBackButtonClick:(id)sender
{
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
