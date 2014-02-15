//
//  JBStackExchangeResponseItem.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/13/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kStackExchangeResponseItemBodyKey;
extern NSString * const kStackExchangeResponseItemTitleKey;
extern NSString * const kStackExchangeResponseItemAnswersKey;

@interface JBStackExchangeResponseItem : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
