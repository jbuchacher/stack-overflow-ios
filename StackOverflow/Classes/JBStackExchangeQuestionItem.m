//
//  JBStackOverflowQuestion.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuestionItem.h"
#import "JBStackExchangeAnswerItem.h"

NSString * const kStackExchangeQuestionScoreKey = @"score";
NSString * const kStackExchangeQuestionIsAnsweredKey = @"is_answered";

@interface JBStackExchangeQuestionItem ()

@property (nonatomic, strong) JBStackExchangeItemOwner *questionOwner;
@property (nonatomic, strong) NSString *questionTitleHTML;
@property (nonatomic, strong) NSString *questionBodyHTML;
@property (nonatomic, strong) NSDate *questionCreationDate;
@property (nonatomic, strong) NSArray *questionAnswers;
@property (nonatomic, assign) NSInteger questionVotes;
@property (nonatomic, assign) BOOL isAnswered;

@end

@implementation JBStackExchangeQuestionItem

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary: dictionary])
    {
        /*
         
         {
         "tags": [
         "windows",
         "c#",
         ".net"
         ],
         "owner": {
         "reputation": 9001,
         "user_id": 1,
         "user_type": "registered",
         "accept_rate": 55,
         "profile_image": "https://www.gravatar.com/avatar/a007be5a61f6aa8f3e85ae2fc18dd66e?d=identicon&r=PG",
         "display_name": "Example User",
         "link": "http://example.stackexchange.com/users/1/example-user"
         },
         "is_answered": false,
         "view_count": 31415,
         "favorite_count": 1,
         "down_vote_count": 2,
         "up_vote_count": 3,
         "answer_count": 0,
         "score": 1,
         "last_activity_date": 1392203368,
         "creation_date": 1392160168,
         "last_edit_date": 1392228568,
         "question_id": 1234,
         "link": "http://example.stackexchange.com/questions/1234/an-example-post-title",
         "title": "An example post title",
         "body": "An example post body"
         }
         
         */
        
        _questionOwner = [[JBStackExchangeItemOwner alloc] initWithDictionary: dictionary[kStackExchangeResponseItemOwnerKey]];
        
        _questionTitleHTML = dictionary[kStackExchangeResponseItemTitleKey];
        _questionBodyHTML = dictionary[kStackExchangeResponseItemBodyKey];
        
        NSDictionary *answersJSON = dictionary[kStackExchangeResponseItemAnswersKey];
        NSMutableArray *answers = [NSMutableArray arrayWithCapacity: answersJSON.count];
        for (NSDictionary *answerJSON in answersJSON)
        {
            JBStackExchangeAnswerItem *answer = [[JBStackExchangeAnswerItem alloc] initWithDictionary: answerJSON];
            
            if (answer.isAcceptedAnswer)
            {
                [answers insertObject: answer
                              atIndex: 0];
            }
            else
            {
                [answers addObject: answer];
            }
        }
        
        _questionAnswers = answers;
        
        _questionVotes = [dictionary[kStackExchangeQuestionScoreKey] integerValue];
        
        _questionCreationDate = [NSDate dateWithTimeIntervalSince1970: [dictionary[kStackExchangeResponseItemCreationDateKey] longValue]];
        
        _isAnswered = [dictionary[kStackExchangeQuestionIsAnsweredKey] boolValue];
    }
    
    return self;
}

@end