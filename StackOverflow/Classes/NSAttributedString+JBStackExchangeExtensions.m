//
//  NSAttributedString+JBStackExchangeExtensions.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/16/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "NSAttributedString+JBStackExchangeExtensions.h"

@implementation NSAttributedString (JBStackExchangeExtensions)

+ (NSAttributedString *)attributedStringFromHTML:(NSString *)HTML
{
    NSError *parseError = nil;
    NSAttributedString *attributedHTMLString = [[NSAttributedString alloc] initWithData: [HTML dataUsingEncoding: NSUTF8StringEncoding]
                                                                                options: @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                                     documentAttributes: nil
                                                                                  error: &parseError];
    if (parseError != nil)
    {
        return [[NSAttributedString alloc] initWithString: @""];
    }
    
    return attributedHTMLString;
}

@end