//
//  JJArticleDetailViewController.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/24.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJArticleDetailViewController.h"
#import "JJArticleDetailApi.h"

@interface JJArticleDetailViewController ()

@end

@implementation JJArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DLog(@"%zd",self.articleId);
    [self getNetwork];
}

- (void)getNetwork{
    JJArticleDetailApi *api = [[JJArticleDetailApi alloc] initWithArticleId:self.articleId];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@-----su",request.responseObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
