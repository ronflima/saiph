//
//  SaiphAlgCNJMod97.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 14/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import "SaiphAlgCNJMod97.h"

@implementation SaiphAlgCNJMod97

- (NSString *)normalizeData:(NSString *)data
{
    NSRange checkDigitRange = NSMakeRange(7, 2);
    return [[data stringByReplacingCharactersInRange:checkDigitRange withString:@""] stringByAppendingString:@"00"];
}

- (NSString *)calculateChecksum:(NSString *)data
{
    // Prepared data with check digits stripped off
    NSArray *dataParts = @[
                           [data substringWithRange:NSMakeRange(0, 7)], // Lawsuit number
                           [data substringWithRange:NSMakeRange(7, 7)], // Year/Court part
                           [data substringWithRange:NSMakeRange(14, 6)] // Location part
                           ];
    __block NSString *lastCalculatedCheckDigits = @"";
    [dataParts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *dataPart = [lastCalculatedCheckDigits stringByAppendingString:obj];
        lastCalculatedCheckDigits = [NSString stringWithFormat:@"%ld", dataPart.integerValue % 97];
    }];
    return [NSString stringWithFormat:@"%02ld", 98l - lastCalculatedCheckDigits.integerValue];
}

@end
