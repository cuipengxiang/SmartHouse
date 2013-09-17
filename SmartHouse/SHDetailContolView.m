//
//  SHDetailContolView.m
//  SmartHouse
//
//  Created by Roc on 13-8-15.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHDetailContolView.h"

#define BUTTON_BASE_TAG 4000
#define BUTTON_DELAY 1.0

@implementation SHDetailContolView

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString andType:(int)type andController:(SHControlViewController *)controller
{
    self = [self initWithFrame:frame andType:type];
    if (self) {
        self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.controller = controller;
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:titleString];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel sizeToFit];
        [titleLabel setFrame:CGRectMake((frame.size.width - titleLabel.frame.size.width)/2, 19, titleLabel.frame.size.width, titleLabel.frame.size.height)];
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
        self.socketQueue = dispatch_queue_create("socketQueue1", NULL);
        downCount = 0;
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
            [button setFrame:CGRectMake(20 + i * 88, 72, 76, 36)];
            [button setTag:BUTTON_BASE_TAG + i];
            if (i < 2) {
                [button setTitle:[names objectAtIndex:i] forState:UIControlStateNormal];
                [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
                [button setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"btn_light_control"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            } else if (i == 2) {
                if (self.type == 0) {
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"light_%d",i]] forState:UIControlStateNormal];
                } else {
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"curtain_%d",i]] forState:UIControlStateNormal];
                }
                [button addTarget:self action:@selector(onButtonDown:) forControlEvents:UIControlEventTouchDown];
                [button addTarget:self action:@selector(onButtonUp:) forControlEvents:UIControlEventTouchUpInside];
                [button addTarget:self action:@selector(onButtonUp:) forControlEvents:UIControlEventTouchUpOutside];
            } else if (i == 3) {
                if (self.type == 0) {
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"light_%d",i]] forState:UIControlStateNormal];
                } else {
                    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"curtain_%d",i]] forState:UIControlStateNormal];
                }
                [button addTarget:self action:@selector(onButtonDown:) forControlEvents:UIControlEventTouchDown];
                [button addTarget:self action:@selector(onButtonUp:) forControlEvents:UIControlEventTouchUpInside];
                [button addTarget:self action:@selector(onButtonUp:) forControlEvents:UIControlEventTouchUpOutside];
            }
            [self addSubview:button];
        }
    } else if (names.count == 2) {
        for (int i = 0; i < names.count; i++) {
            UIButton *button = [[UIButton alloc] init];
            [button setFrame:CGRectMake(100 + i * 104, 72, 76, 36)];
            [button setTitle:[names objectAtIndex:i] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
            [button setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
            [button setTag:BUTTON_BASE_TAG + i];
            [button setBackgroundImage:[UIImage imageNamed:@"btn_light_control"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    } else if (names.count == 3) {
        for (int i = 0; i < names.count; i++) {
            UIButton *button = [[UIButton alloc] init];
            [button setFrame:CGRectMake(58 + i * 94, 72, 76, 36)];
            [button setTag:BUTTON_BASE_TAG + i];
            
            [button setTitle:[names objectAtIndex:i] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
            [button setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"btn_light_control"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
}

- (void)onButtonClick:(UIButton *)button
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^(void){
        NSError *error;
        GCDAsyncSocket *socket = [[GCDAsyncSocket alloc] initWithDelegate:self.controller delegateQueue:self.controller.socketQueue];
        socket.command = [NSString stringWithFormat:@"%@\r\n", [self.buttonCmds objectAtIndex:button.tag - BUTTON_BASE_TAG]];
        [socket connectToHost:self.myDelegate.host onPort:self.myDelegate.port withTimeout:3.0 error:&error];
    });
}

- (void)onButtonUp:(UIButton *)button
{
    if (downCount > 0) {
        downCount--;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^(void){
            self.socket.command1 = [NSString stringWithFormat:@"%@\r\n", [self.buttonCmds objectAtIndex:(button.tag - BUTTON_BASE_TAG)*2 - 1]];
            if ([self.socket isConnected]) {
                [self.socket writeData:[self.socket.command1 dataUsingEncoding:NSUTF8StringEncoding] withTimeout:3 tag:1];
            }
        });
    }
}

- (void)onButtonDown:(UIButton *)button
{
    if (self.myDelegate.canButtonDown) {
        self.myDelegate.canButtonDown = NO;
        downCount ++;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^(void){
            NSError *error;
            self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:self.socketQueue];
            self.socket.command = [NSString stringWithFormat:@"%@\r\n", [self.buttonCmds objectAtIndex:(button.tag - BUTTON_BASE_TAG)*2 - 2]];
            [self.socket connectToHost:self.myDelegate.host onPort:self.myDelegate.port withTimeout:3.0 error:&error];
        });
    }
}



- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [sock writeData:[sock.command dataUsingEncoding:NSUTF8StringEncoding] withTimeout:3 tag:0];
    if (sock.command1.length > 0) {
        [sock writeData:[sock.command1 dataUsingEncoding:NSUTF8StringEncoding] withTimeout:3 tag:1];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:tag];
    if (tag == 1) {
        [sock disconnect];
        sock = nil;
        self.myDelegate.canButtonDown = YES;
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
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
