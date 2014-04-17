//
//  SaiphClassLoader.m
//  Saiph
//
//  Created by Ronaldo Faria Lima on 17/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//
#import <objc/runtime.h>
#import "SaiphClassLoader.h"

@implementation SaiphClassLoader

+ (id)loadClass:(NSString *)className
{
    Class classDefinition = objc_lookUpClass([className cStringUsingEncoding:NSUTF8StringEncoding]);
    if (classDefinition == nil) {
        @throw [NSException exceptionWithName:@"ObjectNotAvailable" reason:@"Could not load required algorithm" userInfo:nil];
    }
    return [classDefinition alloc];
}

@end
