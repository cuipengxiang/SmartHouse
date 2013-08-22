//
//  AppDelegate.m
//  SmartHouse
//
//  Created by Roc on 13-8-13.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "AppDelegate.h"
#import "SHLoginViewController.h"
#import "SHReadConfigFile.h"
#import "SHControlViewController.h"


@implementation AppDelegate

@synthesize models;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[SHLoginViewController alloc] initWithNibName:@"SHLoginViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    SHReadConfigFile *fileReader = [[SHReadConfigFile alloc] init];
    [fileReader readFile];
    
    //建立Socket连接
    dispatch_queue_t mainQueue = dispatch_queue_create("socketQueue", NULL);//dispatch_get_main_queue();
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
    NSError *error = nil;
    [self.socket connectToHost:self.host onPort:self.port error:&error];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark Socket Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    if (self.resendCommand) {
        [self.socket writeData:[self.resendCommand dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
        self.resendCommand = nil;
    }
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock
{
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length] - 2)];
    NSString *msg = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    [(SHControlViewController *)self.mainController setCurrentMode:msg];
	NSLog(@"%@", msg);
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    
}

- (void)sendCommand:(NSString *)command from:(UIViewController *)controller needBack:(BOOL)needback
{
    self.mainController = controller;
    NSString *commandSend = [NSString stringWithFormat:@"%@\r\n",command];
    NSLog(@"%@", command);
    [self.socket writeData:[commandSend dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    if (needback){
        [self.socket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:0];
    }
}

- (void)reConnectSocketWithCommand:(NSString *)command
{
    self.resendCommand = command;
    NSError *error = nil;
    [self.socket connectToHost:self.host onPort:self.port error:&error];
}


@end
