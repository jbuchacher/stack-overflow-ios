//
//  JBStackExchangeAnswer.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeAnswerItem.h"
#import "NSAttributedString+JBStackExchangeExtensions.h"

@interface JBStackExchangeAnswerItem ()

@property (nonatomic, strong) JBStackExchangeItemOwner *answerOwner;
@property (nonatomic, strong) NSAttributedString *answerBody;

@end

@implementation JBStackExchangeAnswerItem

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary: dictionary])
    {
        _answerBody = [NSAttributedString attributedStringFromHTML: dictionary[kStackExchangeResponseItemBodyKey]];
        _answerOwner = [[JBStackExchangeItemOwner alloc] initWithDictionary: dictionary[kStackExchangeResponseItemOwnerKey]];
    }
    
    return self;
}

@end
