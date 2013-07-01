//
//  SaiphTests.m
//  SaiphTests
//
//  Created by Ronaldo Faria Lima on 30/06/13.
//  Copyright (c) 2013 Saibre Tecnologia da Informação. All rights reserved.
//

#import "SaiphTests.h"
#import "Saiph.h"

#define CHECKSUMMED_VALUE(a, b) (a * 100 + b)
#define VALID_CHECKSUM(a,b) (CHECKSUMMED_VALUE(a, b) % 97 == 1)

@implementation SaiphTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
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

@end
