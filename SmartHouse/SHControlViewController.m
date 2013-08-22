//
//  SHControlViewController.m
//  SmartHouse
//
//  Created by Roc on 13-8-13.
//  Copyright (c) 2013年 Roc. All rights reserved.
//

#import "SHControlViewController.h"
#import "SHSettingsViewController.h"
#import "SHDetailContolView.h"
#import "SHMusicControlView.h"

#define GUIDE_PANEL_BASE_TAG 1000
#define MODE_BTN_BASE_TAG 100
#define TYPE_LIGHT 0
#define TYPE_CURTAIN 1
#define TYPE_MUSIC 2

@interface SHControlViewController ()

@end

@implementation SHControlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.myModeThread = [[NSThread alloc] initWithTarget:self selector:@selector(queryMode:) object:nil];
        [self setupNavigationBar];
        [self.view setBackgroundColor:[UIColor colorWithRed:246.0/255.0f green:246.0/255.0f blue:246.0/255.0f alpha:1.0]];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.needquery = YES;
    
    self.LightButton = [[UIButton alloc] initWithFrame:CGRectMake(192.0f, 258.0f, 66.0f, 70.0f)];
    [self.LightButton setBackgroundImage:[UIImage imageNamed:@"btn_light"] forState:UIControlStateNormal];
    [self.LightButton setBackgroundImage:[UIImage imageNamed:@"btn_light"] forState:UIControlStateSelected];
    [self.LightButton addTarget:self action:@selector(onLightClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.CurtainButton = [[UIButton alloc] initWithFrame:CGRectMake(292.0f, 258.0f, 66.0f, 70.0f)];
    [self.CurtainButton setBackgroundImage:[UIImage imageNamed:@"btn_curtain"] forState:UIControlStateNormal];
    [self.CurtainButton setBackgroundImage:[UIImage imageNamed:@"btn_curtain"] forState:UIControlStateSelected];
    [self.CurtainButton addTarget:self action:@selector(onCuitainClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.MusicButton = [[UIButton alloc] initWithFrame:CGRectMake(392.0f, 258.0f, 66.0f, 70.0f)];
    [self.MusicButton setBackgroundImage:[UIImage imageNamed:@"btn_music"] forState:UIControlStateNormal];
    [self.MusicButton setBackgroundImage:[UIImage imageNamed:@"btn_music"] forState:UIControlStateSelected];
    [self.MusicButton addTarget:self action:@selector(onMusicClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.LightButton];
    [self.view addSubview:self.CurtainButton];
    [self.view addSubview:self.MusicButton];
    
    self.scrollLeft = [[UIButton alloc] initWithFrame:CGRectMake(20.0f, 55.0f, 25.0f, 50.0f)];
    [self.scrollLeft setBackgroundImage:[UIImage imageNamed:@"turn_left"] forState:UIControlStateNormal];
    [self.scrollLeft setBackgroundImage:[UIImage imageNamed:@"turn_left"] forState:UIControlStateSelected];
    [self.scrollLeft addTarget:self action:@selector(onScrollLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.scrollRight = [[UIButton alloc] initWithFrame:CGRectMake(799.0f, 55.0f, 25.0f, 50.0f)];
    [self.scrollRight setBackgroundImage:[UIImage imageNamed:@"turn_right"] forState:UIControlStateNormal];
    [self.scrollRight setBackgroundImage:[UIImage imageNamed:@"turn_right"] forState:UIControlStateSelected];
    [self.scrollRight addTarget:self action:@selector(onScrollLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.modeView addSubview:self.scrollLeft];
    [self.modeView addSubview:self.scrollRight];
    
    [self.modeView setImage:[UIImage imageNamed:@"bg_mode"]];
    
    [self.GuidePanel setBackgroundColor:[UIColor clearColor]];
    
    self.currentModel = [self.myAppDelegate.models objectAtIndex:0];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_background"]]];
    [self.tableView setBounces:NO];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView reloadData];
    [self setupModeSelectBar:self.currentModel];
    [self setupDetailView:self.currentModel Type:TYPE_LIGHT];
    
}

//设置导航栏
- (void)setupNavigationBar
{
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_topbar_all"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"智能家居系统"];
    [titleLabel setFont:[UIFont systemFontOfSize:24.0]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel sizeToFit];
    
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [leftButton addTarget:self action:@selector(onBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"btn_setting"] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [rightButton addTarget:self action:@selector(onSettingsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton sizeToFit];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    UINavigationItem *item = [[UINavigationItem alloc] init];
    [item setTitleView:titleLabel];
    [item setLeftBarButtonItem:leftBarButton];
    [item setRightBarButtonItem:rightBarButton];
    
    [self.navigationBar pushNavigationItem:item animated:YES];
    [self.view addSubview:self.navigationBar];
}

- (void)onBackButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        self.needquery = NO;
    }];
}

- (void)onSettingsButtonClick
{
    SHSettingsViewController *controller = [[SHSettingsViewController alloc] initWithNibName:nil bundle:nil];
    controller.controller = self;
    [self presentViewController:controller animated:YES completion:^(void){
        self.needquery = NO;
    }];
}

- (void)setupModeSelectBar:(SHRoomModel *)currentModel
{
    for (UIButton *button in self.scrollView.subviews) {
        [button removeFromSuperview];
    }
    
    if (![self.myModeThread isExecuting]) {
        [self.myModeThread start];
    }
    
    [self.scrollView setBounces:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    self.modesCount = self.currentModel.modesNames.count;
    [self.scrollView setContentSize:CGSizeMake(184*self.currentModel.modesNames.count, 100.0f)];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    for (int i = 0; i < self.currentModel.modesNames.count; i++) {
        UIButton *modeButton = [[UIButton alloc] initWithFrame:CGRectMake(i*184 + 20, 22, 144, 56)];
        [modeButton setTitle:[self.currentModel.modesNames objectAtIndex:i] forState:UIControlStateNormal];
        [modeButton setTitle:[self.currentModel.modesNames objectAtIndex:i] forState:UIControlStateSelected];
        [modeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [modeButton setBackgroundImage:[UIImage imageNamed:@"mode_normal"] forState:UIControlStateNormal];
        [modeButton setBackgroundImage:[UIImage imageNamed:@"mode_selected"] forState:UIControlStateSelected];
        [modeButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [modeButton setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] forState:UIControlStateNormal];
        [modeButton setTag:MODE_BTN_BASE_TAG + i];
        [modeButton addTarget:self action:@selector(onModeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:modeButton];
    }
    
}

- (void)onModeButtonClick:(UIButton *)button
{
    for (int i = MODE_BTN_BASE_TAG; i < MODE_BTN_BASE_TAG + self.currentModel.modesNames.count; i++) {
        [(UIButton *)[self.modeView viewWithTag:i] setSelected:NO];
    }
    [button setSelected:YES];
    NSString *cmd = [self.currentModel.modesCmds objectAtIndex:button.tag - MODE_BTN_BASE_TAG];
    [self sendCommand:cmd needBack:NO check:YES];
}

- (void)onScrollLeftClick:(id)sender
{
    CGPoint point = [self.scrollView contentOffset];
    if (point.x > 0) {
        point.x = 0;
        [self.scrollView setContentOffset:point animated:YES];
    }
}

- (void)onScrollRightClick:(id)sender
{
    if (self.modesCount > 4) {
        CGPoint point = [self.scrollView contentOffset];
        if (point.x < (self.modesCount - 4)*184) {
            point.x = (self.modesCount - 4)*184;
            [self.scrollView setContentOffset:point animated:YES];
        }
    }
}

- (void)setupDetailView:(SHRoomModel *)currentModel Type:(int)type
{
    for (UIView *view in self.detailView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.GuidePanel.subviews) {
        [view removeFromSuperview];
    }
    [self.detailView setBounces:NO];
    [self.detailView setDelegate:self];
    [self.detailView setShowsHorizontalScrollIndicator:NO];
    [self.detailView setContentOffset:CGPointMake(0, 0)];
    [self.detailView setPagingEnabled:YES];
    
    NSMutableArray *detailViewNames = nil;
    NSMutableArray *detailViewBtns = nil;
    NSMutableArray *detailViewCmds = nil;
    switch (type) {
        case TYPE_LIGHT:
            detailViewNames = [[NSMutableArray alloc] initWithArray:self.currentModel.lightNames];
            detailViewBtns = [[NSMutableArray alloc] initWithArray:self.currentModel.lightBtns];
            detailViewCmds = [[NSMutableArray alloc] initWithArray:self.currentModel.lightCmds];
            [self.detailView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_detail_light"]]];
            break;
        case TYPE_CURTAIN:
            detailViewNames = [[NSMutableArray alloc] initWithArray:self.currentModel.curtainNames];
            detailViewBtns = [[NSMutableArray alloc] initWithArray:self.currentModel.curtainBtns];
            detailViewCmds = [[NSMutableArray alloc] initWithArray:self.currentModel.curtainCmds];
            [self.detailView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_detail_curtain"]]];
            break;
        case TYPE_MUSIC:
            detailViewNames = [[NSMutableArray alloc] initWithArray:self.currentModel.musicNames];
            detailViewBtns = [[NSMutableArray alloc] initWithArray:self.currentModel.musicBtns];
            detailViewCmds = [[NSMutableArray alloc] initWithArray:self.currentModel.musicCmds];
            [self.detailView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_detail_music"]]];
            break;
    }
    [self.GuidePanel setHidden:YES];
    if (type != TYPE_MUSIC) {
        int pageCount = detailViewNames.count/6;
        if (detailViewNames.count%6 != 0) {
            pageCount++;
        }
        self.detailPageCount = pageCount;
        [self.detailView setContentSize:CGSizeMake(844*pageCount, 384)];
        if (pageCount > 1) {
            [self.GuidePanel setFrame:CGRectMake(160+(844-(pageCount*2-1)*15)/2.0, 684, (pageCount*2-1)*15, 44)];
            for (int i = 0; i < pageCount; i++) {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(i*30, 14.5, 15, 15)];
                if (i == 0) {
                    [image setImage:[UIImage imageNamed:@"selected"]];
                } else {
                    [image setImage:[UIImage imageNamed:@"unselected"]];
                }
                [image setTag:GUIDE_PANEL_BASE_TAG + i];
                [self.GuidePanel addSubview:image];
            }
            [self.GuidePanel setHidden:NO];
        }
        for (int i = 0; i < detailViewNames.count; i++) {
            SHDetailContolView *detailViewPanel = [[SHDetailContolView alloc] initWithFrame:CGRectMake(i/6*844 + 32 + (i%3)*265, 45 + i/3%2*155, 250, 140)andTitle:[detailViewNames objectAtIndex:i] andType:type];
            [detailViewPanel setButtons:[detailViewBtns objectAtIndex:i] andCmd:[detailViewCmds objectAtIndex:i]];
            [self.detailView addSubview:detailViewPanel];
        }
    } else {
        int pageCount = detailViewNames.count/2;
        if (detailViewNames.count%2 != 0) {
            pageCount++;
        }
        self.detailPageCount = pageCount;
        [self.detailView setContentSize:CGSizeMake(844*pageCount, 384)];
        if (pageCount > 1) {
            [self.GuidePanel setFrame:CGRectMake(160+(844-(pageCount*2-1)*15)/2.0, 684, (pageCount*2-1)*15, 44)];
            for (int i = 0; i < pageCount; i++) {
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(i*30, 14.5, 15, 15)];
                if (i == 0) {
                    [image setImage:[UIImage imageNamed:@"selected"]];
                } else {
                    [image setImage:[UIImage imageNamed:@"unselected"]];
                }
                [image setTag:GUIDE_PANEL_BASE_TAG + i];
                [self.GuidePanel addSubview:image];
            }
            [self.GuidePanel setHidden:NO];
        }
        for (int i = 0; i < detailViewNames.count; i++) {
            SHMusicControlView *detailViewPanel = [[SHMusicControlView alloc] initWithFrame:CGRectMake(i/2*844 + 30 + (i%2)*405, 45, 375, 280)andTitle:[detailViewNames objectAtIndex:i]];
            [detailViewPanel setButtons:[detailViewBtns objectAtIndex:i] andCmd:[detailViewCmds objectAtIndex:i]];
            [self.detailView addSubview:detailViewPanel];
        }
    }
}

- (void)onLightClick:(id)sender
{
    [self setupDetailView:self.currentModel Type:TYPE_LIGHT];
}

- (void)onCuitainClick:(id)sender
{
    [self setupDetailView:self.currentModel Type:TYPE_CURTAIN];
}

- (void)onMusicClick:(id)sender
{
    [self setupDetailView:self.currentModel Type:TYPE_MUSIC];
}

-(void)updateViews:(SHRoomModel *)currentModel
{
    [self setupModeSelectBar:self.currentModel];
    [self setupDetailView:self.currentModel Type:0];
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentModel = [self.myAppDelegate.models objectAtIndex:indexPath.row];
    [self updateViews:self.currentModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0.;
}


#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ViolationTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *roomName = [[self.myAppDelegate.models objectAtIndex:indexPath.row] name];
    [cell.textLabel setText:roomName];
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setHighlightedTextColor:[UIColor yellowColor]];
    cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"left_selected"]];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_normal"]];
    
    if (indexPath.row == 0) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myAppDelegate.models.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = scrollView.contentOffset.x/844.0;
    for (int i = 0; i < self.detailPageCount; i++) {
        UIImageView *image = (UIImageView *)[self.GuidePanel viewWithTag:GUIDE_PANEL_BASE_TAG + i];
        [image setImage:[UIImage imageNamed:@"unselected"]];
    }
    UIImageView *image = (UIImageView *)[self.GuidePanel viewWithTag:GUIDE_PANEL_BASE_TAG + currentPage];
    [image setImage:[UIImage imageNamed:@"selected"]];
}

- (void)queryMode:(NSThread *)thread
{
    while (YES) {
        if (self.needquery) {
            [self sendCommand:self.currentModel.queryCmd needBack:NO check:NO];
            sleep(1);
        }
    }
}

- (void)setCurrentMode:(NSString *)mode
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        for (int i = MODE_BTN_BASE_TAG; i < MODE_BTN_BASE_TAG + self.currentModel.modesNames.count; i++) {
            if (![mode isEqualToString:[self.currentModel.modeBacks objectAtIndex:i - MODE_BTN_BASE_TAG]]) {
                [(UIButton *)[self.modeView viewWithTag:i] setSelected:NO];
            } else {
                [(UIButton *)[self.modeView viewWithTag:i] setSelected:YES];
            }
        }
    });
}

- (void)sendCommand:(NSString *)cmd needBack:(BOOL)needback check:(BOOL)check;
{
    if ((check)&&(![self.myAppDelegate.socket isConnected])) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"与服务端连接已断开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    } else {
        if (check) {
            [self.myAppDelegate reConnectSocketWithCommand:cmd];
        }
    }
    [self.myAppDelegate sendCommand:cmd from:self needBack:needback];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
