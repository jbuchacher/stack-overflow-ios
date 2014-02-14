//
//  JBStackExchangeSiteItem.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponseItem.h"

@interface JBStackExchangeSiteItem : JBStackExchangeResponseItem

@property (nonatomic, strong, readonly) NSString *siteName;
@property (nonatomic, strong, readonly) NSString *siteLogoURL;
@property (nonatomic, strong, readonly) NSString *siteAPIParameter;

@end