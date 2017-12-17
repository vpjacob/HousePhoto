//
//  JJMeViewController.m
//  HousePhoto
//
//  Created by 刘毅 on 2017/11/22.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJMeViewController.h"
#import "JJDetailPicViewController.h"
#import "JJBaseNav.h"
#import "UIColor+Hex.h"
#import <SDImageCache.h>
#import <WeiboSDK.h>

@interface JJMeViewController ()<UITableViewDelegate,WBMediaTransferProtocol>
@property (nonatomic, strong) JJBaseNav *nav;        
@end

@implementation JJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view.
    self.tableView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - kTabBarHeight);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nav];
    self.tableView.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"JJMeHeaderView" owner:self options:nil].lastObject;
    self.tableView.tableFooterView = [UIView new];
}

- (void)initData{
    
    [self.dataSource addObjectsFromArray:@[
                                           @"分享给好友",
                                           @"清除缓存",
                                           @"退出",
                                           ]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y + kStateBarHeight;
    if (offsetY > 0 && offsetY <= kNavBarHeight) {
        self.nav.backgroundColor = [UIColor colorWithHex:0xff602f alpha:offsetY/kNavBarHeight];
    }else if (offsetY > kNavBarHeight){
        self.nav.backgroundColor = [UIColor colorWithHex:0xff602f alpha:offsetY/kNavBarHeight];
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.nav.backgroundColor = [UIColor colorWithHex:0xff602f alpha:-offsetY/kNavBarHeight];
        } completion:^(BOOL finished) {
            
        }];
    
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {//分享
////        [WeiboSDK shareToWeibo:@"ddd"];
//        UIImage *img = [UIImage imageNamed:@"a"];
//        WBMessageObject *megObj = [[WBMessageObject alloc] init];
////        [megObj.imageObject addImages:@[img,img,img]];
//        megObj.text = @"分享~民宿";
//        
////        megObj.imageObject = @[img,img,img];
//        WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:megObj];
//        [WeiboSDK sendRequest:req];
//        UIImage *image = [UIImage imageNamed:@"a"];
//        UIImage *image1 = [UIImage imageNamed:@"a"];
//        WBImageObject *imageObject = [WBImageObject object];
//        [imageObject addImages:@[image,image1]];
//        imageObject.delegate = self;
        
    }else if (indexPath.row == 1){//清除缓存
         NSUInteger ints = [[SDImageCache sharedImageCache] getSize];
        NSLog(@"%zd",ints);
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        NSUInteger intss = [[SDImageCache sharedImageCache] getSize];
        NSLog(@"%zd",intss);
    }else if (indexPath.row == 2){//退出
        
    }

}


/**
 数据准备成功回调
 */
-(void)wbsdk_TransferDidReceiveObject:(id)object{
    
    DLog(@"%@",object);
    
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"ddd";
    
    message.imageObject = object;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
    
}

/**
 数据准备失败回调
 */
-(void)wbsdk_TransferDidFailWithErrorCode:(WBSDKMediaTransferErrorCode)errorCode andError:(NSError*)error{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (JJBaseNav *)nav{
    if (!_nav) {
        _nav = [[JJBaseNav alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kNavBarHeight)];
    }
    return _nav;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

@end
