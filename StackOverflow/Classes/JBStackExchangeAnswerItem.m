//
//  JBStackExchangeAnswer.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeAnswerItem.h"

NSString * const kStackExchangeQuestionIsAcceptedKey = @"is_accepted";

@interface JBStackExchangeAnswerItem ()

@property (nonatomic, strong) JBStackExchangeItemOwner *answerOwner;
@property (nonatomic, strong) NSString *answerBodyHTML;
@property (nonatomic, assign) BOOL isAcceptedAnswer;

@end

@implementation JBStackExchangeAnswerItem

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary: dictionary])
    {
        _answerBodyHTML = dictionary[kStackExchangeResponseItemBodyKey];
        _answerOwner = [[JBStackExchangeItemOwner alloc] initWithDictionary: dictionary[kStackExchangeResponseItemOwnerKey]];
        _isAcceptedAnswer = [dictionary[kStackExchangeQuestionIsAcceptedKey] boolValue];
    }
    
    return self;
}

@end
