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

@interface JJMeViewController ()
@property (nonatomic, strong) JJBaseNav *nav;
@end

@implementation JJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - kTabBarHeight);
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nav];
    self.tableView.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"JJMeHeaderView" owner:self options:nil].lastObject;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    CGFloat offsetY = scrollView.contentOffset.y + kStateBarHeight;
    if (offsetY > 0 && offsetY <= kNavBarHeight) {
        self.nav.backgroundColor = [UIColor colorWithHex:0xff602f alpha:offsetY/kNavBarHeight];
//        self.headerView.frame = CGRectMake(0, kStateBarHeight - offsetY, kDeviceWidth, 180);
    }else if (offsetY > kNavBarHeight){
        self.nav.backgroundColor = [UIColor colorWithHex:0xff602f alpha:offsetY/kNavBarHeight];
//        self.headerView.frame = CGRectMake(0, kStateBarHeight - offsetY, kDeviceWidth, 180);
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.nav.backgroundColor = [UIColor colorWithHex:0xff602f alpha:-offsetY/kNavBarHeight];
//            self.headerView.frame = CGRectMake(0, kStateBarHeight - offsetY, kDeviceWidth, 180 - offsetY);
        } completion:^(BOOL finished) {
            
        }];
    
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 29;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[JJDetailPicViewController new] animated:YES];
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
