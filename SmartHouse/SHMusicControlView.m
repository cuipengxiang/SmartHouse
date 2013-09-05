//
//  SHMusicControlView.m
//  SmartHouse
//
//  Created by Roc on 13-8-16.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHMusicControlView.h"

#define BUTTON_BASE_TAG 200
#define BUTTON_DELAY 1.0

@implementation SHMusicControlView

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString andController:(SHControlViewController *)controller
{
    self = [self initWithFrame:frame];
    if (self) {
        self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.controller = controller;
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:titleString];
        [titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel sizeToFit];
        [titleLabel setFrame:CGRectMake((frame.size.width - titleLabel.frame.size.width)/2, 20, titleLabel.frame.size.width, titleLabel.frame.size.height)];
        [self addSubview:titleLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [background setImage:[UIImage imageNamed:@"bg_music"]];
        [self addSubview:background];
    }
    return self;
}

- (void)setButtons:(NSMutableArray *)names andCmd:(NSMutableArray *)cmds
{
    self.buttonNames = [[NSMutableArray alloc] initWithArray:names];
    self.buttonCmds = [[NSMutableArray alloc] initWithArray:cmds];
    
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setFrame:CGRectMake(30 + i * 65, 62, 55, 55)];
        [button setTag:BUTTON_BASE_TAG + i];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"music_control%d",i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(onButtonClickDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(onButtonClickUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [self addSubview:button];
    }
    for (int i = 5; i < self.buttonNames.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setFrame:CGRectMake(25.5 + (i-5)%4*83, 150 + (i-5)/4*40, 75, 25)];
        [button setTag:BUTTON_BASE_TAG + i];
        [button setTitle:[self.buttonNames objectAtIndex:i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [button setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_music_control"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(onButtonClickDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(onButtonClickUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [self addSubview:button];
    }
}

- (void)onButtonClickDown:(UIButton *)button
{
    self.controller.needquery = NO;
}

- (void)onButtonClickUpOutside:(UIButton *)button
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^(void){
        sleep(1);
        self.controller.needquery = YES;
    });
}

- (void)onButtonClick:(UIButton *)button
{
    [self sendCommand:[self.buttonCmds objectAtIndex:button.tag - BUTTON_BASE_TAG] check:YES];
    /*
    [button setEnabled:NO];
    double delayInSeconds = BUTTON_DELAY;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        dispatch_async(dispatch_get_main_queue(), ^{
            [button setEnabled:YES];
        });
    });
    */
}

- (void)sendCommand:(NSString *)cmd check:(BOOL)check
{
    [self.myDelegate sendCommand:cmd from:self.controller needBack:NO check:check];
    /*
    if ([self.myDelegate.socket isConnected]) {
        [self.myDelegate sendCommand:cmd from:nil needBack:NO];
    } else {
        if (check) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"与服务端连接已断开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            [self.myDelegate reConnectSocketWithCommand:cmd];
        } else {
            [self.myDelegate reConnectSocketWithCommand:nil];
        }
    }
    */
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
