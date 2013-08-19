//
//  SHRoomModel.h
//  SmartHouse
//
//  Created by 衣世倩 on 8/14/13.
//  Copyright (c) 2013 Roc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHRoomModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *queryCmd;
@property (nonatomic,strong)NSMutableArray *modeBacks;
@property (nonatomic,strong)NSMutableArray *modesNames;
@property (nonatomic,strong)NSMutableArray *modesCmds;
@property (nonatomic,strong)NSMutableArray *lightNames;
@property (nonatomic,strong)NSMutableArray *lightBtns;
@property (nonatomic,strong)NSMutableArray *lightCmds;
@property (nonatomic,strong)NSMutableArray *curtainNames;
@property (nonatomic,strong)NSMutableArray *curtainBtns;
@property (nonatomic,strong)NSMutableArray *curtainCmds;
@property (nonatomic,strong)NSMutableArray *musicNames;
@property (nonatomic,strong)NSMutableArray *musicBtns;
@property (nonatomic,strong)NSMutableArray *musicCmds;

@end
