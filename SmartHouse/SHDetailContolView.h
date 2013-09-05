//
//  SHDetailContolView.h
//  SmartHouse
//
//  Created by Roc on 13-8-15.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SHControlViewController.h"

@interface SHDetailContolView : UIView

@property (nonatomic, strong)AppDelegate *myDelegate;
@property (nonatomic, strong)NSMutableArray *buttonNames;
@property (nonatomic, strong)NSMutableArray *buttonCmds;
@property (nonatomic, retain)SHControlViewController *controller;
@property (nonatomic)int type;
@property BOOL isdown;

- (id)initWithFrame:(CGRect)frame andType:(int)type;
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString andType:(int)type andController:(SHControlViewController *)controller;
- (void)setButtons:(NSMutableArray *)names andCmd:(NSMutableArray *)cmds;
- (void)onButtonClick:(UIButton *)button;
- (void)onButtonClickDown:(UIButton *)button;
- (void)onButtonClickUpOutside:(UIButton *)button;

- (void)onButtonDown:(UIButton *)button;
- (void)onButtonUp:(UIButton *)button;
- (void)sendCommand:(NSString *)cmd check:(BOOL)check;

@end
