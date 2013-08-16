//
//  SHMusicControlView.m
//  SmartHouse
//
//  Created by Roc on 13-8-16.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHMusicControlView.h"

#define BUTTON_BASE_TAG 200

@implementation SHMusicControlView

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
    self.buttonNames = [[NSMutableArray alloc] initWithArray:names];
    self.buttonCmds = [[NSMutableArray alloc] initWithArray:cmds];
    
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setFrame:CGRectMake(30 + i * 65, 62, 55, 55)];
        [button setTitle:[names objectAtIndex:i] forState:UIControlStateNormal];
        [button setTag:BUTTON_BASE_TAG + i];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        switch (i) {
            case 0:
                [button setBackgroundImage:nil forState:UIControlStateNormal];
                [button setBackgroundImage:nil forState:UIControlStateSelected];
                break;
            case 1:
                [button setBackgroundImage:nil forState:UIControlStateNormal];
                [button setBackgroundImage:nil forState:UIControlStateSelected];
                break;
            case 2:
                [button setBackgroundImage:nil forState:UIControlStateNormal];
                [button setBackgroundImage:nil forState:UIControlStateSelected];
                break;
            case 3:
                [button setBackgroundImage:nil forState:UIControlStateNormal];
                [button setBackgroundImage:nil forState:UIControlStateSelected];
                break;
            case 4:
                [button setBackgroundImage:nil forState:UIControlStateNormal];
                [button setBackgroundImage:nil forState:UIControlStateSelected];
                break;
        }
    }
    for (int i = 5; i < self.buttonNames.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setFrame:CGRectMake(25.5 + (i-5)%4*83, 150 + (i-5)/4*40, 75, 25)];
        [button setTitle:[names objectAtIndex:i] forState:UIControlStateNormal];
        [button setTag:BUTTON_BASE_TAG + i];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)onButtonClick:(UIButton *)button
{
    [self sendCommand:[self.buttonCmds objectAtIndex:button.tag - BUTTON_BASE_TAG]];
}

- (void)sendCommand:(NSString *)cmd
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:cmd delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
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
