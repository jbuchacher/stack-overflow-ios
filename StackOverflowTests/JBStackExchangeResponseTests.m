//
//  JBStackExchangeResponseTests.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/16/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JBStackExchangeResponse.h"
#import "JBStackExchangeTestHelper.h"

@interface JBStackExchangeResponseTests : XCTestCase

@property (nonatomic, strong) JBStackExchangeResponse *responseObject;

@end

@implementation JBStackExchangeResponseTests

- (void)setUp
{
    [super setUp];
    
    NSDictionary *responseJSONDictionary = [JBStackExchangeTestHelper jsonDictionaryFromFilename: @"JBStackExchangeResponseJSON.json"];
    self.responseObject = [[JBStackExchangeResponse alloc] initWithDictionary: responseJSONDictionary];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testResponseDefaultValues
{
    XCTAssertNotNil(self.responseObject, @"Response object should not be nil");
}

@end
