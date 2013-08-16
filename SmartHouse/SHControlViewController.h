//
//  SHControlViewController.h
//  SmartHouse
//
//  Created by Roc on 13-8-13.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SHRoomModel.h"

@interface SHControlViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic, strong)AppDelegate *myAppDelegate;
@property(nonatomic, strong)UINavigationBar *navigationBar;
@property(nonatomic, strong)IBOutlet UITableView *tableView;
@property(nonatomic, strong)IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong)IBOutlet UIButton *scrollLeft;
@property(nonatomic, strong)IBOutlet UIButton *scrollRight;
@property(nonatomic, strong)IBOutlet UIButton *LightButton;
@property(nonatomic, strong)IBOutlet UIButton *CurtainButton;
@property(nonatomic, strong)IBOutlet UIButton *MusicButton;
@property(nonatomic, strong)IBOutlet UIScrollView *detailView;
@property(nonatomic, strong)IBOutlet UIView *GuidePanel;

@property(nonatomic)SHRoomModel *currentModel;
@property(nonatomic)int modesCount;
@property(nonatomic)int detailPageCount;

- (void)setupNavigationBar;
- (void)setupModeSelectBar:(SHRoomModel *)currentModel;
- (void)setupDetailView:(SHRoomModel *)currentModel Type:(int)type;
- (void)updateViews:(SHRoomModel *)currentModel;

- (void)onBackButtonClick;
- (void)onSettingsButtonClick;
- (void)onModeButtonClick:(UIButton *)button;

- (IBAction)onScrollLeftClick:(id)sender;
- (IBAction)onScrollRightClick:(id)sender;
- (IBAction)onLightClick:(id)sender;
- (IBAction)onCuitainClick:(id)sender;
- (IBAction)onMusicClick:(id)sender;

- (void)sendCommand:(NSString *)cmd;

@end
