//
//  SaiphChecksummer.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 30/06/13.
//  Copyright (c) 2013 Saibre Tecnologia da Informação. All rights reserved.
//

#import <objc/runtime.h>
#import "SaiphChecksummer.h"
#import "SaiphAlgorithm.h"

@interface SaiphChecksummer ()

@property (strong, nonatomic) NSString *data;
@property (strong, nonatomic) SaiphAlgorithm *algorithm;
@property (strong, nonatomic) NSString *cachedChecksum;

@end

@implementation SaiphChecksummer

#pragma mark - Public Methods

- (id)initWithData:(NSString *)data andAlgorithm:(NSString *)algorithmName
{
    NSAssert (data != nil && data.length > 0, @"Invalid data provided");
    NSAssert (algorithmName != nil && algorithmName.length > 0, @"Invalid algorithm name provided");
    self = [super init];
    if (self != nil) {
        self.data = data;
        
        // Loads the algorithm class dynamically in order to ensure full
        // transparency and low coupling
        Class classDefinition = objc_lookUpClass([algorithmName cStringUsingEncoding:NSUTF8StringEncoding]);
        if (classDefinition == nil) {
            @throw [NSException exceptionWithName:@"ObjectNotAvailable" reason:@"Could not load required algorithm" userInfo:nil];
        }
        if (! [classDefinition isSubclassOfClass:[SaiphAlgorithm class]]) {
            @throw [NSException exceptionWithName:@"ObjectNotAvailable" reason:@"Algorithm not of the proper type." userInfo:nil];
        }
        self.algorithm = [[classDefinition alloc] init];
    }
    return self;
}

+ (id)checkSummerWithData:(NSString *)data andAlgorithm:(NSString *)algorithmName
{
    return [[self alloc] initWithData:data andAlgorithm:algorithmName];
}

- (NSString *)checksum
{
    NSString *normalizedData = [self.algorithm normalizeData:self.data];
    if (self.cachedChecksum == nil) {
        // OPTIMIZATION NOTICE:
        // Caches the checksum in order to avoid repetitive calculations if
        // someone access the property several times.
        self.cachedChecksum = [self.algorithm calculateChecksum:normalizedData];
    }
    return self.cachedChecksum;
}

@end
