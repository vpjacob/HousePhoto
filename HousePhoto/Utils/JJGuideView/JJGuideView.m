//
//  JJGuideView.m
//  DemoPro
//
//  Created by vpjacob on 2017/4/7.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import "JJGuideView.h"
#import "JJGuideContentView.h"

static NSString *KNGuideViewUserDefaultsKey = @"KNGuideViewUserDefaultsNewKey";

@interface JJGuideView ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) NSArray *pictureArray;
@end

@implementation JJGuideView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createScrollView];
    }
    return self;
}

- (void)createScrollView {
    [self addSubview:self.scrollView];
}

+ (BOOL)isFirstShow {
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:KNGuideViewUserDefaultsKey];
    if (str) {
        return NO;
    }
    return YES;
}

#pragma mark - action
-(void)disMissView {
    [UIView animateWithDuration:2 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KNGuideViewUserDefaultsKey"];
        [[NSUserDefaults standardUserDefaults] setObject:KNGuideViewUserDefaultsKey forKey:KNGuideViewUserDefaultsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (self.completeBlock) {
            self.completeBlock();
        }
        [self removeFromSuperview];
    }];
}

#pragma  mark - getter  or   setter

- (UIScrollView *)scrollView {
    JJ_WS(weakSelf);
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.contentSize = CGSizeMake(kDeviceWidth * 4, kDeviceHeight);
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        for (int i = 0 ; i < 4; i++) {
            JJGuideContentView *contentView = [[JJGuideContentView alloc] initWithIndex:i];
            contentView.startBlock = ^(){
                [weakSelf disMissView];
            };
            [_scrollView addSubview:contentView];
        }
    }
    return _scrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
