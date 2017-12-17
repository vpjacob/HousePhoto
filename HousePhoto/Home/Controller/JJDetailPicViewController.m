//
//  JJDetailPicViewController.m
//  HousePhoto
//
//  Created by 刘毅 on 2017/12/4.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJDetailPicViewController.h"
#import "JJHomeDetailApi.h"

@interface JJDetailPicViewController ()

@end

@implementation JJDetailPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    JJHomeDetailApi *api = [[JJHomeDetailApi alloc] initWithArticleId:2];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@",request.responseObject);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}




@end
