//
//  JBStackExchangeSearchQuery.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuery.h"
#import "JBStackExchangeSiteItem.h"

extern NSString * const kStackExchangeRequestOptionInTitleQueryKey;
extern NSString * const kStackExchangeRequestOptionFilterKey;

@interface JBStackExchangeSearchQuery : JBStackExchangeQuery

@property (nonatomic, strong) JBStackExchangeSiteItem *stackExchangeSite;
@property (nonatomic, strong) NSString *inTitleQuery;
@property (nonatomic, strong) NSString *filter;
@property (nonatomic, strong) NSString *sortKey;
@property (nonatomic, assign) NSInteger pageNumber;

@end