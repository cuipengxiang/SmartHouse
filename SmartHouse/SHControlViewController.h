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
#import "SHLoginViewController.h"
#import "GCDAsyncSocket.h"

@interface SHControlViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,GCDAsyncSocketDelegate>


@property(nonatomic)dispatch_queue_t socketQueue;
@property(nonatomic, strong)AppDelegate *myAppDelegate;
@property(nonatomic, strong)NSThread *myModeThread;
@property(nonatomic, strong)UINavigationBar *navigationBar;
@property(nonatomic, strong)UIView *modeView;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIButton *scrollLeft;
@property(nonatomic, strong)UIButton *scrollRight;
@property(nonatomic, strong)UIButton *LightButton;
@property(nonatomic, strong)UIButton *CurtainButton;
@property(nonatomic, strong)UIButton *MusicButton;
@property(nonatomic, strong)UIScrollView *detailView;
@property(nonatomic, strong)UIView *GuidePanel;
@property(nonatomic, strong)UIImageView *detailBackground;
@property(nonatomic, strong)UIButton *networkStateButton;
@property(nonatomic, strong)UIBarButtonItem *networkBarButton;
@property(nonatomic, strong)UINavigationItem *item;

@property(nonatomic)int currentType;
@property(nonatomic)int modeCurrentPage;
@property(nonatomic)int countInOnePage;

@property(nonatomic, retain)SHLoginViewController *backController;

@property(nonatomic)SHRoomModel *currentModel;
@property(nonatomic)int modesCount;
@property(nonatomic)int detailPageCount;

@property BOOL needquery;
@property int skipQuery;

- (void)setupNavigationBar:(float)width;
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
- (void)sendCommand:(NSString *)cmd;
- (void)setNetworkState:(BOOL)state;


@end
