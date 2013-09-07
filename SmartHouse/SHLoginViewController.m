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
            controller.backController = self;
            [self presentViewController:controller animated:YES completion:^(void){
                [self.passwordField setText:nil];
                [self.passwordField setBackground:[UIImage imageNamed:@"input_box"]];
                [self.passwordField setPlaceholder:@"请输入密码"];
            }];
        } else {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }
    } else {
        if ([[self.passwordField text] isEqualToString:@"0000"]) {
            SHControlViewController *controller = [[SHControlViewController alloc] initWithNibName:nil bundle:nil];
            controller.backController = self;
            [self presentViewController:controller animated:YES completion:^(void){
                [self.passwordField setText:nil];
                [self.passwordField setBackground:[UIImage imageNamed:@"input_box"]];
                [self.passwordField setPlaceholder:@"请输入密码"];
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
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 768, 1004)];
    [self.imageView setImage:[UIImage imageNamed:@"login_bg"]];
    
    [self.view addSubview:self.imageView];
    
    self.loginbox = [[UIImageView alloc] initWithFrame:CGRectMake(147.5, 240.0, 473.0, 338.0)];
    [self.loginbox setImage:[UIImage imageNamed:@"login_box"]];
    [self.imageView addSubview:self.loginbox];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouch)];
    [gesture setNumberOfTouchesRequired:1];
    [gesture setNumberOfTapsRequired:1];
    [gesture setDelegate:self];
    [self.view addGestureRecognizer:gesture];
    
	loginLabel = [[UILabel alloc] init];
    [loginLabel setBackgroundColor:[UIColor clearColor]];
    [loginLabel setTextAlignment:NSTextAlignmentCenter];
    [loginLabel setFont:[UIFont boldSystemFontOfSize:30.0]];
    [loginLabel setTextColor:[UIColor colorWithRed:0.694 green:0.278 blue:0.020 alpha:1.0]];
    [loginLabel setText:@"智能家居系统"];
    [loginLabel sizeToFit];
    [loginLabel setFrame:CGRectMake((768 - loginLabel.frame.size.width)/2.0, 270, loginLabel.frame.size.width, loginLabel.frame.size.height)];
    [self.view addSubview:loginLabel];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(204, 360, 360, 60)];
    [self.passwordField setSecureTextEntry:YES];
    [self.passwordField setPlaceholder:@"请输入密码"];
    [self.passwordField setFont:[UIFont systemFontOfSize:20.0]];
    [self.passwordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.passwordField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.passwordField setTextAlignment:NSTextAlignmentCenter];
    [self.passwordField setDelegate:self];
    [self.passwordField setBackground:[UIImage imageNamed:@"input_box"]];
    [self.view addSubview:self.passwordField];
    
    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"btn_login_normal"] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"btn_login_pressed"] forState:UIControlStateHighlighted];
    [self.loginButton sizeToFit];
    [self.loginButton setFrame:CGRectMake(200, 450, 368, 75)];
    [self.loginButton addTarget:self action:@selector(loginCheck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [self.imageView setFrame:CGRectMake(0.0, 0.0, 1024, 748)];
        [self.imageView setImage:[UIImage imageNamed:@"login_bg"]];
        [loginLabel setFrame:CGRectMake((1024 - loginLabel.frame.size.width)/2.0, 148, loginLabel.frame.size.width, loginLabel.frame.size.height)];
        [self.loginButton setFrame:CGRectMake(327.5, 330, 370, 75)];
        [self.passwordField setFrame:CGRectMake(332.5, 240, 360, 60)];
        [self.loginbox setFrame:CGRectMake(275.5, 120.0, 473.0, 338.0)];
    } else if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
        [self.imageView setFrame:CGRectMake(0.0, 0.0, 768, 1004)];
        [self.imageView setImage:[UIImage imageNamed:@"login_bg_p"]];
        [loginLabel setFrame:CGRectMake((768 - loginLabel.frame.size.width)/2.0, 270, loginLabel.frame.size.width, loginLabel.frame.size.height)];
        [self.loginButton setFrame:CGRectMake(200, 450, 368, 75)];
        [self.passwordField setFrame:CGRectMake(204, 360, 360, 60)];
        [self.loginbox setFrame:CGRectMake(147.5, 240.0, 473.0, 338.0)];
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.passwordField setPlaceholder:@""];
    [self.passwordField setBackground:[UIImage imageNamed:@"input_box_focused"]];
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
    if (self.passwordField.text.length == 0) {
        [self.passwordField setBackground:[UIImage imageNamed:@"input_box"]];
        [self.passwordField setPlaceholder:@"请输入密码"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
