//
//  JJBaseRequest.m
//  DemoPro
//
//  Created by vpjacob on 2017/4/26.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJBaseRequest.h"
#import "JJBaseRequestAccessory.h"
#import "NSString+MD5.h"

@interface JJBaseRequest ()
@property (nonatomic, strong) JJBaseRequestAccessory *accessory;
@end

@implementation JJBaseRequest

- (instancetype)init {
    if (self = [super init]) {
        [self addAccessory:self.accessory];
    }
    return self;
}

#pragma mark - YTKRequest Configure
- (NSTimeInterval)requestTimeoutInterval {
    return 20;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}

//- (id)requestArgument {
//    return self.appendSecretDic;
//}

#pragma mark - Getter & Setter
- (NSMutableDictionary *)baseMuDic {
    if (!_baseMuDic) {
        NSDictionary *dic = @{
//                              @"version":KNB_APP_VERSION,
//                              @"platform":@"mtmy",
//                              @"client":@"ios",
                              };
        _baseMuDic = [NSMutableDictionary dictionary];
        [_baseMuDic addEntriesFromDictionary:dic];
    }
    return _baseMuDic;
}

- (NSString *)getAppdingURLString:(NSString *)urlstring{
    return [kUrl stringByAppendingString:urlstring];
//    return [NSString stringWithFormat:@"%@%@",kUrl,urlstring];
}

- (JJBaseRequestAccessory *)accessory {
    if (!_accessory) {
        _accessory = [[JJBaseRequestAccessory alloc] init];
    }
    return _accessory;
}

#pragma mark - Private Method
- (NSInteger)getRequestStatuCode {
    NSDictionary *jsonDic = self.responseJSONObject;
    return [[jsonDic objectForKey:@"statusCode"] integerValue];
}

- (BOOL)statusCodeSuccess {
    return [self getRequestStatuCode] == 1;
}

- (NSString *)errMessage {
    NSDictionary *jsonDic = self.responseJSONObject;
    return [jsonDic objectForKey:@"msg"];
}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}



+ (BOOL)isNullString:(NSString *)str {
    return str.length == 0 || [str isKindOfClass:[NSNull class]];
}

@end
