//
//  JBStackExchangeTestHelper.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/16/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeTestHelper.h"

@implementation JBStackExchangeTestHelper

+ (NSDictionary *)jsonDictionaryFromFilename:(NSString *)filename
{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource: [filename stringByDeletingPathExtension]
                                                                          ofType: [filename pathExtension]];
    
    NSData* data = [NSData dataWithContentsOfFile: filePath];
    NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData: data
                                                options: 0
                                                  error: &error];
    if (error)
    {
        // handle error...
        return nil;
    }

    return result;
}

@end