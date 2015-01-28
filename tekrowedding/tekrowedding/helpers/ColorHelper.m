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

@end
