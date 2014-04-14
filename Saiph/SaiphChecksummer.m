//
//  SaiphChecksummer.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 30/06/13.
//  Copyright (c) 2014, Ronaldo Faria Lima - All Rights Reserved
//

#import <objc/runtime.h>
#import "SaiphChecksummer.h"
#import "SaiphAlgorithm.h"

@interface SaiphChecksummer ()

@property (strong, nonatomic) NSString *data;
@property (strong, nonatomic, readonly) SaiphAlgorithm *algorithm;
@property (strong, nonatomic) NSString *cachedChecksum;

@end

@implementation SaiphChecksummer

@synthesize algorithm = _algorithm;

#pragma mark - Class Methods

+ (id)checkSummerWithData:(NSString *)data andAlgorithm:(NSString *)algorithmName
{
    return [[self alloc] initWithData:data andAlgorithm:algorithmName];
}

+ (id)checksummerWithAlgorithm:(NSString *)algorithmName
{
    return [[self alloc] initWithAlgorithm:algorithmName];
}

#pragma mark - Public Methods

- (id)initWithData:(NSString *)data andAlgorithm:(NSString *)algorithmName
{
    NSAssert (data != nil && data.length > 0, @"Invalid data provided");
    NSAssert (algorithmName != nil && algorithmName.length > 0, @"Invalid algorithm name provided");
    self = [super init];
    if (self != nil) {
        self.data = data;
        _algorithmName = [algorithmName copy];
    }
    return self;
}

- (id)initWithAlgorithm:(NSString *)algorithmName
{
    if ((self = [super init])) {
        _algorithmName = [algorithmName copy];
    }
    return self;
}

- (NSString *)checksum
{
    if (! self.data) {
        return nil;
    }
    NSString *normalizedData = [self.algorithm normalizeData:self.data];
    if (self.cachedChecksum == nil) {
        // OPTIMIZATION NOTICE:
        // Caches the checksum in order to avoid repetitive calculations if
        // someone access the property several times.
        self.cachedChecksum = [self.algorithm calculateChecksum:normalizedData];
    }
    return self.cachedChecksum;
}

#pragma mark - Setters and Getters

- (void)setData:(NSString *)data
{
    // Resets the cached checksum, so we can calculate it again against the new data
    _cachedChecksum = nil;
    _data = [data copy];
}

#pragma mark - Private Methods

- (SaiphAlgorithm *)algorithm
{
    if (! _algorithm) {
        // Loads the algorithm class dynamically and lazily in order to ensure full
        // transparency and low coupling
        Class classDefinition = objc_lookUpClass([self.algorithmName cStringUsingEncoding:NSUTF8StringEncoding]);
        if (classDefinition == nil) {
            @throw [NSException exceptionWithName:@"ObjectNotAvailable" reason:@"Could not load required algorithm" userInfo:nil];
        }
        if (! [classDefinition isSubclassOfClass:[SaiphAlgorithm class]]) {
            @throw [NSException exceptionWithName:@"ObjectNotAvailable" reason:@"Algorithm not of the proper type." userInfo:nil];
        }
        _algorithm = [[classDefinition alloc] init];
    }
    return _algorithm;
}

@end
