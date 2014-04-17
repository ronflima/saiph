//
//  SaiphNormalization.h
//  Saiph
//
//  Created by Ronaldo Faria Lima on 17/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

//! \brief Abstract class for data normalization purposes.
@interface SaiphNormalization : NSObject

//! \property rawData
//! \brief De-normalized data
@property (strong, nonatomic) NSString *rawData;

//! \property normalizedData
//! \brief Normalized data
@property (strong, nonatomic, readonly) NSString *normalizedData;

//! \brief Abstract method for data normalization. Your subclass must override this method
//! in order to have normalizedData property filled correctly.
//! \param rawData: Data to normalize
//! \return Normalized data
- (NSString *)normalizeData:(NSString *)rawData;

//! \brief Initializer. Initializes this class with a proper raw data
//! \param rawData Data to normalize
//! \return A valid instance of this class, if sucessful
//! \return nil on failure.
- (id)initWithRawData:(NSString *)rawData;

@end
