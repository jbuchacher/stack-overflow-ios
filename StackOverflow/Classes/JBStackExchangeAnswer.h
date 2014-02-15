//
//  JBStackExchangeAnswer.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponseItem.h"

@interface JBStackExchangeAnswer : JBStackExchangeResponseItem

@property (nonatomic, strong, readonly) NSString *answerBodyHTML;

@end