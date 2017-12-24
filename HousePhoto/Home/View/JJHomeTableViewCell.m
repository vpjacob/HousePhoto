//
//  JJHomeTableViewCell.m
//  HousePhoto
//
//  Created by 刘毅 on 2017/12/4.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJHomeTableViewCell.h"
#import <UIImageView+WebCache.h>


@implementation JJHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JJHomeModel *)model{
    _model = model;
    NSArray *array = [model.previewImgUrls componentsSeparatedByString:@";"];
    
    for (int i = 0; i < array.count - 1; i++) {
        if (array[i] == nil) {
            return;
        }
        
        if (i == 0) {
             [self.img01 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kUrl,array[i]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            [self.img01 setHidden:NO];
        }else if (i == 1){
              [self.img02 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kUrl,array[i]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            [self.img02 setHidden:NO];
        }else if (i == 2){
              [self.img03 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kUrl,array[i]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            [self.img03 setHidden:NO];
        }
    }
    
    self.name.text = model.name;
   
    
}


@end
