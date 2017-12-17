//
//  JJLoginApi.h
//  HousePhoto
//
//  Created by vpjacob on 2017/12/17.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJBaseRequest.h"

@interface JJLoginApi : JJBaseRequest
- (instancetype)initWithUserName:(NSString *)name pwd:(NSString *)pwd;

@end
