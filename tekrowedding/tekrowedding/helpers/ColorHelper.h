//
//  ColorHelper.h
//  tekrowedding
//
//  Created by Pau Moreno on 28/1/15.
//  Copyright (c) 2015 Rocio Tovar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define THEME_COLOR     [ColorHelper getColorFromHex:@"#F9EEDB"]
#define THEME_PINK      [ColorHelper getColorFromHex:@"#B35B56"]
#define THEME_PURPLE    [ColorHelper getColorFromHex:@"#5C4D74"]

@interface ColorHelper : NSObject

+(UIColor*) getColorFromHex: (NSString*) hex;

@end
