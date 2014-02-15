//
//  JBStackExchangeAnswer.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeAnswer.h"

@implementation JBStackExchangeAnswer

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary: dictionary])
    {
        _answerBodyHTML= dictionary[kStackExchangeResponseItemBodyKey];
    }
    
    return self;
}

@end
