//
//  SaiphNormalizer.h
//  Saiph
//
//  Created by Ronaldo Faria Lima on 17/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

//! \brief Class for data normalization
//! This class works as an adapter between your code and inner normalization algorithms.
@interface SaiphNormalizer : NSObject

//! \property normalizationMethod
//! \brief Method currently configured for normalization
@property (strong, nonatomic, readonly) NSString *normalizationMethod;

//! \brief Normalizes input data.
//! \param data Data to normalize
//! \return Normalized data on success
//! \remarks This method does not validate the provided data. It considers that your provided data is of whatever
//! type that conforms to normalization rules within this class. This is a design decision in order to make this
//! implementation plain simple.
- (NSString *)normalizeData:(NSString *)data;

//! \brief Initializes for a given normalization method
//! \param normalizationMethod The normalization method to use.
//! \return A valid initialized instance of this class on success
//! \return nil on failure
//! \remarks The normalization method is one of the provided constants in SaiphConstants.h header file.
- (id)initWithNormalizationMethod:(NSString *)normalizationMethod;

@end
