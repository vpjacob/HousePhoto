//
//  JJPictureUpViewController.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/17.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJPictureUpViewController.h"
#import "JJPictureUpApi.h"

@interface JJPictureUpViewController ()

@end

@implementation JJPictureUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"a"];
    JJPictureUpApi *api = [[JJPictureUpApi alloc] initWithImage:image];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@",request.responseObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
