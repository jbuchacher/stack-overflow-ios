//
//  JBQuestionSummaryCollectionViewCell.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuestionSummaryCollectionViewCell.h"
#import "JBStackExchangeQuestionItem.h"
#import "NSAttributedString+JBStackExchangeExtensions.h"

CGFloat const kQuestionSummaryCellWidth = 300;
CGFloat const kQuestionSummaryCellWidthIpad = 354;

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

- (void)setQuestion:(JBStackExchangeQuestionItem *)question
{
    _question = question;
    
    if (question)
    {
        self.questionTitleLabel.attributedText = [NSAttributedString attributedStringFromHTML: question.questionTitleHTML];
        self.questionVotesLabel.text = [NSString stringWithFormat: @"%ld", (long)question.questionVotes];
        self.questionAnswersLabel.text = [NSString stringWithFormat: @"%ld", (long)question.questionAnswers.count];
    }
    else
    {
        self.questionTitleLabel.text = @"";
        self.questionVotesLabel.text = @"";
        self.questionAnswersLabel.text = @"";
    }
}

+ (CGSize)cellSizeWithQuestion:(JBStackExchangeQuestionItem *)question
                        isIpad:(BOOL)isIpad
{
    if (isIpad)
    {
        return CGSizeMake(kQuestionSummaryCellWidthIpad, 200);
    }
    
    return CGSizeMake(kQuestionSummaryCellWidth, 130);
}

@end