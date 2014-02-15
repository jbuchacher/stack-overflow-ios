//
//  JBStackExchangeResponseItem.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/13/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponseItem.h"

NSString * const kStackExchangeResponseItemBodyKey = @"body";
NSString * const kStackExchangeResponseItemTitleKey = @"title";
NSString * const kStackExchangeResponseItemAnswersKey = @"answers";

@implementation JBStackExchangeResponseItem

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        
    }
    
    return self;
}

@end
