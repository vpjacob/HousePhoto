//
//  JJComposeArticalApi.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/24.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJComposeArticalApi.h"

@implementation JJComposeArticalApi{
    NSDictionary *_dic;
}
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
    _dic = dic;
    }
    return self;
}

- (NSString *)requestUrl{
    return [NSString stringWithFormat:@"%@/iosarticle/saveArticle.do",kUrl];
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (id)requestArgument{
    return _dic;
}

@end
