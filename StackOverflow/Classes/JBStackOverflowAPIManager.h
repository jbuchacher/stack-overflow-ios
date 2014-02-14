//
//  JBStackOverflowAPIManager.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBStackExchangeResponse.h"

typedef void (^JBStackExchangeSuccessBlock)(JBStackExchangeResponse *responseObject);
typedef void (^JBStackExchangeFailureBlock)(NSError *error);

@interface JBStackOverflowAPIManager : NSObject

- (void)fetchStackExchangeSitesWithSuccess:(JBStackExchangeSuccessBlock)success
                                   failure:(JBStackExchangeFailureBlock)failure;

+ (instancetype)shared;

@end