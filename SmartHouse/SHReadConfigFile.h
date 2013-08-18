//
//  SHReadConfigFile.h
//  SmartHouse
//
//  Created by Roc on 13-8-14.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHReadConfigFile : NSObject

@property BOOL needCallback;

- (id)init;
- (id)initWithNeedCallback:(BOOL)need;
- (void)readFile;

@end
