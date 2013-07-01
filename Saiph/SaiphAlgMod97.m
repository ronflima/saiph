//
//  SaiphAlgMod97.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 30/06/13.
//  Copyright (c) 2013 Saibre Tecnologia da Informação. All rights reserved.
//

#import "SaiphAlgMod97.h"

#define SPHSEARCH_REGEX @"[^A-Z0-9]"    

@implementation SaiphAlgMod97

- (NSString *)normalizeData:(NSString *)data
{
    NSAssert(data != nil, @"Provided data is nil and, therefore, invalid");
    
    // Appends zeroes at the end of the data and make all
    // non-numeric characters become uppercase as part of normalization
    data = [[data stringByAppendingString:@"00"] uppercaseString];
    
    return data;
}

- (NSString *)calculateChecksum:(NSString *)data
{
    // Calculates the ISO 7064 checksum (mod 97 calculation)
    unsigned checksum = 98 - (data.longLongValue % 97);
    data = [NSString stringWithFormat:@"%d", checksum];
    return data;
}

@end
