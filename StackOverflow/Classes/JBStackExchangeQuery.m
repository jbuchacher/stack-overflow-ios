//
//  JBStackExchangeQuery.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuery.h"

@implementation JBStackExchangeQuery

- (NSDictionary *)queryParameters
{
    NSLog(@"Subclasses must override this method.");
    return nil;
}

@end