//
//  JJArticleDetailApi.h
//  HousePhoto
//
//  Created by vpjacob on 2017/12/24.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJBaseRequest.h"

@interface JJArticleDetailApi : JJBaseRequest
- (instancetype)initWithArticleId:(NSInteger)article_id;
@end
