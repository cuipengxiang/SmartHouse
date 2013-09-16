//
//  SHMusicControlView.h
//  SmartHouse
//
//  Created by Roc on 13-8-16.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SHControlViewController.h"
#import "GCDAsyncSocket.h"

@interface SHMusicControlView : UIView

@property (nonatomic ,strong)AppDelegate *myDelegate;
@property (nonatomic, strong)NSMutableArray *buttonNames;
@property (nonatomic, strong)NSMutableArray *buttonCmds;
@property (nonatomic, retain)SHControlViewController *controller;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString andController:(SHControlViewController *)controller;
- (void)setButtons:(NSMutableArray *)names andCmd:(NSMutableArray *)cmds;
- (void)onButtonClick:(UIButton *)button;

@end