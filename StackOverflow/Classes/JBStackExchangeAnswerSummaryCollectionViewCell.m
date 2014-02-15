//
//  JBStackExchangeAnswerSummaryCollectionViewCell.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeAnswerSummaryCollectionViewCell.h"
#import "JBStackExchangeAnswer.h"

@interface JBStackExchangeAnswerSummaryCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIWebView *answerBodyWebView;

@end

@implementation JBStackExchangeAnswerSummaryCollectionViewCell

- (void)prepareForReuse
{
    [self.answerBodyWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
}

- (void)setAnswer:(JBStackExchangeAnswer *)answer
{
    _answer = answer;
    
    [self.answerBodyWebView loadHTMLString: answer.answerBodyHTML
                                   baseURL: nil];
}

@end