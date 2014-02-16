//
//  JBStackExchangeItemOwner.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponseItem.h"

@interface JBStackExchangeItemOwner : JBStackExchangeResponseItem

@property (nonatomic, strong, readonly) NSString *ownerName;

@end