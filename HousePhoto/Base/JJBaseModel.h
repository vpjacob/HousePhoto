//
//  JJBaseModel.h
//  HousePhoto
//
//  Created by 刘毅 on 2017/11/22.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "MTLManagedObjectAdapter.h"


@interface JJBaseModel : MTLModel<MTLJSONSerializing,MTLManagedObjectSerializing>
/**
 * search后转变为model模型
 */
+ (NSArray *)searchAll;
+ (NSArray *)searchWithKey:(id)key;
+ (NSArray *)searchWithKey:(id)key value:(id)value;
+ (NSArray *)searchWithPredicate:(NSPredicate *)dicate;

/**
 * search后未进行转换
 */
+ (NSArray *)search;
+ (NSArray *)searchKey:(id)key;
+ (NSArray *)searchKey:(id)key ascending:(BOOL)ascending;
+ (NSArray *)searchKey:(id)key value:(id)value;

/**
 * 转换为model模型
 */
+ (NSArray *)classToModel:(NSArray *)res;

// delete
+ (BOOL)deleteKey:(id)key value:(id)value;
+ (BOOL)deleteModel;

/**
 * 模型(转换后的模型不能调用)
 */
+ (BOOL)deleteWithModel:(id)model;

/**
 *  通过主健的值删除模型(适用于单个主键)
 */
+ (BOOL)deletePrimaryKeyValue:(id)value;

/**
 *  通过predicate条件进行删除
 */
+ (BOOL)deleteWithPredicate:(NSPredicate *)predicate;

/**
 *  保存数据模型
 */
+ (void)saveWithModel:(id)model resultBlock:(void(^)(BOOL success))block;


#pragma mark - Json To Model
/**
 *  通过数据获取 模型或者模型数组
 */
+ (id)changeResponseJSONObject:(id)obj;

/**
 *  通过数据获取模型数组
 */
+ (NSArray *)changeJSONArray:(NSArray *)ary;


#pragma mark - Private Method
/**
 *  设置图片
 *
 *  @param imgView
 *  @param str     地址
 */
//+ (void)iconImageView:(UIImageView *)imgView urlString:(NSString *)str;

/**
 *  转换成描述型字符串
 *
 *  @param str 需要转换的时间 格式为 2016-03-16 16:29:00
 *
 *  @return 描述型字符串
 */
//- (NSString *)transToFuzzyDate:(NSString *)str;


/**
 价格转换成字符串(最多只保留两位小数)
 
 @param price 价格
 @return 价格字符串
 */
- (NSString *)transPrice:(double)price;
+ (NSString *)transPrice:(double)price;
@end
