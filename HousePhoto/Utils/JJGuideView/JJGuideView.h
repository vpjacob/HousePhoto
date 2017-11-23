//
//  JJGuideView.h
//  DemoPro
//
//  Created by vpjacob on 2017/4/7.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JJGuideViewCompleteBlock)(void);

@interface JJGuideView : UIView

@property (nonatomic, copy) JJGuideViewCompleteBlock completeBlock;

- (instancetype)initWithFrame:(CGRect)frame;
+ (BOOL)isFirstShow;

@end
