//
//  UIColor+Hex.h
//  AirBrush
//
//  Created by albus on 2017/9/25.
//  Copyright © 2017年 Hippo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
