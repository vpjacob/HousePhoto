//
//  JJBaseViewController.m
//  HousePhoto
//
//  Created by 刘毅 on 2017/11/22.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJBaseViewController.h"
#import "JJMJRefreshNoMoreDataFooter.h"

@interface JJBaseViewController ()
@property (nonatomic, copy) JJMJFooterLoadCompleteBlock footerCompleteBlock;
@end

@implementation JJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    
}

#pragma mark -  MJRefresh
- (void)addMJRefreshFootView:(JJMJFooterLoadCompleteBlock)completeBlock {
    UIImage *nomoImage = [UIImage imageNamed:@"base_nomore"];
    JJMJRefreshNoMoreDataFooter *knbFooter = [JJMJRefreshNoMoreDataFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [knbFooter setImage:nomoImage];
    self.tableView.mj_footer = knbFooter;
    
}

- (void)loadMoreData {
    self.requestPage += 1;
    if (self.footerCompleteBlock) {
        self.footerCompleteBlock(self.requestPage);
    }
}

- (void)requestSuccess:(BOOL)success requestEnd:(BOOL)end {
    [self.tableView.mj_header endRefreshing];
    
    if (end) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView reloadData];
        return;
    }
    if (!success && self.requestPage > 1) {
        self.requestPage -= 1;
    }
    else {
        [self.tableView reloadData];
    }
}



- (void)addMJRefreshHeadView:(JJMJHeaderLoadCompleteBlock)completeBlock {
    JJ_WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView.mj_footer resetNoMoreData];
        weakSelf.requestPage = 1;
        if (completeBlock) {
            completeBlock(1);
        }
    }];
    
}

#pragma mark - Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}



#pragma mark - lazy



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kDeviceWidth, kDeviceHeight - kTabBarHeight - kNavBarHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate  = self;
        
    }
    return _tableView;
}

@end
