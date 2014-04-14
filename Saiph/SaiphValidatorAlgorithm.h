//
//  SaiphValidatorAlgorithm.h
//  Saiph
//
//  Created by Ronaldo Faria Lima on 14/04/14.
//  Copyright (c) 2014, Ronaldo Faria Lima - All Rights Reserved
//

#import <Foundation/Foundation.h>

//! \ingroup SAIPH_VALIDATOR
//! \{

//! \class SaiphValidatorAlgorithm
//! \brief Abstract class for general validation algorithms. This class is very similar to
//! SaiphAlgorithm, functionally speaking.
//! \see SaiphAlgorithm
//! \paragraph Design notes
//! For the sake of simplicity, this class does not retain the normalized data nor the data to be validated. It is done
//! elsewhere. So, it creates a lightweight class with a smaller memory footprint.

@interface SaiphValidatorAlgorithm : NSObject

//! \brief Normalizes input data in order to be validated later. Validation is a two-step process where data is first
//! normalized and later validated.
//! \param data Data to be normalized
//! \return The normalized data.
- (NSString *)normalizeData: (NSString *)data;

//! \brief Validates provided data by using a specific algorithm.
//! \param data Data to be validated
//! \return YES if provided data is valid
//! \return NO if provided data does not match required validation rules imposed by validation algorithm.
- (BOOL)validateData: (NSString *)data;

@end

//! \}