//
//  JJBaseRequestAccessory.m
//  DemoPro
//
//  Created by vpjacob on 2017/4/26.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJBaseRequestAccessory.h"
#import <AFNetworkReachabilityManager.h>
#import "JJBaseRequest.h"
#import <LCProgressHUD.h>
#import "NSString+Empty.h"
#import "AppDelegate.h"
#import "JJGuideView.h"

@interface JJBaseRequestAccessory ()

@property (nonatomic, assign) BOOL isReachable; // 没有网络

@end

@implementation JJBaseRequestAccessory

- (void)requestWillStart:(id)request {
    if ([JJGuideView isFirstShow]) {
        return;
    }
    self.isReachable = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![AFNetworkReachabilityManager sharedManager].reachable) {
            self.isReachable = NO;
            [LCProgressHUD showInfoMsg:@"小主,您的网络状态差,请稍后重试!"];
        }
        else {
            JJBaseRequest *baseRequest = (JJBaseRequest *)request;
            if (baseRequest.hudString) {
                [LCProgressHUD showLoading:baseRequest.hudString];
            }
        }
    });
}

- (void)requestWillStop:(id)request {
    if (!self.isReachable || [JJGuideView isFirstShow]) {
        return;
    }
    JJBaseRequest *baseRequest = (JJBaseRequest *)request;
    NSInteger JJErrorCode_UserTokenOverTime = 10034; // token过期
    if (baseRequest.getRequestStatuCode == JJErrorCode_UserTokenOverTime) {
        [LCProgressHUD showMessage:@"为了您的帐号安全,请重新登录!"];
//        [(AppDelegate *)[UIApplication sharedApplication].delegate showLoginViewController];
        return;
    }
    if (baseRequest.hudString) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (baseRequest.error) {
                [LCProgressHUD showFailure:baseRequest.errMessage];
                return;
            }
            
            if (baseRequest.statusCodeSuccess) {
                [LCProgressHUD hide];
            }
            else {
                [LCProgressHUD showFailure:baseRequest.errMessage];
            }
        });
       
    }
}

@end
