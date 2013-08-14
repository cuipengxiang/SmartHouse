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
        self.tpView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.tpView];
        self.loginView = [[UIView alloc] initWithFrame:CGRectMake(312, 234, 400, 300)];
        [self.loginView setBackgroundColor:[UIColor blueColor]];
        [self.tpView addSubview:self.loginView];
        
        UILabel *loginLabel = [[UILabel alloc] init];
        [loginLabel setBackgroundColor:[UIColor clearColor]];
        [loginLabel setTextAlignment:NSTextAlignmentCenter];
        [loginLabel setFont:[UIFont systemFontOfSize:40.0]];
        [loginLabel setTextColor:[UIColor whiteColor]];
        [loginLabel setText:@"登 录"];
        [loginLabel sizeToFit];
        [loginLabel setFrame:CGRectMake((400 - loginLabel.frame.size.width)/2.0, 20, loginLabel.frame.size.width, loginLabel.frame.size.height)];
        [self.loginView addSubview:loginLabel];
        
        UILabel *passwordLabel = [[UILabel alloc] init];
        [passwordLabel setBackgroundColor:[UIColor redColor]];
        [passwordLabel setTextAlignment:NSTextAlignmentCenter];
        [passwordLabel setFont:[UIFont systemFontOfSize:30.0]];
        [passwordLabel setTextColor:[UIColor whiteColor]];
        [passwordLabel setText:@"密码："];
        [passwordLabel sizeToFit];
        [passwordLabel setFrame:CGRectMake(50, 120, passwordLabel.frame.size.width, passwordLabel.frame.size.height)];
        [self.loginView addSubview:passwordLabel];
        
        self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(150, 120, 200, passwordLabel.frame.size.height)];
        [self.passwordField setSecureTextEntry:YES];
        [self.passwordField setFont:[UIFont systemFontOfSize:30.0]];
        [self.passwordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self.passwordField setBackgroundColor:[UIColor redColor]];
        [self.loginView addSubview:self.passwordField];
        
        self.loginButton = [[UIButton alloc] init];
        [self.loginButton setTitle:@"确 定" forState:UIControlStateNormal];
        [self.loginButton setTitle:@"确 定" forState:UIControlStateHighlighted];
        [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:35.0]];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginButton setBackgroundColor:[UIColor blueColor]];
        [self.loginButton sizeToFit];
        [self.loginButton setFrame:CGRectMake((400 - self.loginButton.frame.size.width)/2.0, 240, self.loginButton.frame.size.width, self.loginButton.frame.size.height)];
        [self.loginButton addTarget:self action:@selector(loginCheck) forControlEvents:UIControlEventTouchUpInside];
        [self.loginView addSubview:self.loginButton];
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
