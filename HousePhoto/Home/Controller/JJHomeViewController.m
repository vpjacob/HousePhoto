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
#import "JJHomeTableViewCell.h"
#import "XLPhotoBrowser.h"
#import <GoogleMobileAds/GoogleMobileAds.h>


@interface JJHomeViewController ()
@property(nonatomic, strong) GADInterstitial*interstitial;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ADAction) name:@"showADAction" object:nil];
    
}

- (void)ADAction{
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    } else {
        NSLog(@"Ad wasn't ready");
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
//    [self netWorkWithPage2:self.requestPage];
    self.interstitial = [[GADInterstitial alloc]
                         initWithAdUnitID:@"ca-app-pub-9554187975714748/6109741924"];
    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
    
    
    UIImage *img = [UIImage imageNamed:@"placeholder"];
    [XLPhotoBrowser showPhotoBrowserWithImages:@[img,img,img,img,img] currentImageIndex:0];
//    JJADViewController *ad = [JJADViewController new];
//    [self.navigationController pushViewController:ad animated:YES];
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJHomeTableViewCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"JJHomeTableViewCell" owner:self options:nil].lastObject;
    }
    
    return cell;
}



@end
