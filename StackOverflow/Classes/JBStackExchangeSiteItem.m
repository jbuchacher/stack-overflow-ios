//
//  JBStackExchangeSiteItem.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeSiteItem.h"

NSString * const kStackExchangeResponseSiteNameKey = @"name";
NSString * const kStackExchangeResponseSiteLogoURLKey = @"logo_url";
NSString * const kStackExchangeResponseSiteAPIParameterKey = @"api_site_parameter";

@interface JBStackExchangeSiteItem ()

@property (nonatomic, strong) NSString *siteName;
@property (nonatomic, strong) NSString *siteLogoURL;
@property (nonatomic, strong) NSString *siteAPIParameter;

@end

@implementation JBStackExchangeSiteItem

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary: dictionary])
    {
        _siteName = dictionary[kStackExchangeResponseSiteNameKey];
        _siteLogoURL = dictionary[kStackExchangeResponseSiteLogoURLKey];
        _siteAPIParameter = dictionary[kStackExchangeResponseSiteAPIParameterKey];
    }
    
    return self;
}

@end