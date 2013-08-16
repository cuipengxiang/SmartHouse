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
        self.myAppDelegate = [[UIApplication sharedApplication] delegate];
        [self setupNavigationBar];
        [self.view setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
    }
    return self;
}


- (void)viewDidLoad
{
    self.currentModel = [self.myAppDelegate.models objectAtIndex:0];
    [super viewDidLoad];
    [self setupModeSelectBar:self.currentModel];
    [self setupDetailView:self.currentModel Type:TYPE_LIGHT];
    [self.tableView setBounces:NO];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView reloadData];
}

//设置导航栏
- (void)setupNavigationBar
{
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background_black"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"智能家居系统"];
    [titleLabel setFont:[UIFont systemFontOfSize:24.0]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel sizeToFit];
    
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"top_navigation_back"] forState:UIControlStateNormal];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [leftButton addTarget:self action:@selector(onBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"top_navigation_back"] forState:UIControlStateNormal];
    [rightButton setTitle:@"设置" forState:UIControlStateNormal];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onSettingsButtonClick
{
    SHSettingsViewController *controller = [[SHSettingsViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)setupModeSelectBar:(SHRoomModel *)currentModel
{
    for (UIButton *button in self.scrollView.subviews) {
        [button removeFromSuperview];
    }
    [self.scrollView setBounces:YES];
    [self.scrollView setDelegate:self];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    self.modesCount = self.currentModel.modesNames.count;
    [self.scrollView setContentSize:CGSizeMake(184*self.currentModel.modesNames.count, 136.0)];
    [self.scrollView setBackgroundColor:[UIColor redColor]];
    for (int i = 0; i < self.currentModel.modesNames.count; i++) {
        UIButton *modeButton = [[UIButton alloc] initWithFrame:CGRectMake(i*184 + 20, 44, 144, 48)];
        [modeButton setTitle:[self.currentModel.modesNames objectAtIndex:i] forState:UIControlStateNormal];
        [modeButton setBackgroundColor:[UIColor blueColor]];
        [modeButton setTag:MODE_BTN_BASE_TAG + i];
        [modeButton addTarget:self action:@selector(onModeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:modeButton];
    }
    
}

- (void)onModeButtonClick:(UIButton *)button
{
    NSString *cmd = [self.currentModel.modesCmds objectAtIndex:button.tag - MODE_BTN_BASE_TAG];
    [self sendCommand:cmd];
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
            break;
        case TYPE_CURTAIN:
            detailViewNames = [[NSMutableArray alloc] initWithArray:self.currentModel.curtainNames];
            detailViewBtns = [[NSMutableArray alloc] initWithArray:self.currentModel.curtainBtns];
            detailViewCmds = [[NSMutableArray alloc] initWithArray:self.currentModel.curtainCmds];
            break;
        case TYPE_MUSIC:
            detailViewNames = [[NSMutableArray alloc] initWithArray:self.currentModel.musicNames];
            detailViewBtns = [[NSMutableArray alloc] initWithArray:self.currentModel.musicBtns];
            detailViewCmds = [[NSMutableArray alloc] initWithArray:self.currentModel.musicNames];
            break;
    }
    if (type != TYPE_MUSIC) {
        int pageCount = detailViewNames.count/6;
        if (detailViewNames.count%6 != 0) {
            pageCount++;
        }
        if (pageCount > 1) {
            [self.detailView setContentSize:CGSizeMake(844*pageCount, 348)];
        }
        for (int i = 0; i < detailViewNames.count; i++) {
            SHDetailContolView *detailViewPanel = [[SHDetailContolView alloc] initWithFrame:CGRectMake(i/6*844 + 30 + (i%3)*265, 45 + i/3%2*155, 250, 140)andTitle:[detailViewNames objectAtIndex:i]];
            [detailViewPanel setButtons:[detailViewBtns objectAtIndex:i] andCmd:[detailViewCmds objectAtIndex:i]];
            [self.detailView addSubview:detailViewPanel];
        }
    } else {
    
    }
}

- (IBAction)onLightClick:(id)sender
{
    [self setupDetailView:self.currentModel Type:TYPE_LIGHT];
}

- (IBAction)onCuitainClick:(id)sender
{
    [self setupDetailView:self.currentModel Type:TYPE_CURTAIN];
}

- (IBAction)onMusicClick:(id)sender
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
    UIImageView *separator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53, cell.frame.size.width, 1)];
    [separator setImage:[UIImage imageNamed:@"vio_line2"]];
    [cell addSubview:separator];
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


- (void)sendCommand:(NSString *)cmd
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:cmd delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
