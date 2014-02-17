//
//  JBStackExchangeAnswer.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponseItem.h"
#import "JBStackExchangeItemOwner.h"

@interface JBStackExchangeAnswerItem : JBStackExchangeResponseItem

@property (nonatomic, strong, readonly) JBStackExchangeItemOwner *answerOwner;
@property (nonatomic, strong, readonly) NSAttributedString *answerBody;

@end