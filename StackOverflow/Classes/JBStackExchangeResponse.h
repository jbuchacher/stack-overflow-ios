//
//  JBStackOverflowModel.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JBStackExchangeResponse : NSObject

/// By default, this is an array of JSON dictionaries. Items will be parsed (and mutated) before a successful response is received.
/// See JBStackOverflowAPIManager's 'JBStackExchangeResponseParseBlock for more information.
@property (nonatomic, strong) NSArray *items;

/// If YES, indicates there are more items available than included with this response.
@property (nonatomic, assign, readonly) BOOL hasMoreItems;

/// If not nil, -error represents a StackExchange API Error (https://api.stackexchange.com/docs/types/error)
@property (nonatomic, strong, readonly) NSError *error;

/// If YES, a delay is required before making similar requests (see https://api.stackexchange.com/docs/wrapper)
@property (nonatomic, assign, readonly) BOOL shouldBackoff;

/// If -shouldBackoff is YES, -nextAllowableRequestDate is the soonest you should make a similar request.
@property (nonatomic, assign, readonly) NSDate *nextAllowableRequestDate;

/// Maximum daily quota (see https://api.stackexchange.com/docs/throttle)
@property (nonatomic, assign, readonly) NSInteger quotaMax;

/// Daily quota remaining
@property (nonatomic, assign, readonly) NSInteger quotaRemaining;

// Designated Initializer
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end