//
//  JJLoginViewController.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/17.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJLoginViewController.h"
#import "JJLoginApi.h"
#import "AppDelegate.h"

@interface JJLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation JJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)LoginAction:(id)sender {
    
    JJLoginApi *api = [[JJLoginApi alloc] initWithUserName:@"123" pwd:@"123"];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
         DLog(@"%@",request.responseObject);
        NSNumber *statusCode = request.responseObject[kStatusCode];
//        NSString *uid = request.responseObject[kUid];
        NSString *uid = @"a";
        DLog(@"%@",statusCode);
        if ([statusCode integerValue] == 1) {
            DLog(@"登录成功");
            [[NSUserDefaults standardUserDefaults] setObject:uid forKey:kUid];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRootVC" object:nil];
        }else{
            DLog(@"登录失败");
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        DLog(@"%@",request.responseObject);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
