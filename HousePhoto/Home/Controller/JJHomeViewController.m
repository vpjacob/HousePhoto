//
//  JJHomeViewController.m
//  HousePhoto
//
//  Created by 刘毅 on 2017/11/22.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJHomeViewController.h"
#import <MJRefresh.h>
#import "JJHomeApi.h"


@interface JJHomeViewController ()

@end

@implementation JJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    JJ_WS(weakSelf);
    
    [self addMJRefreshHeadView:^(NSInteger page) {
        DLog(@"%zd",page);
        [weakSelf netWorkWithPage2:page];
    }];
    
    [self addMJRefreshFootView:^(NSInteger page) {
        DLog(@"%zd",page);
        [weakSelf netWorkWithPage:page];
    }];
    
    [self netWorkWithPage:self.requestPage];
    
}
- (void)netWorkWithPage2:(NSInteger)page{
    JJHomeApi *api = [[JJHomeApi alloc] initWithPage:page];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@-----su",request.responseData);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@----fa----%zd",request,page);
        
        [self requestSuccess:NO requestEnd:NO];
        self.tableView.scrollsToTop = YES;
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)netWorkWithPage:(NSInteger)page{
    JJHomeApi *api = [[JJHomeApi alloc] initWithPage:page];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@-----su",request.responseData);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@----fa----%zd",request,page);
        
        [self requestSuccess:YES requestEnd:NO];
        self.tableView.scrollsToTop = YES;
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - datasorce&delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self netWorkWithPage2:self.requestPage];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).description;
    return cell;
}



@end
