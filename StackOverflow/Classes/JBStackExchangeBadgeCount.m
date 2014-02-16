//
//  JBStackExchangeBadgeCount.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeBadgeCount.h"

NSString * const kStackExchangeResponseBadgesGoldBadgesKey = @"gold";
NSString * const kStackExchangeResponseBadgesSilverBadgesKey = @"silver";
NSString * const kStackExchangeResponseBadgesBronzeBadgesKey = @"bronze";

@interface JBStackExchangeBadgeCount ()

@property (nonatomic, assign) NSInteger goldBadges;
@property (nonatomic, assign) NSInteger silverBadges;
@property (nonatomic, assign) NSInteger bronzeBadges;

@end

@implementation JBStackExchangeBadgeCount

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary: dictionary])
    {
        _goldBadges = [dictionary[kStackExchangeResponseBadgesGoldBadgesKey] integerValue];
        _silverBadges = [dictionary[kStackExchangeResponseBadgesSilverBadgesKey] integerValue];
        _bronzeBadges = [dictionary[kStackExchangeResponseBadgesBronzeBadgesKey] integerValue];
    }
    
    return self;
}

@end