//
//  JJComposeAritcleViewController.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/24.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJComposeAritcleViewController.h"
#import "JJPictureUpApi.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "JJComposeArticalApi.h"

@interface JJComposeAritcleViewController ()<TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong)NSMutableArray *imgUrlsArray;
@property (nonatomic, strong)NSMutableString *imgUrlsMString;

@end

@implementation JJComposeAritcleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imgUrlsArray = [NSMutableArray array];
    self.imgUrlsMString = [NSMutableString string];
}

- (IBAction)sendArtical:(id)sender {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentString = [formatter stringFromDate:date];
    NSDictionary *param = @{@"pictureUrl":self.imgUrlsArray.description,@"articleId":@(0),@"createTime":currentString,@"isDel":@(0)};
    
    NSString *st = [self addParam:self.imgUrlsArray];
    
    NSDictionary *dic = @{
                                  @"description":self.contentTextView.text,
                                  @"articleType":@(0),
                                  @"name":@"title",
                                  @"previewImgUrls":self.imgUrlsMString,
                                  @"param":st,
                          };
    
    JJComposeArticalApi *api = [[JJComposeArticalApi alloc] initWithDic:dic];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@",request.responseObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (NSString *)addParam:(NSArray *)param{
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSString *imgStr in param) {
        [mArray addObject:@{
                            @"pictureUrl":imgStr,
                            @"isDel":@(0)
                            }];
    }
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:mArray options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return jsonStr;
}

- (IBAction)selectedImage:(UIButton *)sender{
    TZImagePickerController *imgPickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
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
   __block NSInteger index = 0;
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        for (YTKBaseRequest *api in batchRequest.requestArray) {
            DLog(@"%@",api.responseObject);
            [self.imgUrlsArray addObject:api.responseObject[@"fileUrl"]];
            if ([api.responseObject[@"statusCode"] integerValue] == 1) {
//                NSString *str = api.responseObject[@"fileUrl"];
                for (index; index<3; index++) {
                     [self.imgUrlsMString appendFormat:@"%@;",api.responseObject[@"fileUrl"]];
                }
               
                
            }
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

@end
