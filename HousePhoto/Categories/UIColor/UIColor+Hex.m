//
//  UIColor+Hex.m
//  KenuoTraining
//
//  Created by Robert on 16/2/22.
//  Copyright © 2016年 Robert. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue {
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexValue
{
    UIColor *defaultResult = [UIColor whiteColor];
    if ([hexValue hasPrefix:@"#"] && [hexValue length] > 1) {
        hexValue = [hexValue substringFromIndex:1];
    }
    NSUInteger componentLength = 0;
    if ([hexValue length] == 3) {
        componentLength = 1;
    } else if ([hexValue length] == 6) {
        componentLength = 2;
    } else {
        return defaultResult;
    }
    
    BOOL isValid = YES;
    CGFloat components[3];
    
    for (NSUInteger i = 0; i < 3; i++) {
        NSString *component = [hexValue substringWithRange:NSMakeRange(componentLength * i, componentLength)];
        if (componentLength == 1) {
            component = [component stringByAppendingString:component];
        }
        NSScanner *scanner = [NSScanner scannerWithString:component];
        unsigned int value;
        isValid &= [scanner scanHexInt:&value];
        components[i] = (CGFloat)value / 255.0f;
    }
    if (!isValid)
        return defaultResult;
    
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:1.0];
}


+ (UIColor *)knBlackColor {
    return [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1.0];
}

+ (UIColor *)knLightGrayColor {
    return [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
}

+ (UIColor *)knYellowColor {
    return [UIColor colorWithRed:235/255.0 green:189/255.0 blue:48/255.0 alpha:1.0];
}


+ (UIColor *)knBgColor {
    return [UIColor colorWithHex:0xF5F5F5];
}

+ (UIColor *)knRedColor {
    return [UIColor colorWithRed:237/255.0 green:55/255.0 blue:86/255.0 alpha:1.0];
}

+ (UIColor *)knBRedColor {
    return [UIColor colorWithRed:237/255.0 green:55/255.0 blue:86/255.0 alpha:0.7];
}

+ (UIColor *)knLightRedColor {
    return [UIColor colorWithHex:0xF43B22];
}

+ (UIColor *)knDarkRedColor {
    return [UIColor colorWithHex:0xF21C1C];
}

+ (UIColor *)knTitleTextColor {
    return [UIColor colorWithHex:0x999999];
}

+ (UIColor *)knCuttingLineColor {
    return [UIColor colorWithHex:0xe5e5e5];
}


+ (UIColor *)knLightBlackColor {
    return [UIColor colorWithHex:0x4D4D4D];
}

+ (UIColor *)knWhiteGrayColor {
    return [UIColor colorWithHex:0xCCCCCC];
}

+ (UIColor *)knBWhiteGrayColor {
    return [UIColor colorWithHex:0xEDEDED];
}

+ (UIColor *)knLightWhiteGrayColor {
    return [UIColor colorWithHex:0xE6E6E6];
}

+ (UIColor *)knThemeColor {
    return [UIColor colorWithHex:0x95c660];
}

+ (UIColor *)knThemeLightColor {
    return [UIColor colorWithHex:0x6fa749];
}

+ (UIColor *)knThemeLightBgColor {
    return [UIColor colorWithHex:0xF7FFED];
}

+ (UIColor *)knThemeBlackColor {
    return [UIColor colorWithHex:0x333333];
}

+ (UIColor *)knThemeLightBlackColor {
    return [UIColor colorWithHex:0x666666];
}

+ (UIColor *)knCountArrearageColor {
    return [UIColor colorWithHex:0XFF4400];
}

+ (UIColor *)knFailGrayColor {
    return [UIColor colorWithHex:0Xd9d9d9];
}

@end
