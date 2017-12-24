//
//  JJPictureUpViewController.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/17.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJPictureUpViewController.h"
#import "JJPictureUpApi.h"
#import <TZImagePickerController/TZImagePickerController.h>


@interface JJPictureUpViewController ()<TZImagePickerControllerDelegate>

@end

@implementation JJPictureUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(selectedImg) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)selectedImg{
    TZImagePickerController *imgPickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
//    [imgPickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
//
//    }];
    [self presentViewController:imgPickerVc animated:YES completion:nil];
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
//    UIImage *image = [UIImage imageNamed:@"a"];
    NSMutableArray *array = [NSMutableArray array];
    for (UIImage *image in photos) {
        JJPictureUpApi *api = [[JJPictureUpApi alloc] initWithImage:image];
        [array addObject:api];
    }
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:array];
    
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        for (YTKBaseRequest *api in batchRequest.requestArray) {
            DLog(@"%@",api.responseObject);
        }
        
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        
    }];
    
    
}

- (void)upLoad{
    
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
