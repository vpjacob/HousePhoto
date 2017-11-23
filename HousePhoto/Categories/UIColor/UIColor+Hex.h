//
//  UIColor+Hex.h
//  KenuoTraining
//
//  Created by Robert on 16/2/22.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 *  十六进制色值转换为UIColor（alpha）
 *
 *  @param hexValue 十六进制色值
 *  @param alpha    透明度
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;

/**
 *  十六进制色值转换为UIColor
 *
 *  @param hexValue 十六进制色值
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHex:(int)hexValue;

/**
 *  十六进制色值转换为UIColor
 *
 *  @param hexValue 十六进制色值
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHexString:(NSString *)hexValue;

+ (UIColor *)knBlackColor;
+ (UIColor *)knLightGrayColor;
+ (UIColor *)knYellowColor;
+ (UIColor *)knBgColor;
+ (UIColor *)knRedColor;
+ (UIColor *)knBRedColor;
+ (UIColor *)knLightRedColor;
+ (UIColor *)knDarkRedColor;
+ (UIColor *)knTitleTextColor;
+ (UIColor *)knCuttingLineColor;
+ (UIColor *)knLightBlackColor;
+ (UIColor *)knWhiteGrayColor;
+ (UIColor *)knBWhiteGrayColor ;
+ (UIColor *)knLightWhiteGrayColor;

+ (UIColor *)knThemeColor;
+ (UIColor *)knThemeLightColor;
+ (UIColor *)knThemeLightBgColor;
+ (UIColor *)knThemeBlackColor;
+ (UIColor *)knThemeLightBlackColor;
+ (UIColor *)knCountArrearageColor;
+ (UIColor *)knFailGrayColor;


@end
