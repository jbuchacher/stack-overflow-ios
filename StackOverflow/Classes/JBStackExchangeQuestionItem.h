//
//  JBStackOverflowQuestion.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeResponseItem.h"
#import "JBStackExchangeItemOwner.h"

@interface JBStackExchangeQuestionItem : JBStackExchangeResponseItem

@property (nonatomic, strong, readonly) JBStackExchangeItemOwner *questionOwner;
@property (nonatomic, strong, readonly) NSAttributedString *questionTitle;
@property (nonatomic, strong, readonly) NSAttributedString *questionBody;
@property (nonatomic, strong, readonly) NSArray *questionAnswers;
@property (nonatomic, assign, readonly) NSInteger questionVotes;
@property (nonatomic, assign, readonly) BOOL isAnswered;

@end