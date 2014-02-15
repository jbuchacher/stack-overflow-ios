//
//  JBStackOverflowAPIManager.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeAPIManager.h"

// Models
#import "JBStackExchangeSiteItem.h"
#import "JBStackExchangeQuestion.h"

// Errors
NSString * const JBStackExchangeAPIManagerErrorDomain = @"JBStackExchangeAPIManagerErrorDomain";

// API Host
NSString * const kStackExchangeDefaultHost = @"https://api.stackexchange.com/";
// Sites
NSString * const kStackExchangeSitesPath = @"sites";
// Questions
NSString * const kStackExchangeSearchQuestionsPath = @"search";

/* Most StackExchange responses return an array of "items", which represent whatever you were requesting.
 * The parse items block wil be called on each JSON dictionary contained in the items field.
 * Use this block to serialize each dictionary into it's appropriate model object for the request.
 * The response returned in the request's success block will have it's -items set to an array of items
 * parsed by your block, or by default an array of REIStackExchangeResponseItems.
*/
typedef JBStackExchangeResponseItem * (^JBStackExchangeResponseParseItemsBlock)(NSDictionary *responseItem);


@interface JBStackExchangeAPIManager ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;

@end

@implementation JBStackExchangeAPIManager

#pragma mark - Search Questions

- (void)fetchStackExchangeQuestionsWithQuery:(JBStackExchangeSearchQuery *)query
                                     success:(JBStackExchangeSuccessBlock)success
                                     failure:(JBStackExchangeFailureBlock)failure
{
    query.filter = @"!LR0Y.6RBe4l)H.4eMa.5JH";
    NSURL *questionsURL = [self urlFromPath: kStackExchangeSearchQuestionsPath
                                      query: query];
    
    JBStackExchangeResponseParseItemsBlock parseBlock = ^(NSDictionary *responseJSON)
    {
        JBStackExchangeQuestion *responseItem = [[JBStackExchangeQuestion alloc] initWithDictionary: responseJSON];
        return responseItem;
    };
    
    [self startJSONTaskWithURL: questionsURL
                    parseBlock: parseBlock
                       success: success
                       failure: failure];
}

#pragma mark - Sites

- (void)fetchStackExchangeSitesWithSuccess:(JBStackExchangeSuccessBlock)success
                                   failure:(JBStackExchangeFailureBlock)failure
{
    NSURL *sitesURL = [self urlFromPath: kStackExchangeSitesPath
                                  query: nil];
    
    JBStackExchangeResponseParseItemsBlock parseBlock = ^(NSDictionary *responseJSON)
    {
        JBStackExchangeSiteItem *responseItem = [[JBStackExchangeSiteItem alloc] initWithDictionary: responseJSON];
        return responseItem;
    };
    
    [self startJSONTaskWithURL: sitesURL
                    parseBlock: parseBlock
                       success: success
                       failure: failure];
}

#pragma mark - Images

- (void)fetchImageWithURLString:(NSString *)urlString
                        success:(void (^)(UIImage *image))imageSuccessBlock
                        failure:(JBStackExchangeFailureBlock)failure;
{
    [self.imageOperationQueue addOperationWithBlock: ^
    {
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlString]
                                             options: 0
                                               error: &error];
        if (!error)
        {
            UIImage *image = [UIImage imageWithData: data
                                              scale: [[UIScreen mainScreen] scale]];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock: ^
            {
                if (imageSuccessBlock)
                {
                    imageSuccessBlock(image);
                }
            }];
        }
        else
        {
            if (failure)
            {
                failure(error);
            }
        }
    }];
}

#pragma mark - Default Request Handling

- (NSURLRequest *)defaultURLRequestWithURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL: url
                                             cachePolicy: NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval: 60];
    
    return request;
}

- (void)startJSONTaskWithURL:(NSURL *)url
                  parseBlock:(JBStackExchangeResponseParseItemsBlock)parseItemBlock
                     success:(JBStackExchangeSuccessBlock)successBlock
                     failure:(JBStackExchangeFailureBlock)failureBlock
{
    NSURLRequest *urlRequest = [self defaultURLRequestWithURL: url];
    [self startJSONTaskWithRequest: urlRequest
                        parseBlock: parseItemBlock
                           success: successBlock
                           failure: failureBlock];
}

