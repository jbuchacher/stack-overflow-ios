//
//  JBStackOverflowAPIOptions.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/13/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JBStackExchangeAPIOptions : NSObject

@property (nonatomic, strong) NSString *siteParameter;

@property (nonatomic, strong) NSString *inTitleQuery;

- (NSDictionary *)queryParameters;

@end