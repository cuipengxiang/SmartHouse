//
//  SHReadConfigFile.m
//  SmartHouse
//
//  Created by Roc on 13-8-14.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHReadConfigFile.h"
#import "AppDelegate.h"
#import "SHRoomModel.h"

@implementation SHReadConfigFile

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)readFile
{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!myDelegate.models) {
        myDelegate.models = [[NSMutableArray alloc] init];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *file = [documentDirectory stringByAppendingPathComponent:@"test1.txt"];
    NSError *error;	
    NSArray *fileArray = [[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error] componentsSeparatedByString:@"\n"];
    NSArray *socketHostandPort = [[fileArray objectAtIndex:0] componentsSeparatedByString:@","];
    myDelegate.host = [socketHostandPort objectAtIndex:0];
    myDelegate.port = [[socketHostandPort objectAtIndex:1] integerValue];
    NSArray *house = [[fileArray objectAtIndex:1] componentsSeparatedByString:@","];
    int roomsCount = [[house objectAtIndex:0] intValue];
    SHRoomModel *wholeHouse = [[SHRoomModel alloc] init];
    wholeHouse.name = @"整个住宅";
    wholeHouse.queryCmd = nil;
    [wholeHouse.modesNames addObject:[house objectAtIndex:1]];
    [wholeHouse.modesNames addObject:[house objectAtIndex:3]];
    [wholeHouse.modesCmds addObject:[house objectAtIndex:2]];
    [wholeHouse.modesCmds addObject:[house objectAtIndex:4]];
    
    int arrayCursor = 2;
    for (int i = 0; i < roomsCount; i++){
        SHRoomModel *tempModel = [[SHRoomModel alloc] init];
        NSArray *name = [[fileArray objectAtIndex:arrayCursor] componentsSeparatedByString:@","];
        arrayCursor++;
        tempModel.name = [name objectAtIndex:0];
        tempModel.queryCmd = [name objectAtIndex:1];
        NSArray *models = [[fileArray objectAtIndex:arrayCursor] componentsSeparatedByString:@","];
        arrayCursor++;
        for (int j = 0; j < models.count; j = j + 2) {
            [tempModel.modesNames addObject:[models objectAtIndex:j]];
            [tempModel.modesCmds addObject:[models objectAtIndex:j+1]];
        }
        int lightsCount = [[fileArray objectAtIndex:arrayCursor] intValue];
        arrayCursor++;
        for (int j = 0; j < lightsCount; j++) {
            NSArray *lights = [[fileArray objectAtIndex:arrayCursor] componentsSeparatedByString:@","];
            arrayCursor++;
            [tempModel.lightNames addObject:[lights objectAtIndex:0]];
            [wholeHouse.lightNames addObject:[lights objectAtIndex:0]];
            NSMutableArray *lightBtnstemp = [[NSMutableArray alloc] init];
            NSMutableArray *lightCmdstemp = [[NSMutableArray alloc] init];
            for (int k = 1; k < lights.count; k = k + 2) {
                [lightBtnstemp addObject:[lights objectAtIndex:k]];
                [lightCmdstemp addObject:[lights objectAtIndex:k + 1]];
            }
            [tempModel.lightBtns addObject:lightBtnstemp];
            [tempModel.lightCmds addObject:lightCmdstemp];
            [wholeHouse.lightBtns addObject:lightBtnstemp];
            [wholeHouse.lightCmds addObject:lightCmdstemp];
        }
        int curtainsCount = [[fileArray objectAtIndex:arrayCursor] intValue];
        arrayCursor++;
        for (int j = 0; j < curtainsCount; j++) {
            NSArray *curtains = [[fileArray objectAtIndex:arrayCursor] componentsSeparatedByString:@","];
            arrayCursor++;
            [tempModel.curtainNames addObject:[curtains objectAtIndex:0]];
            [wholeHouse.curtainNames addObject:[curtains objectAtIndex:0]];
            NSMutableArray *curtainBtnstemp = [[NSMutableArray alloc] init];
            NSMutableArray *curtainCmdstemp = [[NSMutableArray alloc] init];
            for (int k = 1; k < curtains.count; k = k + 2) {
                [curtainBtnstemp addObject:[curtains objectAtIndex:k]];
                [curtainCmdstemp addObject:[curtains objectAtIndex:k + 1]];
            }
            [tempModel.curtainBtns addObject:curtainBtnstemp];
            [tempModel.curtainCmds addObject:curtainCmdstemp];
            [wholeHouse.curtainBtns addObject:curtainBtnstemp];
            [wholeHouse.curtainCmds addObject:curtainCmdstemp];
        }
        int musicsCount = [[fileArray objectAtIndex:arrayCursor] intValue];
        arrayCursor++;
        for (int j = 0; j < musicsCount; j++) {
            NSArray *musics = [[fileArray objectAtIndex:arrayCursor] componentsSeparatedByString:@","];
            arrayCursor++;
            [tempModel.musicNames addObject:[musics objectAtIndex:0]];
            [wholeHouse.musicNames addObject:[musics objectAtIndex:0]];
            NSMutableArray *musicBtnstemp = [[NSMutableArray alloc] init];
            NSMutableArray *musicCmdstemp = [[NSMutableArray alloc] init];
            for (int k = 1; k < musics.count; k = k + 2) {
                [musicBtnstemp addObject:[musics objectAtIndex:k]];
                [musicCmdstemp addObject:[musics objectAtIndex:k + 1]];
            }
            [tempModel.musicBtns addObject:musicBtnstemp];
            [tempModel.musicCmds addObject:musicCmdstemp];
            [wholeHouse.musicBtns addObject:musicBtnstemp];
            [wholeHouse.musicCmds addObject:musicCmdstemp];
        }
        [myDelegate.models addObject:tempModel];
    }
    [myDelegate.models insertObject:wholeHouse atIndex:0];
}

@end