- (void)startJSONTaskWithRequest:(NSURLRequest *)request
                      parseBlock:(JBStackExchangeResponseParseItemsBlock)parseItemBlock
                         success:(JBStackExchangeSuccessBlock)successBlock
                         failure:(JBStackExchangeFailureBlock)failureBlock
{
    NSLog(@"Executing request: %@", request);
    [[self.session dataTaskWithRequest: request
                     completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error)
      {
          NSLog(@"Received response: %@", response);
          if ([response isKindOfClass: [NSHTTPURLResponse class]])
          {
              if (error)
              {
                  if (failureBlock)
                  {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          failureBlock(error);
                      });
                  }
              }
              else
              {
                  NSError *jsonParseError = nil;
                  NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData: data
                                                                               options: 0
                                                                                 error: &jsonParseError];
                  if (jsonParseError)
                  {
                      if (failureBlock)
                      {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              failureBlock(error);
                          });
                      }
                  }
                  else
                  {
                      JBStackExchangeResponse *response = [self responseFromJSONResponse: jsonResponse
                                                                          parseItemBlock: parseItemBlock];
                      
                      if (response.error)
                      {
                          if (failureBlock)
                          {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  failureBlock(response.error);
                              });
                          }
                      }
                      else
                      {
                          if (successBlock)
                          {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  successBlock(response);
                              });
                          }
                      }
                  }
              }
          }
      }] resume];
}

#pragma mark - Parsing

- (JBStackExchangeResponse *)responseFromJSONResponse:(NSDictionary *)jsonResponse
                                       parseItemBlock:(JBStackExchangeResponseParseItemsBlock)parseBlock
{
    JBStackExchangeResponse *response = [[JBStackExchangeResponse alloc] initWithDictionary: jsonResponse];
    NSArray *jsonItems = jsonResponse[kStackExchangeResponseItemsKey];
    
    NSMutableArray *responseItems = [NSMutableArray arrayWithCapacity: jsonItems.count];
    
    if (parseBlock)
    {
        for (NSDictionary *responseItem in jsonItems)
        {
            JBStackExchangeResponseItem *parsedResponseItem = parseBlock(responseItem);
            [responseItems addObject: parsedResponseItem];
        }
    }
    else
    {
        for (NSDictionary *responseItem in jsonItems)
        {
            JBStackExchangeResponseItem *genericResponseItem = [[JBStackExchangeResponseItem alloc] initWithDictionary: responseItem];
            [responseItems addObject: genericResponseItem];
        }
    }
    
    response.items = responseItems;
    
    return response;
}

#pragma mark - URL's & Query Strings

- (NSURL *)urlFromPath:(NSString *)path
                 query:(JBStackExchangeQuery *)query
{
    NSString *baseAndPathString = [kStackExchangeDefaultHost stringByAppendingPathComponent: path];
    NSMutableString *urlString = [[NSMutableString alloc] initWithString: baseAndPathString];
    
    if (query)
    {
        [urlString appendString: [self queryStringFromQuery: query]];
    }
    
    return [NSURL URLWithString: urlString];
}

- (NSString *)queryStringFromQuery:(JBStackExchangeQuery *)query
{
    NSString *queryString = @"";
    NSMutableDictionary *queryParameters = [NSMutableDictionary dictionaryWithDictionary: query.queryParameters];

    if (self.apiOptions.accessToken)
    {
        queryParameters[kStackExchangeRequestOptionAccessTokenKey] = self.apiOptions.accessToken;
        queryParameters[kStackExchangeRequestOptionAccessKeyKey] = self.apiOptions.apiKey;
    }
    
    if (self.apiOptions.siteParameter)
    {
        queryParameters[kStackExchangeRequestOptionSiteKey] = self.apiOptions.siteParameter;
    }
    
    if (queryParameters.count)
    {
        NSMutableString *queryParameterString = [[NSMutableString alloc] initWithString: @"?"];
        
        for (NSString *key in queryParameters.allKeys)
        {
            [queryParameterString appendFormat: @"%@=%@&", key, queryParameters[key]];
        }
        
        if ([queryParameterString hasSuffix: @"&"])
        {
            queryString = [queryParameterString stringByReplacingCharactersInRange: NSMakeRange(queryParameterString.length - 1, 1)
                                                                                 withString: @""];
        }
        else
        {
            queryString = queryParameterString;
        }
    }
    
    return queryString;
}

#pragma mark - OAuth Login

- (NSURLRequest *)createLoginRequest
{
    NSString *loginURLString = @"https://stackexchange.com/oauth/dialog?client_id=2621&redirect_uri=jbso://com.jbuchacher.stackoverflow/";
    NSURL *loginURL = [NSURL URLWithString: loginURLString];
    NSURLRequest *loginRequest = [NSURLRequest requestWithURL: loginURL
                                                  cachePolicy: NSURLCacheStorageNotAllowed
                                              timeoutInterval: 30];
    
    return loginRequest;
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
        _imageOperationQueue = [[NSOperationQueue alloc] init];
        
        _apiOptions = [[JBStackExchangeAPIOptions alloc] init];
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