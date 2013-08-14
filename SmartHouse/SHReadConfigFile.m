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
            for (int k = 1; k < lights.count; k = k + 2) {
                [tempModel.lightBtns addObject:[lights objectAtIndex:k]];
                [tempModel.lightCmds addObject:[lights objectAtIndex:k+1]];
            }
        }
        int curtainsCount = [[fileArray objectAtIndex:arrayCursor] intValue];
        arrayCursor++;
        for (int j = 0; j < curtainsCount; j++) {
            NSArray *curtains = [[fileArray objectAtIndex:arrayCursor] componentsSeparatedByString:@","];
            arrayCursor++;
            [tempModel.curtainNames addObject:[curtains objectAtIndex:0]];
            for (int k = 1; k < curtains.count; k = k + 2) {
                [tempModel.curtainBtns addObject:[curtains objectAtIndex:k]];
                [tempModel.curtainCmds addObject:[curtains objectAtIndex:k+1]];
            }
        }
        int musicsCount = [[fileArray objectAtIndex:arrayCursor] intValue];
        arrayCursor++;
        for (int j = 0; j < musicsCount; j++) {
            NSArray *musics = [[fileArray objectAtIndex:arrayCursor] componentsSeparatedByString:@","];
            arrayCursor++;
            [tempModel.musicNames addObject:[musics objectAtIndex:0]];
            for (int k = 1; k < musics.count; k = k + 2) {
                [tempModel.musicBtns addObject:[musics objectAtIndex:k]];
                [tempModel.musicCmds addObject:[musics objectAtIndex:k+1]];
            }
        }
        [myDelegate.models addObject:tempModel];
    }
}

@end
