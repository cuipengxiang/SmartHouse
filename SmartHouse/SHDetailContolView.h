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
#import "GCDAsyncSocket.h"

@interface SHDetailContolView : UIView<GCDAsyncSocketDelegate>{
    NSDate *down;
    NSDate *up;
    
    NSTimer *buttonTimer;
}

@property (nonatomic)dispatch_queue_t socketQueue;
@property (nonatomic, strong)AppDelegate *myDelegate;
@property (nonatomic, strong)NSMutableArray *buttonNames;
@property (nonatomic, strong)NSMutableArray *buttonCmds;
@property (nonatomic, retain)SHControlViewController *controller;
@property (nonatomic)int type;

- (id)initWithFrame:(CGRect)frame andType:(int)type;
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString andType:(int)type andController:(SHControlViewController *)controller;
- (void)setButtons:(NSMutableArray *)names andCmd:(NSMutableArray *)cmds;
- (void)onButtonClick:(UIButton *)button;

- (void)onButtonDown:(UIButton *)button;
- (void)onButtonUp:(UIButton *)button;

- (void)buttonTimeOut:(NSTimer *)timer;

@end
