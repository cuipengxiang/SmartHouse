//
//  SHDetailContolView.m
//  SmartHouse
//
//  Created by Roc on 13-8-15.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHDetailContolView.h"

#define BUTTON_BASE_TAG 1000

@implementation SHDetailContolView

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titleString
{
    self = [self initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:titleString];
        [titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel sizeToFit];
        [titleLabel setFrame:CGRectMake((frame.size.width - titleLabel.frame.size.width)/2, 10, titleLabel.frame.size.width, titleLabel.frame.size.height)];
        [self addSubview:titleLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [background setImage:[UIImage imageNamed:@"menu_background"]];
        [self addSubview:background];
    }
    return self;
}

- (void)setButtons:(NSMutableArray *)names andCmd:(NSMutableArray *)cmds
{
    for (int i = 0; i < names.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        if (names.count == 4) {
            [button setFrame:CGRectMake(10 + i * 60 + 10, 72, 40, 35)];
        } else if (names.count == 2) {
            [button setFrame:CGRectMake(20 + i * 105 + 15, 72, 75, 35)];
        }
        [button setTitle:[names objectAtIndex:i] forState:UIControlStateNormal];
        [button setTag:BUTTON_BASE_TAG + i];
        [self addSubview:button];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
