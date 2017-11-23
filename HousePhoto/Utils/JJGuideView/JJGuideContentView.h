//
//  JJGuideContentView.h
//  DemoPro
//
//  Created by vpjacob on 2017/4/7.
//  Copyright © 2017年 vpjacob. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JJGuideContentViewStartBlock)();

@interface JJGuideContentView : UIView

- (instancetype)initWithIndex:(NSInteger)index;

@property (nonatomic, copy) JJGuideContentViewStartBlock startBlock;

@end
