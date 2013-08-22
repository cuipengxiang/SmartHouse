//
//  SHDetailContolView.m
//  SmartHouse
//
//  Created by Roc on 13-8-15.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHDetailContolView.h"

#define BUTTON_BASE_TAG 2000

@implementation SHDetailContolView

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString andType:(int)type
{
    self = [self initWithFrame:frame andType:type];
    if (self) {
        self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:titleString];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel sizeToFit];
        [titleLabel setFrame:CGRectMake((frame.size.width - titleLabel.frame.size.width)/2, 20, titleLabel.frame.size.width, titleLabel.frame.size.height)];
        [self addSubview:titleLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andType:(int)type
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.type = type;
        if (type == 0) {
            [background setImage:[UIImage imageNamed:@"bg_light"]];
        } else {
            [background setImage:[UIImage imageNamed:@"bg_curtain"]];
        }
        [self addSubview:background];
    }
    return self;
}

- (void)setButtons:(NSMutableArray *)names andCmd:(NSMutableArray *)cmds
{
    self.buttonNames = [[NSMutableArray alloc] initWithArray:names];
    self.buttonCmds = [[NSMutableArray alloc] initWithArray:cmds];
    if (names.count == 4) {
        for (int i = 0; i < names.count; i++) {
            UIButton *button = [[UIButton alloc] init];
            [button setFrame:CGRectMake(17.5 + i * 55, 72, 50, 25)];
            [button setTag:BUTTON_BASE_TAG + i];
            if (i < 2) {
                [button setTitle:[names objectAtIndex:i] forState:UIControlStateNormal];
                [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
                [button setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"btn_light_control"] forState:UIControlStateNormal];
            } else if (i == 2) {
                if (self.type == 0) {
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"light_%d",i]] forState:UIControlStateNormal];
                } else {
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"curtain_%d",i]] forState:UIControlStateNormal];
                }
            } else if (i == 3) {
                if (self.type == 0) {
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"light_%d",i]] forState:UIControlStateNormal];
                } else {
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"curtain_%d",i]] forState:UIControlStateNormal];
                }
            }
            [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    } else if (names.count == 2) {
        for (int i = 0; i < names.count; i++) {
            UIButton *button = [[UIButton alloc] init];
            [button setFrame:CGRectMake(72.5 + i * 55, 72, 50, 25)];
            [button setTitle:[names objectAtIndex:i] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
            [button setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
            [button setTag:BUTTON_BASE_TAG + i];
            [button setBackgroundImage:[UIImage imageNamed:@"btn_light_control"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
}

- (void)onButtonClick:(UIButton *)button
{
    [self sendCommand:[self.buttonCmds objectAtIndex:button.tag - BUTTON_BASE_TAG] check:YES];
}

- (void)sendCommand:(NSString *)cmd check:(BOOL)check
{
    if ((check)&&(![self.myDelegate.socket isConnected])) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"与服务端连接已断开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:cmd delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [self.myDelegate sendCommand:cmd from:nil needBack:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
