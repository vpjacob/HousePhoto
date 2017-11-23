//
//  JJGuideContentView.m
//  DemoPro
//
//  Created by vpjacob on 2017/4/7.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJGuideContentView.h"

@interface JJGuideContentView ()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *datasArray;

@end

@implementation JJGuideContentView

- (instancetype)initWithIndex:(NSInteger)index {
    _index = index;
    return [self initWithFrame:CGRectMake(index * kDeviceWidth, 0, kDeviceWidth, kDeviceHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    self.backgroundColor = [UIColor whiteColor];
    if (_index < 3) {
        UIImage *originImage = [UIImage imageNamed:[NSString stringWithFormat:@"welcome_%@",@(self.index + 1)]];
        //        CGFloat imgWidth = originImage.size.width;
        //        CGFloat imgHeight = originImage.size.height;
        //        if (imgWidth > JJ_SCREEN_WIDTH) {
        //            CGFloat newWidth = JJ_SCREEN_WIDTH;
        //            imgHeight = (imgWidth / newWidth) * JJ_SCREEN_HEIGHT;
        //            imgWidth = newWidth;
        //        }
        //        if (imgHeight > JJ_SCREEN_HEIGHT - 10) {
        //            CGFloat newHeight = JJ_SCREEN_HEIGHT - 60;
        //            imgWidth = (imgHeight / newHeight) * JJ_SCREEN_WIDTH * 0.8;
        //            imgHeight = newHeight;
        //        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        imageView.image = originImage;
        [self addSubview:imageView];
    }
    else {
        
        //        UIImageView *topImgView = [[UIImageView alloc] initWithFrame:CGRectMake((JJ_SCREEN_WIDTH - 305) - 2, 0, 305, 319)];
        //        topImgView.image = [UIImage imageNamed:@"guide3_top"];
        //        [self addSubview:topImgView];
        //
        //        CGFloat bottomHeight = (436.0 / 750.0) * JJ_SCREEN_WIDTH;
        //        UIImageView *bottomImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, JJ_SCREEN_HEIGHT - bottomHeight, JJ_SCREEN_WIDTH, bottomHeight)];
        //        bottomImgView.image = [UIImage imageNamed:@"guide3_bottom"];
        //        [self addSubview:bottomImgView];
        //
        //        UIImageView *startImage = [[UIImageView alloc] initWithFrame:CGRectMake((JJ_SCREEN_WIDTH - 130)/2 , (JJ_SCREEN_HEIGHT - 32)/2 + 40, 130, 32)];
        //        startImage.image = [UIImage imageNamed:@"guide3_btn"];
        //        startImage.userInteractionEnabled = YES;
        //        [self addSubview:startImage];
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAction)];
        //        [startImage addGestureRecognizer:tap];
        
        UIImage *originImage = [UIImage imageNamed:[NSString stringWithFormat:@"welcome_%@",@(self.index + 1)]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        imageView.userInteractionEnabled = YES;
        imageView.image = originImage;
        [self addSubview:imageView];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kDeviceWidth - 80)*0.5, kDeviceHeight - 80, 80, 30);
        [btn setTitle:@"点击开始" forState:UIControlStateNormal];
        [imageView addSubview:btn];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (void)startAction {
    if (self.startBlock) {
        self.startBlock();
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
