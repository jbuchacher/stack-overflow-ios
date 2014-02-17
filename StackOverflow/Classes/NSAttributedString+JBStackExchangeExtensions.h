//
//  NSAttributedString+JBStackExchangeExtensions.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/16/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (JBStackExchangeExtensions)

+ (NSAttributedString *)attributedStringFromHTML:(NSString *)HTML;

@end