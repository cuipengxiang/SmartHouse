//
//  ViewController.m
//  SmartHouse
//
//  Created by Roc on 13-8-13.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHLoginViewController.h"
#import "SHControlViewController.h"

@implementation SHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)loginCheck
{
    [self.passwordField resignFirstResponder];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    if (password) {
        if ([password isEqualToString:[self.passwordField text]]) {
            SHControlViewController *controller = [[SHControlViewController alloc] initWithNibName:nil bundle:nil];
            [self presentViewController:controller animated:YES completion:^(void){
                [self.passwordField setText:nil];
            }];
        } else {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }
    } else {
        if ([[self.passwordField text] isEqualToString:@"0000"]) {
            SHControlViewController *controller = [[SHControlViewController alloc] initWithNibName:nil bundle:nil];
            [self presentViewController:controller animated:YES completion:^(void){
                [self.passwordField setText:nil];
            }];
        } else {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024, 748)];
    [self.imageView setImage:[UIImage imageNamed:@"bg_login"]];
    [self.view addSubview:self.imageView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouch)];
    [gesture setNumberOfTouchesRequired:1];
    [gesture setNumberOfTapsRequired:1];
    [gesture setDelegate:self];
    [self.view addGestureRecognizer:gesture];
    
	UILabel *loginLabel = [[UILabel alloc] init];
    [loginLabel setBackgroundColor:[UIColor clearColor]];
    [loginLabel setTextAlignment:NSTextAlignmentCenter];
    [loginLabel setFont:[UIFont systemFontOfSize:42.0]];
    [loginLabel setTextColor:[UIColor whiteColor]];
    [loginLabel setText:@"智能家居系统"];
    [loginLabel sizeToFit];
    [loginLabel setFrame:CGRectMake((1024 - loginLabel.frame.size.width)/2.0, 100, loginLabel.frame.size.width, loginLabel.frame.size.height)];
    [self.view addSubview:loginLabel];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(360, 313, 305, 50)];
    [self.passwordField setSecureTextEntry:YES];
    [self.passwordField setPlaceholder:@"请输入密码"];
    [self.passwordField setFont:[UIFont systemFontOfSize:20.0]];
    [self.passwordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.passwordField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.passwordField setTextAlignment:NSTextAlignmentCenter];
    [self.passwordField setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.passwordField];
    
    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"bg_btn_login"] forState:UIControlStateNormal];
    [self.loginButton sizeToFit];
    [self.loginButton setFrame:CGRectMake((1024 - self.loginButton.frame.size.width)/2.0, 396, self.loginButton.frame.size.width, self.loginButton.frame.size.height)];
    [self.loginButton addTarget:self action:@selector(loginCheck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if ((toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)||(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)) {
        return YES;
    }
    return NO;
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
    [self.passwordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
