//
//  JBStackOverflowAPIOptions.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/13/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kStackExchangeRequestOptionSiteKey;

extern NSString * const kStackExchangeRequestOptionAccessTokenKey;
extern NSString * const kStackExchangeRequestOptionAccessKeyKey;

@interface JBStackExchangeAPIOptions : NSObject

@property (nonatomic, strong) NSString *siteParameter;
@property (nonatomic, strong, readonly) NSString *apiKey;
@property (nonatomic, strong) NSString *accessToken;

@end