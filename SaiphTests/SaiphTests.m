//
//  SaiphTests.m
//  SaiphTests
//
//  Created by Ronaldo Faria Lima on 30/06/13.
//  Copyright (c) 2014, Ronaldo Faria Lima - All Rights Reserved
//

#import "SaiphTests.h"
#import "Saiph.h"

#define CNJ_LENGTH 20
#define CHECKSUMMED_VALUE(a, b) (a * 100 + b)
#define VALID_CHECKSUM(a,b) (CHECKSUMMED_VALUE(a, b) % 97 == 1)

@implementation SaiphTests
{
    NSArray *CNJCheckData;
}

- (void)setUp
{
    [super setUp];
    CNJCheckData = @[
                     @"0052870-08.2013.8.26.0506",
                     @"1498-59.2009.8.26.0506",
                     @"7721,862013.8.26.0506",
                     @"00110634720098260506",
                     @"934622-03.2012.8.26.0506",
                     @"0944986-34.2012.8.26.0506",
                     @"0144460-67.2006.8.26.0100",
                     @"0000609-49.2006.8.26.0397",
                     @"0028098-36.2000.8.26--0053",
                     @"0047ASDF.-llkd3584420asdfddad1382dddasdfx605[]ppooiuiuyr06"
                     ];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testMod97
{
    NSString *data = @"794";
    SaiphChecksummer *checksummer = [[SaiphChecksummer alloc] initWithData:data andAlgorithm:kSaiphAlgorithmMod97];
    NSString *checksum = checksummer.checksum;
    NSAssert(VALID_CHECKSUM(data.intValue, checksum.intValue), @"Failed to calculate checksum");
}

- (void)testMod97Factory
{
    NSString *data = @"794";
    SaiphChecksummer *checksummer = [SaiphChecksummer checkSummerWithData:data andAlgorithm:kSaiphAlgorithmMod97];
    NSString *checksum = checksummer.checksum;
    NSAssert(VALID_CHECKSUM(data.intValue, checksum.intValue), @"Failed to calculate checksum");
}

- (void)testValidator
{
    SaiphValidator *validator = [SaiphValidator validatorForAlgorithm:kSaiphValidationCNJ];
    [CNJCheckData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog (@"Checking for %@", obj);
        [validator setStringData:obj];
        BOOL isValid = [validator validate];
        XCTAssert(isValid, @"Validation failed for data %@", obj);
    }];
}

- (void)testNormalizer
{
    SaiphNormalizer *normalizer = [[SaiphNormalizer alloc] initWithNormalizationMethod:kSaiphNormalizationCNJ];
    [CNJCheckData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *normalizedData = [normalizer normalizeData:obj];
        NSLog (@"Checking normalization for %@: %@", obj, normalizedData);
        XCTAssert(normalizedData.length == CNJ_LENGTH, @"Normalization failed for data %@", obj);
    }];
}

@end
