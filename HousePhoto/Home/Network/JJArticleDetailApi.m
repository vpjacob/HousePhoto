//
//  JJArticleDetailApi.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/24.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJArticleDetailApi.h"

@implementation JJArticleDetailApi{
    NSInteger _article_id;
}
- (instancetype)initWithArticleId:(NSInteger)article_id{
    if (self == [super init]) {
        _article_id = article_id;
    }
    return self;
}

- (NSString *)requestUrl{
    return [NSString stringWithFormat:@"%@/iosarticle/loadArticleInfo.do",kUrl];
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (id)requestArgument{
    NSDictionary *dic = @{
                          @"articleId":@(_article_id)
                          };
    return dic;
}


@end
