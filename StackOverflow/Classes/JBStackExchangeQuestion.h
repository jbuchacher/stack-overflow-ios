//
//  JBStackOverflowQuestion.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponseItem.h"

@interface JBStackExchangeQuestion : JBStackExchangeResponseItem

@property (nonatomic, strong, readonly) NSString *questionTitle;
@property (nonatomic, strong, readonly) NSString *questionBodyHTML;

@end