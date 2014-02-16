//
//  JBStackExchangeItemOwner.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponseItem.h"
#import "JBStackExchangeBadgeCount.h"

extern NSString * const kStackExchangeResponseItemBadgeCountsKey;

@interface JBStackExchangeItemOwner : JBStackExchangeResponseItem

@property (nonatomic, strong, readonly) NSString *ownerName;
@property (nonatomic, strong, readonly) NSString *ownerAvatarURLString;
@property (nonatomic, strong, readonly) JBStackExchangeBadgeCount *ownerBadges;
@property (nonatomic, assign, readonly) NSInteger ownerReputation;

@end