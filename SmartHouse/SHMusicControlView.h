//
//  SHMusicControlView.h
//  SmartHouse
//
//  Created by Roc on 13-8-16.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHMusicControlView : UIView

@property (nonatomic, strong)NSMutableArray *buttonNames;
@property (nonatomic, strong)NSMutableArray *buttonCmds;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString;
- (void)setButtons:(NSMutableArray *)names andCmd:(NSMutableArray *)cmds;
- (void)onButtonClick:(UIButton *)button;
- (void)sendCommand:(NSString *)cmd;

@end