//
//  SaiphVldCNJ.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 14/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import "SaiphVldCNJ.h"
#import "SaiphChecksummer.h"
#import "SaiphConstants.h"

@interface SaiphVldCNJ ()

- (NSString *)checkDigitsForData:(NSString *)data;

@end

@implementation SaiphVldCNJ

#pragma mark - Normalization

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
    // Returns a non-mutable instance of normalized data
    return [normalizedData copy];
}

#pragma mark - Validation

- (BOOL)validateData:(NSString *)data
{
    SaiphChecksummer *checksummer = [SaiphChecksummer checkSummerWithData:data andAlgorithm:kSaiphAlgorithmCNJMod97];
    NSString *checkDigits = [self checkDigitsForData:data];
    return [checkDigits isEqualToString:checksummer.checksum];
}

- (NSString *)checkDigitsForData:(NSString *)data
{
    NSRange checkDigitRange = NSMakeRange(7, 2);
    return [data substringWithRange:checkDigitRange];
}

@end
