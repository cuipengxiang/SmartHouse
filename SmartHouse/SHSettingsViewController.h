//
//  SHSettingsViewController.h
//  SmartHouse
//
//  Created by Roc on 13-8-14.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSettingsViewController : UIViewController

@property(nonatomic, strong)IBOutlet UIButton *commit;
@property(nonatomic, strong)IBOutlet UITextField *oldpassword;
@property(nonatomic, strong)IBOutlet UITextField *newpassword;
@property(nonatomic, strong)IBOutlet UITextField *newpassword_again;
@property(nonatomic, strong)UINavigationBar *navigationBar;

- (void)onBackButtonClick;
//- (void)setupNavigationBar;

@end
