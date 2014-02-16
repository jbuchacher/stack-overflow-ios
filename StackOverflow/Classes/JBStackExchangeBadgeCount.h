//
//  JBStackExchangeBadgeCount.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeModel.h"

@interface JBStackExchangeBadgeCount : JBStackExchangeModel

@property (nonatomic, assign, readonly) NSInteger goldBadges;
@property (nonatomic, assign, readonly) NSInteger silverBadges;
@property (nonatomic, assign, readonly) NSInteger bronzeBadges;

@end
