//
//  SHDetailContolView.h
//  SmartHouse
//
//  Created by Roc on 13-8-15.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHDetailContolView : UIView

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString;
- (void)setButtons:(NSMutableArray *)names andCmd:(NSMutableArray *)cmds;

@end
