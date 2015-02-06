//
//  InterfaceHelper.m
//  tekrowedding
//
//  Created by Rocio Tovar on 6/2/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import "InterfaceHelper.h"

@implementation InterfaceHelper

+ (UIImage *)getImageWithName:(NSString *)imageName andTintColor:(UIColor *)color
{
    UIImage *result = nil;

    if (imageName && color) {
        UIImage *image = [UIImage imageNamed:imageName];

        if (image) {
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
            CGContextRef c = UIGraphicsGetCurrentContext();

            if (c) {
                [image drawInRect:rect];
                CGContextSetFillColorWithColor(c, [color CGColor]);
                CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
                CGContextFillRect(c, rect);
                result = UIGraphicsGetImageFromCurrentImageContext();
            } else {
                NSLog(@"No context?");
            }
            UIGraphicsEndImageContext();
        }
    }

    return result;
}

@end
