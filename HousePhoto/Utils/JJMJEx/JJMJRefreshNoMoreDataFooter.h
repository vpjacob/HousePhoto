//
//  JJMJRefreshNoMoreDataFooter.h
//  DemoPro
//
//  Created by vpjacob on 2017/4/7.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface JJMJRefreshNoMoreDataFooter : MJRefreshBackStateFooter

@property (weak, nonatomic, readonly) UIImageView *gifView;

- (void)setImage:(UIImage *)image;

@end
