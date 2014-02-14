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

// API Host
NSString * const kStackExchangeDefaultHost = @"http://api.stackexchange.com/";
// Sites API
NSString * const kStackExchangeSitesPath = @"sites";

/* Most StackExchange responses return an array of "items", which represent whatever you were requesting.
 * The parse items block wil be called on each JSON dictionary contained in the items field.
 * Use this block to serialize each dictionary into it's appropriate model object for the request.
 * The response returned in the request's success block will have it's -items set to an array of items
 * parsed by your block, or by default an array of REIStackExchangeResponseItems.
*/
typedef JBStackExchangeResponseItem * (^JBStackExchangeResponseParseItemsBlock)(NSDictionary *responseItem);


@interface JBStackExchangeAPIManager ()

@property (nonatomic, strong) JBStackExchangeAPIOptions *apiOptions;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;

@end


@implementation JBStackExchangeAPIManager

#pragma mark - Sites

- (void)fetchStackExchangeSitesWithSuccess:(JBStackExchangeSuccessBlock)success
                                   failure:(JBStackExchangeFailureBlock)failure
{
    NSURL *sitesURL = [NSURL URLWithString: [kStackExchangeDefaultHost stringByAppendingPathComponent: kStackExchangeSitesPath]];
    
    JBStackExchangeResponseParseItemsBlock parseBlock = ^(NSDictionary *responseJSON)
    {
        JBStackExchangeSiteItem *responseItem = [[JBStackExchangeSiteItem alloc] initWithDictionary: responseJSON];
        return responseItem;
    };
    
    [[self jsonTaskWithURL: sitesURL
                parseBlock: parseBlock
                   success: success
                   failure: failure] resume];
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

- (NSURLSessionDataTask *)jsonTaskWithURL:(NSURL *)url
                               parseBlock:(JBStackExchangeResponseParseItemsBlock)parseItemBlock
                                  success:(JBStackExchangeSuccessBlock)successBlock
                                  failure:(JBStackExchangeFailureBlock)failureBlock
{
    NSURLRequest *urlRequest = [self defaultURLRequestWithURL: url];
    return [self jsonTaskWithRequest: urlRequest
                          parseBlock: parseItemBlock
                             success: successBlock
                             failure: failureBlock];
}

- (NSURLSessionDataTask *)jsonTaskWithRequest:(NSURLRequest *)request
                                   parseBlock:(JBStackExchangeResponseParseItemsBlock)parseItemBlock
                                      success:(JBStackExchangeSuccessBlock)successBlock
                                      failure:(JBStackExchangeFailureBlock)failureBlock
{
    return [self.session dataTaskWithRequest: request
                           completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error)
            {
                if ([response isKindOfClass: [NSHTTPURLResponse class]])
                {
                    //NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
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
                                JBStackExchangeResponse *response = [self responseFromJSONResponse: jsonResponse
                                                                                    parseItemBlock: parseItemBlock];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    successBlock(response);
                                });
                            }
                        }
                    }
                }
            }];
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

#pragma mark - Initialization

- (id)init
{
    if (self = [super init])
    {
        JBStackExchangeAPIOptions *apiOptions = [[JBStackExchangeAPIOptions alloc] init];
        _apiOptions = apiOptions;
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [sessionConfiguration setHTTPAdditionalHeaders: @{@"Content-Type" : @"application/json",
                                                          @"Accept" : @"application/json"}];
        
        _session = [NSURLSession sessionWithConfiguration: sessionConfiguration];
        _imageOperationQueue = [[NSOperationQueue alloc] init];
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