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
#import "JJHomeModel.h"
#import "JJDetailPicViewController.h"
#import "JJPictureUpViewController.h"

@interface JJHomeViewController ()<XLPhotoBrowserDelegate,XLPhotoBrowserDatasource>
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
        [weakSelf netWorkWithPage:page];
    }];
    
    [self addMJRefreshFootView:^(NSInteger page) {
        DLog(@"%zd",page);
        [weakSelf netWorkWithPage:page];
    }];
    
    [self netWorkWithPage:1];
    
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

- (void)netWorkWithPage:(NSInteger)page{
    DLog(@"%zd",page);
    JJHomeApi *api = [[JJHomeApi alloc] initWithPage:page pageSize:20];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *str = request.responseObject[@"info"];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];

        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        DLog(@"%@-----su",array);
        DLog(@"%@-----su",request.responseObject[@"info"]);

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@----fa----%zd",request,page);

        [self requestSuccess:NO requestEnd:NO];
        self.tableView.scrollsToTop = YES;
        [self.tableView.mj_footer endRefreshing];
    }];
}


//- (void)netWorkWithPage2:(NSInteger)page{
//    JJHomeApi *api = [[JJHomeApi alloc] initWithPage:page];
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        DLog(@"%@-----su",request.responseData);
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        DLog(@"%@----fa----%zd",request,page);
//
//        [self requestSuccess:NO requestEnd:NO];
//        self.tableView.scrollsToTop = YES;
//        [self.tableView.mj_footer endRefreshing];
//    }];
//}

//- (void)netWorkWithPage:(NSInteger)page{
//    JJHomeApi *api = [[JJHomeApi alloc] initWithPage:page];
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        DLog(@"%@-----su",request.responseData);
//
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        DLog(@"%@----fa----%zd",request,page);
//
//        [self requestSuccess:YES requestEnd:NO];
//        self.tableView.scrollsToTop = YES;
//        [self.tableView.mj_footer endRefreshing];
//    }];
//}


#pragma mark - datasorce&delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self netWorkWithPage2:self.requestPage];
//    self.interstitial = [[GADInterstitial alloc]
//                         initWithAdUnitID:@"ca-app-pub-9554187975714748/6109741924"];
//    GADRequest *request = [GADRequest request];
//    [self.interstitial loadRequest:request];
//
//   XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithCurrentImageIndex:indexPath.row imageCount:5 datasource:self];
//    [browser setActionSheetWithTitle:@"选择" delegate:self cancelButtonTitle:nil deleteButtonTitle:nil otherButtonTitles:@"发送给朋友",@"保存图片",@"收藏",@"投诉举报",nil];

//    [self.navigationController pushViewController:[JJDetailPicViewController new] animated:YES];

    [self.navigationController pushViewController:[JJPictureUpViewController new] animated:YES];
    
}

- (UIImage *)photoBrowser:(XLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    return [UIImage imageNamed:@"placeholder"];
}

- (NSURL *)photoBrowser:(XLPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
//    return
    
     NSArray<NSString *> * array = @[
                               @"http://upload-images.jianshu.io/upload_images/1455933-7245174910b68599.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                               @"http://upload-images.jianshu.io/upload_images/1455933-e74ae4df495938b7.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                               @"http://upload-images.jianshu.io/upload_images/1455933-ee53be08d63a0d22.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                               @"http://upload-images.jianshu.io/upload_images/1455933-412255ddafdde125.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                               @"http://upload-images.jianshu.io/upload_images/1455933-cee5618e9750de12.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                               
                               ];
    
    return [NSURL URLWithString:array[index]];
    
}

- (void)photoBrowser:(XLPhotoBrowser *)browser clickActionSheetIndex:(NSInteger)actionSheetindex currentImageIndex:(NSInteger)currentImageIndex{
    switch (actionSheetindex) {
       
        case 1: // 发送
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
            [browser saveCurrentShowImage];
        }
            break;
        case 2: // 保存
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
            [browser saveCurrentShowImage];
        }
            break;
        case 3: // 保存
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
            [browser saveCurrentShowImage];
        }
            break;
        case 4: // 删除
        {
            
        }
            break;
        default:
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
        }
            break;
    }
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
