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
@property(nonatomic, strong)NSThread *myModeThread;
@property(nonatomic, strong)UINavigationBar *navigationBar;
@property(nonatomic, strong)IBOutlet UIImageView *modeView;
@property(nonatomic, strong)IBOutlet UITableView *tableView;
@property(nonatomic, strong)IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong)UIButton *scrollLeft;
@property(nonatomic, strong)UIButton *scrollRight;
@property(nonatomic, strong)UIButton *LightButton;
@property(nonatomic, strong)UIButton *CurtainButton;
@property(nonatomic, strong)UIButton *MusicButton;
@property(nonatomic, strong)IBOutlet UIScrollView *detailView;
@property(nonatomic, strong)IBOutlet UIView *GuidePanel;

@property(nonatomic)SHRoomModel *currentModel;
@property(nonatomic)int modesCount;
@property(nonatomic)int detailPageCount;

@property BOOL needquery;

- (void)setupNavigationBar;
- (void)setupModeSelectBar:(SHRoomModel *)currentModel;
- (void)setupDetailView:(SHRoomModel *)currentModel Type:(int)type;
- (void)updateViews:(SHRoomModel *)currentModel;

- (void)onBackButtonClick;
- (void)onSettingsButtonClick;
- (void)onModeButtonClick:(UIButton *)button;

- (void)onScrollLeftClick:(id)sender;
- (void)onScrollRightClick:(id)sender;
- (void)onLightClick:(id)sender;
- (void)onCuitainClick:(id)sender;
- (void)onMusicClick:(id)sender;

- (void)queryMode:(NSThread *)thread;
- (void)setCurrentMode:(NSString *)mode;
- (void)sendCommand:(NSString *)cmd needBack:(BOOL)needback check:(BOOL)check;

@end
