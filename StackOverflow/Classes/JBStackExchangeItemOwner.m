//
//  JBStackExchangeItemOwner.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeItemOwner.h"

NSString * const kStackExchangeResponseOwnerDisplayNameKey = @"display_name";

@interface JBStackExchangeItemOwner ()

@property (nonatomic, strong) NSString *ownerName;

@end

@implementation JBStackExchangeItemOwner

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary: dictionary])
    {
        _ownerName = dictionary[kStackExchangeResponseOwnerDisplayNameKey];
    }
    
    return self;
}

@end