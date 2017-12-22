//
//  JJTabBarController.m
//  HousePhoto
//
//  Created by 刘毅 on 2017/11/22.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJTabBarController.h"
#import "JJHomeViewController.h"
#import "JJMeViewController.h"
#import "JJBaseNavigationController.h"

@interface JJTabBarController ()
//@property (nonatomic, strong)
@end

@implementation JJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatVC:@"JJHomeViewController" selectedImgStr:@"tab_home" unSelectedImgStr:@"tab_home_un" title:@"首页"];
    [self creatVC:@"JJMeViewController" selectedImgStr:@"tab_me" unSelectedImgStr:@"tab_me_un" title:@"我的"];

}

- (void)creatVC:(NSString *)vcName selectedImgStr:(NSString *)selectedImgStr unSelectedImgStr:(NSString *)unSelectedImgStr title:(NSString *)title{
    
    Class cls = NSClassFromString(vcName);
    UIViewController *vc = [[cls alloc] init];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImgStr];
    vc.tabBarItem.image = [UIImage imageNamed:unSelectedImgStr];
    vc.title = title;
    JJBaseNavigationController *nav = [[JJBaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

@end
