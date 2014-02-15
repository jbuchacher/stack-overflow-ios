//
//  JBStackExchangeLoginViewController.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeLoginViewController.h"

extern NSString * const kJBStackExchangeLoginCallbackNotificationName;

@interface JBStackExchangeLoginViewController ()

@end

@implementation JBStackExchangeLoginViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(handleLoginCallback:)
                                                 name: kJBStackExchangeLoginCallbackNotificationName
                                               object: nil];
    
    NSURLRequest *loginRequest = [[JBStackExchangeAPIManager shared] createLoginRequest];
    [self.loginWebView loadRequest: loginRequest];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: kJBStackExchangeLoginCallbackNotificationName
                                                  object: nil];
}

- (IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated: YES
                                                      completion: nil];
}

- (void)handleLoginCallback:(NSNotification *)notification
{
    NSDictionary *userinfo = notification.userInfo;
    NSString *callbackURLFragment = [userinfo[@"URL"] fragment];
    NSArray *callbackURLComponents = [callbackURLFragment componentsSeparatedByString: @"&"];
    NSMutableDictionary *keyValueDictionary = [[NSMutableDictionary alloc] initWithCapacity: callbackURLComponents.count];
    for (NSString *keyValuePair in callbackURLComponents)
    {
        NSArray *keyValueComponents = [keyValuePair componentsSeparatedByString: @"="];
        NSString *key = keyValueComponents[0];
        NSString *value = keyValueComponents[1];
        keyValueDictionary[key] = value;
    }
    
    [[JBStackExchangeAPIManager shared] apiOptions].accessToken = keyValueDictionary[@"access_token"];
    
    [self dismiss: nil];
}

@end