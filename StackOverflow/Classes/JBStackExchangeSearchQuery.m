//
//  JBStackExchangeSearchQuery.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeSearchQuery.h"

NSString * const kStackExchangeRequestOptionInTitleQueryKey = @"intitle";
NSString * const kStackExchangeRequestOptionFilterKey = @"filter";
NSString * const kStackExchangeRequestOptionSortKey = @"sort";
NSString * const kStackExchangeRequestOptionPageKey = @"page";

@implementation JBStackExchangeSearchQuery

- (NSDictionary *)queryParameters
{
    NSMutableDictionary *queryParameters = [[NSMutableDictionary alloc] init];

    if (self.inTitleQuery)
    {
        queryParameters[kStackExchangeRequestOptionInTitleQueryKey] = self.inTitleQuery;
    }
    if (self.filter)
    {
        queryParameters[kStackExchangeRequestOptionFilterKey] = self.filter;
    }
    
    if (self.pageNumber)
    {
        queryParameters[kStackExchangeRequestOptionPageKey] = [NSNumber numberWithInteger: self.pageNumber];
    }
    
    if (self.stackExchangeSite && self.stackExchangeSite.siteAPIParameter)
    {
        queryParameters[kStackExchangeRequestOptionSiteKey] = self.stackExchangeSite.siteAPIParameter;
    }
    
    if (self.sortKey)
    {
        queryParameters[kStackExchangeRequestOptionSortKey];
    }
    
    return queryParameters;
}

- (void)setInTitleQuery:(NSString *)inTitleQuery
{
    _inTitleQuery = inTitleQuery;
}

@end