//
//  SaiphNormalization.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 17/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import "SaiphNormalization.h"

@implementation SaiphNormalization

- (id)initWithRawData:(NSString *)rawData
{
    if ((self = [super init])) {
        self.rawData = rawData;
    }
    return self;
}

- (NSString *)normalizedData
{
    return [self normalizeData: self.rawData];
}

#pragma mark - Private Methods

- (NSString *)normalizeData:(NSString *)rawData
{
    // The default implementation does nothing.
    return rawData;
}
@end
