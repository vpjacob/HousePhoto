//
//  JJLoginApi.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/17.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJLoginApi.h"

@implementation JJLoginApi{
    NSString *_userName;
    NSString *_pwd;
}

- (instancetype)initWithUserName:(NSString *)name pwd:(NSString *)pwd{
    if (self == [super init]) {
        _userName = name;
        
        _pwd = [self md5:pwd];
    }
    return self;
}

- (id)requestArgument{
    
    NSDictionary *dic = @{
                          @"userName": _userName,
                          @"passWord": _pwd,
                          @"securityCode": @"8888",
                          @"loginMode": @"1",
                          };
        
    [self.baseMuDic addEntriesFromDictionary:dic];
    return self.baseMuDic;
}

- (NSString *)requestUrl{
//    return @"http://192.168.0.128:8080/login/userLogin.do";
    return [NSString stringWithFormat:@"%@/login/userLogin.do",kUrl];
}
@end
