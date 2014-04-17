//
//  SaiphValidator.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 11/04/14.
//  Copyright (c) 2014, Ronaldo Faria Lima - All Rights Reserved
//

#import "SaiphValidator.h"
#import "SaiphValidatorAlgorithm.h"
#import "SaiphClassLoader.h"

@interface SaiphValidator ()

@property (strong, nonatomic, readonly) SaiphValidatorAlgorithm *validatorAlgorithm;

@end

@implementation SaiphValidator

@synthesize validatorAlgorithm = _validatorAlgorithm;

#pragma mark - Class Methods

+ (id)validatorForAlgorithm:(NSString *)algorithm
{
    return [[self alloc] initWithAlgorithm:algorithm];
}

+ (id)validatorForAlgorithm:(NSString *)algorithm andStringData:(NSString *)stringData
{
    return [[self alloc] initWithData:stringData forAlgorithm:algorithm];
}

#pragma mark - Public Methods

- (id)initWithData:(NSString *)stringData forAlgorithm:(NSString *)algorithm
{
    if ((self = [super init])) {
        _algorithm  = [algorithm    copy];
        _stringData = [stringData   copy];
    }
    return self;
}

- (id)initWithAlgorithm:(NSString *)algorithm
{
    if ((self = [super init])) {
        [_algorithm = algorithm copy];
    }
    return self;
}

- (BOOL)validate
{
    return self.dataIsValid;
}

#pragma mark - Getters and Setters

- (BOOL)dataIsValid
{
    if (! self.stringData) {
        // If no string data is provided, validator always responds as invalid
        return NO;
    }
    NSString *normalizedData = [self.validatorAlgorithm normalizeData:self.stringData];
    return [self.validatorAlgorithm validateData:normalizedData];
}

- (void)setStringData:(NSString *)stringData
{
    _stringData = [stringData copy];
}

#pragma mark - Private Methods

- (SaiphValidatorAlgorithm *)validatorAlgorithm
{
    if (! _validatorAlgorithm) {
        // Loads the algorithm class dynamically in order to ensure full
        // transparency and low coupling. Do a lazy load.
        _validatorAlgorithm = [[SaiphClassLoader loadClass:self.algorithm] init];
        if (! [_validatorAlgorithm.class isSubclassOfClass:[SaiphValidatorAlgorithm class]]) {
            @throw [NSException exceptionWithName:@"ObjectNotAvailable" reason:@"Validator not of the proper type." userInfo:nil];
        }
    }
    return _validatorAlgorithm;
}

@end
