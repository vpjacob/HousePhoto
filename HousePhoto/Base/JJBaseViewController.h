//
//  JJBaseViewController.h
//  HousePhoto
//
//  Created by 刘毅 on 2017/11/22.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

typedef void(^JJMJFooterLoadCompleteBlock)(NSInteger page);
typedef void(^JJMJHeaderLoadCompleteBlock)(NSInteger page);

@interface JJBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger requestPage; //加载页数


/**
 *  添加下拉加载更多
 */
- (void)addMJRefreshHeadView:(JJMJHeaderLoadCompleteBlock)completeBlock;

/**
 *  添加上拉加载更多
 */
- (void)addMJRefreshFootView:(JJMJFooterLoadCompleteBlock)completeBlock;

- (void)requestSuccess:(BOOL)success requestEnd:(BOOL)end;


@end
