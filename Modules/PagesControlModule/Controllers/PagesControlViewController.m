//
//  PagesControlViewController.m
//  SimpleDo
//
//  Created by gukong on 15/7/27.
//  Copyright (c) 2015年 gukong. All rights reserved.
//

#import "PagesControlViewController.h"
#import "PagesControlView.h"
#import "ClockPlateViewController.h"
#import "PagesDataManager.h"
#import "PageNavigationBar.h"
#import "EventItem.h"

@interface PagesControlViewController () <PagesControlDelegate, PageNavigationBarDelegate> {
    
    
}
@property (nonatomic, strong) PageNavigationBar *pageNavigationBar;
@property (nonatomic, strong) PagesDataManager *pagesDataManager;
@property (nonatomic, strong) PagesControlView *controlView;


@end

@implementation PagesControlViewController

+ (id)pagesControl {
    PagesControlViewController *pagesControl = [[PagesControlViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:pagesControl];
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupDataModle {
    _pagesDataManager = [[PagesDataManager alloc] init];
}

- (void)setupViews {
    [self setupControlView];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    [self.navigationController.navigationBar setHidden:YES];
    _pageNavigationBar = [[PageNavigationBar alloc] initWithFrame:CGRectMake(0, 0, Width_V(self.view), 64.f)];
    [_pageNavigationBar setNavigationBarDataSource:_pagesDataManager];
    [_pageNavigationBar setDelegate:self];
    [_pageNavigationBar setAssociateScrollView:_controlView];
    [self.view addSubview:_pageNavigationBar];
}

- (void)setupControlView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(Width_V(self.view), Height_V(self.view))];
    [flowLayout setMinimumLineSpacing:0.f];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    _controlView = [[PagesControlView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout rootViewController:self];
    [_controlView setControlViewDataSource:_pagesDataManager];
    [_controlView setControlViewDelegate:self];
    [self.view addSubview:_controlView];
}

#pragma mark - PagesControlDelegate
- (void)controlViewDidScroll:(PagesControlView *)controlView {

}

- (void)controlView:(PagesControlView *)controlView fromPage:(NSInteger)fromPage toPage:(NSInteger)toPage {
    
}

#pragma mark - PageNavigationBarDelegate

- (void)tapActionOnNavigationItem:(PageNavigationItem *)navigationItem atIndex:(NSInteger)index {
    if (_pageNavigationBar.currentIndex != index) {
        [_controlView scrollToPage:index];
    }
}

@end
