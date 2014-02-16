//
//  JBQuestionSummaryCollectionViewCell.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuestionSummaryCollectionViewCell.h"
#import "JBStackExchangeQuestion.h"

@interface JBStackExchangeQuestionSummaryCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *questionTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionVotesLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionAnswersLabel;

@end

@implementation JBStackExchangeQuestionSummaryCollectionViewCell

- (void)prepareForReuse
{
    self.question = nil;
}

- (void)setQuestion:(JBStackExchangeQuestion *)question
{
    _question = question;
    
    if (question)
    {
        self.questionTitleLabel.text = question.questionTitle;
        self.questionVotesLabel.text = [NSString stringWithFormat: @"%d", question.questionVotes];
        self.questionAnswersLabel.text = [NSString stringWithFormat: @"%d", question.questionAnswers.count];
    }
    else
    {
        self.questionTitleLabel.text = @"";
        self.questionVotesLabel.text = @"";
        self.questionAnswersLabel.text = @"";
    }
}

@end