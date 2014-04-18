//
//  SaiphNormalizationCNJ.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 17/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import "SaiphNormalizationCNJ.h"

@implementation SaiphNormalizationCNJ

#define CNJ_LENGTH                  \
  7 /* Serial number */             \
+ 2 /* Check digit */               \
+ 4 /* Year */                      \
+ 1 /* Division or law segment */   \
+ 2 /* Court of justice */          \
+ 4 /* Court unit (comarca) */

#define CNJ_REGEXP @"[0-9]+"

- (NSString *)normalizeData:(NSString *)data
{
    NSMutableString *normalizedData = [[NSMutableString alloc] init];
    
    // First step: strips all non-numeric characters
    NSRange range;
    do {
        range = [data rangeOfString:CNJ_REGEXP options:NSRegularExpressionSearch];
        if (range.length == 0) {
            // Information provided does not contain any number. So, returns to the caller whatever
            // we have received.
            return data;
        }
        [normalizedData appendString:[data substringWithRange:range]];
        NSInteger location = range.location;
        range.location  += range.length;
        range.length    = data.length - (range.length + location);
        data = [data substringWithRange:range];
    } while (range.length > 0);
    
    // Second step: fill the number with zeroes, if applicable
    if (normalizedData.length < CNJ_LENGTH) {
        NSInteger zeroes = CNJ_LENGTH - normalizedData.length;
        NSMutableString *zeroesString = [NSMutableString stringWithCapacity:zeroes];
        do {
            [zeroesString appendString:@"0"];
        } while (--zeroes);
        [normalizedData insertString:zeroesString atIndex:0];
    }
    
    // Third step: extract the check digit and put at the end of the resulting string
    NSRange checkDigitRange = NSMakeRange(7, 2);
    NSString *checkDigits = [normalizedData substringWithRange:checkDigitRange];
    [normalizedData replaceCharactersInRange:checkDigitRange withString:@""];
    [normalizedData appendString:checkDigits];
    
    // Returns a non-mutable instance of normalized data
    return [normalizedData copy];
}

@end
