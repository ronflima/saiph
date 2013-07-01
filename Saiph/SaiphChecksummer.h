//
//  SaiphChecksummer.h
//  Saiph
//
//  Created by Ronaldo Faria Lima on 30/06/13.
//  Copyright (c) 2013 Saibre Tecnologia da Informação. All rights reserved.
//

#import <Foundation/Foundation.h>

//! \ingroup SAIPH
//! \brief Main interface of the library. Calculates a checksum for a given
//! piece of data.

@interface SaiphChecksummer : NSObject

//! \property checksum
//! \brief Calculates the checksum, based on selected algorithm
//! \return The calculated checksum number on success
//! \return nil if checksum could not be calculated at all
@property (strong, readonly, nonatomic) NSString *checksum;

//! \brief Initializes a new instance of a SaiphChecksummer class
//! \param data Data to user for checksum calculations
//! \param algorithmName Name of the algorithm
//! \return A fully initialized instance of SaiphChecksummer class
//! \remarks The algorithmName must be one of the constants kSaiphAlgorithm.
//! Using a string that is not one of those constants will lead initialization
//! to fail with an exception
- (id)initWithData:(NSString *)data andAlgorithm:(NSString *)algorithmName;

//! \brief Factory for a SaiphChecksummer class
//! \param data Data to user for checksum calculations
//! \param algorithmName Name of the algorithm
//! \return A fully initialized instance of SaiphChecksummer class
//! \see initWithData for information about algorithmName
+ (id)checkSummerWithData:(NSString *)data andAlgorithm:(NSString *)algorithmName;

@end
