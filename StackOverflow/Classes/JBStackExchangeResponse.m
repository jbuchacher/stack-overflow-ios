//
//  JBStackOverflowModel.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponse.h"

// Items
NSString * const kStackExchangeResponseHasMoreKey = @"has_more";
NSString * const kStackExchangeResponseItemsKey = @"items";

// Errors
NSString * const kStackExchangeResponseErrorIdKey = @"error_id";
NSString * const kStackExchangeResponseErrorMessageKey = @"error_message";
NSString * const kStackExchangeResponseErrorDomain = @"kStackExchangeResponseErrorDomain";

// API Throttling
NSString * const kStackExchangeResponseBackoffKey = @"backoff";
NSString * const kStackExchangeResponseQuotaMaxKey = @"quota_max";
NSString * const kStackExchangeResponseQuotaRemainingKey = @"quota_max";

@interface JBStackExchangeResponse ()

@property (nonatomic, assign) BOOL hasMoreItems;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) BOOL shouldBackoff;
@property (nonatomic, assign) NSDate *nextAllowableRequestDate;
@property (nonatomic, assign) NSInteger quotaMax;
@property (nonatomic, assign) NSInteger quotaRemaining;

@end

@implementation JBStackExchangeResponse

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _hasMoreItems = [dictionary[kStackExchangeResponseHasMoreKey] boolValue];
        
        NSInteger errorCode = [dictionary[kStackExchangeResponseErrorIdKey] integerValue];
        if (errorCode)
        {
            NSString *errorMessage = dictionary[kStackExchangeResponseErrorMessageKey];
            _error = [NSError errorWithDomain: kStackExchangeResponseErrorDomain
                                         code: errorCode
                                     userInfo: @{NSLocalizedDescriptionKey : errorMessage}];
        }
        
        NSNumber *backoffWaitDuration = dictionary[kStackExchangeResponseBackoffKey];
        if ([backoffWaitDuration integerValue] > 0)
        {
            _shouldBackoff = YES;
            _nextAllowableRequestDate = [[NSDate date] dateByAddingTimeInterval: [backoffWaitDuration doubleValue]];
        }
        
        _quotaMax = [dictionary[kStackExchangeResponseQuotaMaxKey] integerValue];
        _quotaRemaining = [dictionary[kStackExchangeResponseQuotaRemainingKey] integerValue];
    }
    
    return self;
}

@end