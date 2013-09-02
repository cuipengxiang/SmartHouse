//
//  AppDelegate.h
//  SmartHouse
//
//  Created by Roc on 13-8-13.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHLoginViewController.h"
#import "GCDAsyncSocket.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GCDAsyncSocketDelegate>

@property (strong)UIViewController *mainController;
@property BOOL needBack;
@property BOOL check;
@property (strong, nonatomic) GCDAsyncSocket *socket;
@property (strong, nonatomic) NSString *host;
@property (nonatomic)int16_t port;
@property (strong, nonatomic) NSMutableArray *models;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SHLoginViewController *viewController;
@property (strong)NSString *resendCommand;

- (void)sendCommand:(NSString *)command from:(UIViewController *)controller needBack:(BOOL)needback check:(BOOL)check;
- (void)reConnectSocketWithCommand:(NSString *)command;

@end
