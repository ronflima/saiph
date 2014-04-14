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
    NSRange checkDigitRange = NSMakeRange(7, 2);
    NSString *checkDigits = [data substringWithRange:checkDigitRange];
    // Prepared data with check digits stripped off
    NSString *preparedData = [data stringByReplacingCharactersInRange:checkDigitRange withString:@""];
    NSArray *dataParts = @[
                           [preparedData substringWithRange:NSMakeRange(0, 6)], // Lawsuit number
                           [preparedData substringWithRange:NSMakeRange(7, 7)], //
                           [preparedData substringWithRange:NSMakeRange(13, 4)] // Last part
                           ];
    SaiphChecksummer *checksummer = [SaiphChecksummer checksummerWithAlgorithm:kSaiphAlgorithmMod97];
    __block NSString *lastCalculatedCheckDigits = nil;
    [dataParts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *data = obj;
        [checksummer setData:[lastCalculatedCheckDigits stringByAppendingString:data]];
        lastCalculatedCheckDigits = checksummer.checksum;
    }];
    lastCalculatedCheckDigits = [NSString stringWithFormat:@"%02ld", 98l - lastCalculatedCheckDigits.integerValue];
    return [checkDigits isEqualToString:lastCalculatedCheckDigits];
}

@end
