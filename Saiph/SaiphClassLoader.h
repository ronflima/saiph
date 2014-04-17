//
//  SaiphClassLoader.h
//  Saiph
//
//  Created by Ronaldo Faria Lima on 17/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

//! \brief Class loader for dynamic class loading support.
@interface SaiphClassLoader : NSObject

//! \brief Load a class dynamically, for a given specified type.
//! \param className Class name to load
//! \return An allocated instance of className
//! \throws ObjectNotAvailable exception
//! \remarks This method only instantiates the class, not initializing it. It is your responsibility to
//! check if the class is of the expected type and initialize it properly.
+ (id)loadClass:(NSString *)className;

@end
