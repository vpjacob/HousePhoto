//
//  JJHomeApi.m
//  HousePhoto
//
//  Created by 刘毅 on 2017/11/27.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJHomeApi.h"

@implementation JJHomeApi{
    NSInteger _page;
}

- (instancetype)initWithPage:(NSInteger)page{
    if (self = [super init]) {
        _page = page;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"http://api.dantangapp.com/v1/collections";
//    return [NSString stringWithFormat:@"http://gank.io/api/data/福利/10/%zd",_page];
//    return @"http://gank.io/api/data/福利/10/1";
}

- (id)requestArgument{
    NSDictionary *dic = @{
                          @"":@(_page),
                          @"offset": @(0)
                          };
    return dic;
}


@end
