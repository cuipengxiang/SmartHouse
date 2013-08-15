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
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (!myDelegate.models) {
        myDelegate.models = [[NSMutableArray alloc] init];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *file = [documentDirectory stringByAppendingPathComponent:@"test1.txt"];
    NSError *error;	
    NSArray *fileArray = [[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error] componentsSeparatedByString:@"\n"];
    int roomsCount = [[fileArray objectAtIndex:0] intValue];
    int arrayCursor = 1;
    for (int i = 0; i < roomsCount; i++){
        SHRoomModel *tempModel = [[SHRoomModel alloc] init];
        tempModel.modesNames = [[NSMutableArray alloc] init];
        tempModel.modesCmds = [[NSMutableArray alloc] init];
        tempModel.lightNames = [[NSMutableArray alloc] init];
        tempModel.lightBtns = [[NSMutableArray alloc] init];
        tempModel.lightCmds = [[NSMutableArray alloc] init];
        tempModel.curtainNames = [[NSMutableArray alloc] init];
        tempModel.curtainBtns = [[NSMutableArray alloc] init];
        tempModel.curtainCmds = [[NSMutableArray alloc] init];
        tempModel.musicNames = [[NSMutableArray alloc] init];
        tempModel.musicBtns = [[NSMutableArray alloc] init];;
        tempModel.musicCmds = [[NSMutableArray alloc] init];;
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
            NSMutableArray *lightBtnstemp = [[NSMutableArray alloc] init];
            NSMutableArray *lightCmdstemp = [[NSMutableArray alloc] init];
            for (int k = 1; k < lights.count; k = k + 2) {
                [lightBtnstemp addObject:[lights objectAtIndex:k]];
                [lightCmdstemp addObject:[lights objectAtIndex:k + 1]];
            }
            [tempModel.lightBtns addObject:lightBtnstemp];
            [tempModel.lightCmds addObject:lightCmdstemp];
        }
        int curtainsCount = [[fileArray objectAtIndex:arrayCursor] intValue];
        arrayCursor++;
        for (int j = 0; j < curtainsCount; j++) {
            NSArray *curtains = [[fileArray objectAtIndex:arrayCursor] componentsSeparatedByString:@","];
            arrayCursor++;
            [tempModel.curtainNames addObject:[curtains objectAtIndex:0]];
            NSMutableArray *curtainBtnstemp = [[NSMutableArray alloc] init];
            NSMutableArray *curtainCmdstemp = [[NSMutableArray alloc] init];
            for (int k = 1; k < curtains.count; k = k + 2) {
                [curtainBtnstemp addObject:[curtains objectAtIndex:k]];
                [curtainCmdstemp addObject:[curtains objectAtIndex:k + 1]];
            }
            [tempModel.curtainBtns addObject:curtainBtnstemp];
            [tempModel.curtainCmds addObject:curtainCmdstemp];
        }
        int musicsCount = [[fileArray objectAtIndex:arrayCursor] intValue];
        arrayCursor++;
        for (int j = 0; j < musicsCount; j++) {
            NSArray *musics = [[fileArray objectAtIndex:arrayCursor] componentsSeparatedByString:@","];
            arrayCursor++;
            [tempModel.musicNames addObject:[musics objectAtIndex:0]];
            NSMutableArray *musicBtnstemp = [[NSMutableArray alloc] init];
            NSMutableArray *musicCmdstemp = [[NSMutableArray alloc] init];
            for (int k = 1; k < musics.count; k = k + 2) {
                [musicBtnstemp addObject:[musics objectAtIndex:k]];
                [musicCmdstemp addObject:[musics objectAtIndex:k + 1]];
            }
            [tempModel.musicBtns addObject:musicBtnstemp];
            [tempModel.musicCmds addObject:musicCmdstemp];
        }
        [myDelegate.models addObject:tempModel];
    }
}

@end
