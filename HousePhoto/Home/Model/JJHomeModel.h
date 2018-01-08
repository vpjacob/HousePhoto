//
//  JJHomeModel.h
//  HousePhoto
//
//  Created by 刘毅 on 2017/12/4.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJBaseModel.h"

@interface JJHomeModel : JJBaseModel
@property (nonatomic, assign)NSInteger articleType;
@property (nonatomic, assign)NSInteger article_id;
@property (nonatomic, assign)NSInteger isDel;
@property (nonatomic, assign)NSInteger isShow;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *previewImgUrls;
@property (nonatomic, strong)NSString *updateTime;
@property (nonatomic, strong)NSString *descriptions;

@end
