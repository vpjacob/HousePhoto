//
//  JJHomeTableViewCell.h
//  HousePhoto
//
//  Created by 刘毅 on 2017/12/4.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJHomeModel.h"

@interface JJHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img01;
@property (weak, nonatomic) IBOutlet UIImageView *img02;
@property (weak, nonatomic) IBOutlet UIImageView *img03;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic, strong)JJHomeModel *model;

@end
