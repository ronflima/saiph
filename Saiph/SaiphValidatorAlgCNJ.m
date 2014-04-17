//
//  SaiphVldCNJ.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 14/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import "SaiphValidatorAlgCNJ.h"
#import "SaiphConstants.h"
#import "SaiphNormalizer.h"

@interface SaiphValidatorAlgCNJ ()

- (NSString *)checkDigitsForData:(NSString *)data;

@end

@implementation SaiphValidatorAlgCNJ
{
    SaiphNormalizer *normalizer;
}

#pragma mark - Normalization

- (NSString *)normalizeData:(NSString *)data
{
    if (! normalizer) {
        normalizer = [[SaiphNormalizer alloc] initWithNormalizationMethod:kSaiphNormalizationCNJ];
    }
    return [normalizer normalizeData:data];
}

#pragma mark - Validation

- (BOOL)validateData:(NSString *)data
{
    NSArray *dataParts = @[
                           [data substringWithRange:NSMakeRange( 0, 7)], // Lawsuit number
                           [data substringWithRange:NSMakeRange( 7, 7)], // Year/Court part
                           [data substringWithRange:NSMakeRange(14, 6)]  // Location part
                           ];
    __block NSString *lastCalculatedCheckDigits = @"";
    [dataParts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *dataPart = [lastCalculatedCheckDigits stringByAppendingString:obj];
        lastCalculatedCheckDigits = [NSString stringWithFormat:@"%ld", (long)dataPart.integerValue % 97];
    }];
    return (lastCalculatedCheckDigits.integerValue % 97) == 1;
}

- (NSString *)checkDigitsForData:(NSString *)data
{
    NSRange checkDigitRange = NSMakeRange(7, 2);
    return [data substringWithRange:checkDigitRange];
}

@end
