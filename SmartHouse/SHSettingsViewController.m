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
    [self.oldpassword setSecureTextEntry:YES];
    [self.newpassword setSecureTextEntry:YES];
    [self.newpassword_again setSecureTextEntry:YES];
    [self.commit setBackgroundColor:[UIColor clearColor]];
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
- (void)onBackButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
