//
//  ColorHelper.m
//  tekrowedding
//
//  Created by Pau Moreno on 28/1/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "ColorHelper.h"

@implementation ColorHelper

+(UIColor*) getColorFromHex: (NSString*) hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor *)color:(UIColor *)originalColor blendedWithColor:(UIColor *)color withAlpha:(float)alpha
{
    alpha = MIN( 1.0, MAX( 0.0, alpha ) );
    CGFloat beta = 1.0 - alpha;
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [originalColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    CGFloat blendedRed     = r1 * beta + r2 * alpha;
    CGFloat blendedGreen   = g1 * beta + g2 * alpha;
    CGFloat blendedBlue    = b1 * beta + b2 * alpha;
    CGFloat blendedAlpha   = a1 * beta + a2 * alpha;
    return [UIColor colorWithRed:blendedRed green:blendedGreen blue:blendedBlue alpha:blendedAlpha];
}

@end
