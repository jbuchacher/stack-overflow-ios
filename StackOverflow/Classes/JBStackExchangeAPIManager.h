//
//  JBStackOverflowAPIManager.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBStackExchangeResponse.h"
#import "JBStackExchangeResponseItem.h"
#import "JBStackExchangeAPIOptions.h"
#import "JBStackExchangeSearchQuery.h"

typedef void (^JBStackExchangeSuccessBlock)(JBStackExchangeResponse *responseObject);
typedef void (^JBStackExchangeFailureBlock)(NSError *error);

@interface JBStackExchangeAPIManager : NSObject

@property (nonatomic, strong) JBStackExchangeAPIOptions *apiOptions;

- (void)fetchStackExchangeQuestionsWithQuery:(JBStackExchangeSearchQuery *)query
                                     success:(JBStackExchangeSuccessBlock)success
                                     failure:(JBStackExchangeFailureBlock)failure;

- (void)fetchStackExchangeSitesWithSuccess:(JBStackExchangeSuccessBlock)success
                                   failure:(JBStackExchangeFailureBlock)failure;

- (void)fetchImageWithURLString:(NSString *)urlString
                        success:(void (^)(UIImage *image))imageSuccessBlock
                        failure:(JBStackExchangeFailureBlock)failure;

- (NSURLRequest *)createLoginRequest;

+ (instancetype)shared;

@end