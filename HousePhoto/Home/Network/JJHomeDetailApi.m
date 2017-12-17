//
//  JJHomeDetailApi.m
//  HousePhoto
//
//  Created by vpjacob on 2017/12/17.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJHomeDetailApi.h"

@implementation JJHomeDetailApi{
    NSInteger _articleId;
    NSString *_uid;
}
- (NSString *)requestUrl{
    return [NSString stringWithFormat:@"%@/article/loadArticleInfo.do",kUrl];
}
- (instancetype)initWithArticleId:(NSInteger)articleId{
    if (self == [super init]) {
        _articleId = articleId;
        _uid = [[NSUserDefaults standardUserDefaults] objectForKey:kUid];
    }
    return self;
}

- (id)requestArgument{
    NSDictionary *dic = @{
                          @"articleId":@(_articleId),
                          @"uid":_uid,
                          };
    return dic;
}

@end
