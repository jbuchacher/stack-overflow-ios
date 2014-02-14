//
//  JBStackOverflowAPIManager.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackOverflowAPIManager.h"

NSString * const kStackExchangeDefaultHost = @"http://api.stackexchange.com/";
NSString * const kStackExchangeSitesPath = @"sites";

typedef JBStackExchangeResponse * (^JBStackExchangeResponseParseBlock)(JBStackExchangeResponse *response);

@interface JBStackOverflowAPIManager ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation JBStackOverflowAPIManager

#pragma mark - Sites

- (void)fetchStackExchangeSitesWithSuccess:(JBStackExchangeSuccessBlock)success
                                   failure:(JBStackExchangeFailureBlock)failure
{
    NSURL *sitesURL = [NSURL URLWithString: [kStackExchangeDefaultHost stringByAppendingPathComponent: kStackExchangeSitesPath]];
    
    JBStackExchangeResponseParseBlock parseBlock = ^(JBStackExchangeResponse *response)
    {
        for (NSDictionary *item in response.items)
        {
            
        }
        
        return response;
    };
    
    [[self jsonTaskWithURL: sitesURL
                parseBlock: parseBlock
                   success: success
                   failure: failure] resume];
}

#pragma mark - Default Request Handling

- (NSURLRequest *)defaultURLRequestWithURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL: url
                                             cachePolicy: NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval: 60];
    
    return request;
}

- (NSURLSessionDataTask *)jsonTaskWithURL:(NSURL *)url
                               parseBlock:(JBStackExchangeResponseParseBlock)parseBlock
                                  success:(JBStackExchangeSuccessBlock)successBlock
                                  failure:(JBStackExchangeFailureBlock)failureBlock
{
    NSURLRequest *urlRequest = [self defaultURLRequestWithURL: url];
    return [self jsonTaskWithRequest: urlRequest
                          parseBlock: parseBlock
                             success: successBlock
                             failure: failureBlock];
}

- (NSURLSessionDataTask *)jsonTaskWithRequest:(NSURLRequest *)request
                                   parseBlock:(JBStackExchangeResponseParseBlock)parseBlock
                                      success:(JBStackExchangeSuccessBlock)successBlock
                                      failure:(JBStackExchangeFailureBlock)failureBlock
{
    return [self.session dataTaskWithRequest: request
                           completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error)
            {
                if ([response isKindOfClass: [NSHTTPURLResponse class]])
                {
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                    //NSDictionary *headers = [httpResponse allHeaderFields];
                    
                    if (TRUE) // header validation)
                    {
                        NSError *jsonParseError = nil;
                        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData: data
                                                                                     options: 0
                                                                                       error: &jsonParseError];
                        if (jsonParseError)
                        {
                            // handle error
                        }
                        else
                        {
                            if (successBlock)
                            {
                                JBStackExchangeResponse *response = [[JBStackExchangeResponse alloc] initWithDictionary: jsonResponse];
                                
                                if (parseBlock)
                                {
                                    successBlock(parseBlock(response));
                                }
                                else
                                {
                                    successBlock(response);
                                }
                            }
                        }
                    }
                }
            }];
}

#pragma mark - Initialization

- (id)init
{
    if (self = [super init])
    {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setHTTPAdditionalHeaders: @{@"Content-Type" : @"application/json",
                                                          @"Accept" : @"application/json"}];
        
        _session = [NSURLSession sessionWithConfiguration: sessionConfiguration];
        
    }
    
    return self;
}

+ (instancetype)shared
{
    static id singleton = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        singleton = [[self alloc] init];
    });
    
    return singleton;
}

@end