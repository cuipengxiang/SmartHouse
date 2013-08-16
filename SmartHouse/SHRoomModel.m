//
//  SHRoomModel.m
//  SmartHouse
//
//  Created by 衣世倩 on 8/14/13.
//  Copyright (c) 2013 Roc. All rights reserved.
//

#import "SHRoomModel.h"

@implementation SHRoomModel

- (id)init
{
    self = [super init];
    if (self) {
        self.name = [[NSString alloc] init];
        self.queryCmd = [[NSString alloc] init];
        self.modesNames = [[NSMutableArray alloc] init];
        self.modesCmds = [[NSMutableArray alloc] init];
        self.lightNames = [[NSMutableArray alloc] init];
        self.lightBtns = [[NSMutableArray alloc] init];
        self.lightCmds = [[NSMutableArray alloc] init];
        self.curtainNames = [[NSMutableArray alloc] init];
        self.curtainBtns = [[NSMutableArray alloc] init];
        self.curtainCmds = [[NSMutableArray alloc] init];
        self.musicNames = [[NSMutableArray alloc] init];
        self.musicBtns = [[NSMutableArray alloc] init];
        self.musicCmds = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
