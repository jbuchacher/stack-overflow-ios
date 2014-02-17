//
//  JBStackExchangeAnswer.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeAnswerItem.h"

@interface JBStackExchangeAnswerItem ()

@property (nonatomic, strong) JBStackExchangeItemOwner *answerOwner;
@property (nonatomic, strong) NSString *answerBodyHTML;

@end

@implementation JBStackExchangeAnswerItem

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary: dictionary])
    {
        _answerBodyHTML = dictionary[kStackExchangeResponseItemBodyKey];
        _answerOwner = [[JBStackExchangeItemOwner alloc] initWithDictionary: dictionary[kStackExchangeResponseItemOwnerKey]];
    }
    
    return self;
}

@end
