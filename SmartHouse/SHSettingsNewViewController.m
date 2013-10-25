//
//  SHSettingsNewViewController.m
//  SmartHouse
//
//  Created by Roc on 13-10-25.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHSettingsNewViewController.h"

@interface SHSettingsNewViewController ()

@end

@implementation SHSettingsNewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.settingbox = [[UIView alloc] init];
    [self.settingbox setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_setup_box"]]];
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]]];
        [self.settingbox setFrame:CGRectMake(274.0, 120.0, 476.0, 297.0)];
    } else {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg_p"]]];
        [self.settingbox setFrame:CGRectMake(146.0, 220.0, 476.0, 297.0)];
    }
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(412.0, 18.0, 35.0, 35.0)];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"btn_close_pressed"] forState:UIControlStateHighlighted];
    [self.backButton addTarget:self action:@selector(onBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.settingbox addSubview:self.backButton];
    
    self.password = [[UIButton alloc] initWithFrame:CGRectMake(35.0, 120.0, 405.0, 60.0)];
    [self.password setBackgroundImage:[UIImage imageNamed:@"bg_setup_line"] forState:UIControlStateNormal];
    [self.password setImage:[UIImage imageNamed:@"bg_arrow"] forState:UIControlStateNormal];
    [self.password setImageEdgeInsets:UIEdgeInsetsMake(0.0, 375.0, 0.0, 0.0)];
    [self.password addTarget:self action:@selector(onPasswordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.password setTitle:@"密码设置" forState:UIControlStateNormal];
    [self.password setTitleColor:[UIColor colorWithRed:0.804 green:0.748 blue:0.714 alpha:1.0] forState:UIControlStateNormal];
    [self.password.titleLabel setFont:[UIFont boldSystemFontOfSize:24.0]];
    [self.password setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -280.0, 0.0, 0.0)];
    [self.settingbox addSubview:self.password];
    
    self.network = [[UIButton alloc] initWithFrame:CGRectMake(35.0, 198.0, 405.0, 60.0)];
    [self.network setBackgroundImage:[UIImage imageNamed:@"bg_setup_line"] forState:UIControlStateNormal];
    NSString *imagename;
    if ([self.myAppDelegate.host isEqualToString:self.myAppDelegate.host1]) {
        imagename = @"btn_switch_2";
    } else {
        imagename = @"btn_switch_1";
    }
    [self.network setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    [self.network setImageEdgeInsets:UIEdgeInsetsMake(0.0, 245.0, 0.0, 0.0)];
    [self.network addTarget:self action:@selector(onNetworkClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.network setTitle:@"联网设置" forState:UIControlStateNormal];
    [self.network setTitleColor:[UIColor colorWithRed:0.804 green:0.748 blue:0.714 alpha:1.0] forState:UIControlStateNormal];
    [self.network.titleLabel setFont:[UIFont boldSystemFontOfSize:24.0]];
    [self.network setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -414.0, 0.0, 0.0)];
    [self.settingbox addSubview:self.network];
    
    [self.view addSubview:self.settingbox];
}

- (void)onBackButtonClick:(id)sender
{
    [self.controller willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1.0];
    [self dismissViewControllerAnimated:YES completion:^(void){
        self.controller.needquery = YES;
    }];
}

- (void)onPasswordClick:(id)sender
{
    SHSettingsViewController *controller = [[SHSettingsViewController alloc] initWithNibName:nil bundle:nil];
    controller.controller = self;
    [self presentViewController:controller animated:YES completion:^(void){
    }];
}

- (void)onNetworkClick:(id)sender
{
    NSString *imagename;
    if ([self.myAppDelegate.host isEqualToString:self.myAppDelegate.host1]) {
        self.myAppDelegate.host = self.myAppDelegate.host2;
        imagename = @"btn_switch_1";
    } else {
        self.myAppDelegate.host = self.myAppDelegate.host1;
        imagename = @"btn_switch_2";
    }
    [self.network setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [self.settingbox setFrame:CGRectMake(274.0, 120.0, 476.0, 297.0)];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]]];
    } else {
        [self.settingbox setFrame:CGRectMake(146.0, 220.0, 476.0, 297.0)];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg_p"]]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
