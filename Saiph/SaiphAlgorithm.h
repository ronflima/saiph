//
//  SaiphAlgorithm.h
//  Saiph
//
//  Created by Ronaldo Faria Lima on 30/06/13.
//  Copyright (c) 2014, Ronaldo Faria Lima - All Rights Reserved
//

#import <Foundation/Foundation.h>

//! \ingroup SAIPH
//! \internal
//! \brief Abstract class for algorithm implementations.
//! \remarks This class implements a workflow for every algorithm within
//! this class. The workflow contains two steps: a data normalization
//! and the checksum calculation. Data is not retained inside the class in order
//! to spare resources. All state control over the data is done on a higher
//! level which is responsible to carry on the calculations. All algorithms are
//! based on strings. That's why the interfaces are using solely NSStrings

@interface SaiphAlgorithm : NSObject

//! \brief Normalizes provided data to a format that is proper for checksum
//! calculations
//! \param data Data to be normalized
//! \return The normalized data
//! \remarks The default implementation returns the provided argument without
//! any transformation.

- (NSString *)normalizeData:(NSString *)data;

//! \brief Calculates the checksum over a piece of normalized data
//! \param data Data to calculate the checksum over it
//! \return The calculated checksum
//! \remarks The default implementation of this method returns a nil pointer

- (NSString *)calculateChecksum:(NSString *)data;

@end
