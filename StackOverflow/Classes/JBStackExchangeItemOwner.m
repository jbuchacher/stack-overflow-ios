//
//  JBStackExchangeItemOwner.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeItemOwner.h"

NSString * const kStackExchangeResponseOwnerDisplayNameKey = @"display_name";
NSString * const kStackExchangeResponseOwnerReputationKey = @"reputation";
NSString * const kStackExchangeResponseItemBadgeCountsKey = @"badge_counts";
NSString * const kStackExchangeResponseOwnerAvatarImageKey = @"profile_image";

@interface JBStackExchangeItemOwner ()

@property (nonatomic, strong) NSString *ownerName;
@property (nonatomic, strong) NSString *ownerAvatarURLString;
@property (nonatomic, strong) JBStackExchangeBadgeCount *ownerBadges;
@property (nonatomic, assign) NSInteger ownerReputation;

@end

@implementation JBStackExchangeItemOwner

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary: dictionary])
    {
        _ownerName = dictionary[kStackExchangeResponseOwnerDisplayNameKey];
        _ownerAvatarURLString = dictionary[kStackExchangeResponseOwnerAvatarImageKey];
        _ownerReputation = [dictionary[kStackExchangeResponseOwnerReputationKey] integerValue];
        _ownerBadges = [[JBStackExchangeBadgeCount alloc] initWithDictionary: dictionary[kStackExchangeResponseItemBadgeCountsKey]];
    }
    
    return self;
}

@end