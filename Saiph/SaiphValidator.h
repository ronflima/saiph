//
//  SaiphValidator.h
//  Saiph
//
//  Created by Ronaldo Faria Lima on 11/04/14.
//  Copyright (c) 2014, Ronaldo Faria Lima - All Rights Reserved
//

#import <Foundation/Foundation.h>

//! \ingroup SAIPH
//! \defgroup SAIPH_VALIDATOR Validation Algorithms
//! \{
//! \class SaiphValidator
//! \brief Validates a piece of information against a given algorithm and information type.
@interface SaiphValidator : NSObject

//! \property dataIsValid
//! \brief Checks if given data is valid against the provided algorithm
//! \return YES if data is valid
//! \return NO if data failed to validate against or data is invalid
@property (assign, nonatomic, readonly) BOOL dataIsValid;

//! \property algorithm
//! \brief Algorithm to which the validation will occur
@property (strong, nonatomic, readonly) NSString *algorithm;

//! \property stringData
//! \brief String data that will be used for validation
@property (strong, nonatomic, readonly) NSString *stringData;

//! \brief Setter for string data
//! \param stringData New string data
- (void)setStringData:(NSString *)stringData;

//! \brief Initializes this class for a given set of string data and for a given algorithm
//! \param stringData String data to validate
//! \param algorithm Algorithm to use for validation
//! \return A valid instance of SaiphValidator on success
//! \return nil if class could not be initialized
//! \see SAIPH_CONST
- (id)initWithData:(NSString *)stringData forAlgorithm:(NSString *)algorithm;

//! \brief Initializes this class for a given algorithm
//! \param algorithm Algorithm to use for validations
//! \return A valid instance of SaiphValidator on success
//! \return nil if class could not be initialized
//! \see SAIPH_CONST
- (id)initWithAlgorithm:(NSString *)algorithm;

//! \brief Validates data by using the provided algorithm
//! \return YES if provided data is valid
//! \return NO if provided data failed to validate or provided data is invalid
- (BOOL)validate;

//! \brief Factory for a generic validator
//! \param algorithm Algorithm to use for validation
//! \return A valid instance of SaiphValidator on success
//! \return nil if class could not be initialized
//! \see SAIPH_CONST
+ (id)validatorForAlgorithm:(NSString *)algorithm;

//! \brief Factory for a generic validator
//! \param algorithm Algorithm to use for validation
//! \param stringData String data to validate
//! \return A valid instance of SaiphValidator on success
//! \return nil if class could not be initialized
//! \see SAIPH_CONST
+ (id)validatorForAlgorithm:(NSString *)algorithm andStringData:(NSString *)stringData;
@end

//! \}