//
//  SaiphNormalizer.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 17/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import "SaiphNormalizer.h"
#import "SaiphNormalization.h"
#import "SaiphClassLoader.h"

@interface SaiphNormalizer ()

//! \property normalizationAlgorithm
//! \brief Algorithm to use for data normalization;
@property (strong, nonatomic) SaiphNormalization *normalizationAlgorithm;

@end

@implementation SaiphNormalizer

- (id)initWithNormalizationMethod:(NSString *)normalizationMethod
{
    if ((self = [super init])) {
        _normalizationMethod = [normalizationMethod copy];
    }
    return self;
}

- (NSString *)normalizeData:(NSString *)data
{
    [self.normalizationAlgorithm setRawData:data];
    return self.normalizationAlgorithm.normalizedData;
}

#pragma mark - Getters and Setters

- (SaiphNormalization *)normalizationAlgorithm
{
    // Lazily loads the normalization algorithm
    if (! _normalizationAlgorithm) {
        _normalizationAlgorithm = [[SaiphClassLoader loadClass:self.normalizationMethod] init];
        if (! [_normalizationAlgorithm.class isSubclassOfClass:[SaiphNormalization class]]) {
            @throw [NSException exceptionWithName:@"ObjectNotAvailable" reason:@"Normalization method not of the proper type." userInfo:nil];
        }
    }
    return _normalizationAlgorithm;
}

@end
