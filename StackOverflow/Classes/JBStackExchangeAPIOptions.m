//
//  JBStackOverflowAPIOptions.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/13/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeAPIOptions.h"

NSString * const kStackExchangeRequestOptionSiteKey = @"site";
NSString * const kStackExchangeRequestOptionInTitleQueryKey = @"intitle";

@implementation JBStackExchangeAPIOptions

- (NSDictionary *)queryParameters
{
    NSMutableDictionary *queryParameters = [[NSMutableDictionary alloc] init];
    
    if (self.siteParameter)
    {
        queryParameters[kStackExchangeRequestOptionSiteKey] = self.siteParameter;
    }
    
    if (self.inTitleQuery)
    {
        queryParameters[kStackExchangeRequestOptionInTitleQueryKey] = self.inTitleQuery;
    }
    
    return queryParameters;
}

@end