//
//  SHDetailContolView.h
//  SmartHouse
//
//  Created by Roc on 13-8-15.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SHDetailContolView : UIView

@property (nonatomic, retain)AppDelegate *myDelegate;
@property (nonatomic, strong)NSMutableArray *buttonNames;
@property (nonatomic, strong)NSMutableArray *buttonCmds;
@property (nonatomic)int type;

- (id)initWithFrame:(CGRect)frame andType:(int)type;
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString andType:(int)type;
- (void)setButtons:(NSMutableArray *)names andCmd:(NSMutableArray *)cmds;
- (void)onButtonClick:(UIButton *)button;
- (void)sendCommand:(NSString *)cmd check:(BOOL)check;

@end
