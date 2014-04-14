//
//  SaiphValidatorAlgorithm.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 14/04/14.
//  Copyright (c) 2014, Ronaldo Faria Lima - All Rights Reserved
//

#import "SaiphValidatorAlgorithm.h"

@implementation SaiphValidatorAlgorithm

- (NSString *)normalizeData:(NSString *)data
{
    // Default implementation simply returns the original provided string.
    return data;
}

- (BOOL)validateData:(NSString *)data
{
    // Default implementation simply return YES and considers all data as valid.
    return YES;
}

@end
