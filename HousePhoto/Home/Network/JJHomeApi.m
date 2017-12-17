//
//  JJHomeApi.m
//  HousePhoto
//
//  Created by 刘毅 on 2017/11/27.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJHomeApi.h"

@implementation JJHomeApi{
    NSInteger _pageNo;
    NSInteger _pageSize;
    NSString *_uid;
}

- (instancetype)initWithPage:(NSInteger)pageNo pageSize:(NSInteger)pageSize{
    if (self = [super init]) {
        _pageNo = pageNo;
        _pageSize = pageSize;
        _uid = [[NSUserDefaults standardUserDefaults] objectForKey:kUid];
    }
    return self;
}

- (NSString *)requestUrl{
    
    return [NSString stringWithFormat:@"%@/article/loadArticleList.do",kUrl];
}

- (id)requestArgument{
    NSDictionary *dic = @{
                          @"pageNo":@(_pageNo),
                          @"pageSize":@(_pageSize),
                          @"searchStr":@"",
                          @"uid":_uid,
                          };
    return dic;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

//- (instancetype)initWithPage:(NSInteger)page{
//    if (self = [super init]) {
//        _page = page;
//    }
//    return self;
//}
//
//- (NSString *)requestUrl{
//    return @"http://api.dantangapp.com/v1/collections";
//}
//
//- (id)requestArgument{
//    NSDictionary *dic = @{
//                          @"":@(_page),
//                          @"offset": @(0)
//                          };
//    return dic;
//}


@end
