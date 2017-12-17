//
//  JJHomeModel.m
//  HousePhoto
//
//  Created by 刘毅 on 2017/12/4.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJHomeModel.h"

@implementation JJHomeModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    [muDic addEntriesFromDictionary:[NSDictionary mtl_identityPropertyMapWithModel:self.class]];
    muDic[@"article_id"] = @"id";
    return muDic;
}

@end
