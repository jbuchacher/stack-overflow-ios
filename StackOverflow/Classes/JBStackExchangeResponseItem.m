//
//  JBStackExchangeResponseItem.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/13/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponseItem.h"

NSString * const kStackExchangeResponseItemTitleKey = @"title";
NSString * const kStackExchangeResponseItemOwnerKey = @"owner";
NSString * const kStackExchangeResponseItemBodyKey = @"body";
NSString * const kStackExchangeResponseItemAnswersKey = @"answers";
NSString * const kStackExchangeResponseItemCreationDateKey = @"creation_date";

@interface JBStackExchangeResponseItem ()

@end

@implementation JBStackExchangeResponseItem

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        
    }
    
    return self;
}

@end
