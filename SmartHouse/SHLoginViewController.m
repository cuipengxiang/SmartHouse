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
    return self;
}

- (void)loginCheck
{
    [self.passwordField resignFirstResponder];
    SHControlViewController *controller = [[SHControlViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:controller animated:YES completion:^(void){
        [self.passwordField setText:nil];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
