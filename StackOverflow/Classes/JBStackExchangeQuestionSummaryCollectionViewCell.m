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

CGFloat const kQuestionSummaryCellWidth = 280;
CGFloat const kQuestionSummaryCellWidthIpad = 350;

// I just grabbed these values from the storyboard to get my UI looking better without
// actually spending much time on it.
CGFloat const kQuestionSummaryVotesAndAnswersHeight = 68;
CGFloat const kQuestionSummaryVerticalPaddingTotal = 40;

@interface JBStackExchangeQuestionSummaryCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *questionTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionVotesLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionAnswersLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionCreationDateLabel;

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
        
        
        
        // My preferred practice is keeping specific date formatters around in memory, they are expensive
        // to create. I never added dates to the UI, so I dropped this in really quick. This is not what
        // I would ship in production :)
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.locale = [NSLocale currentLocale];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        
        self.questionCreationDateLabel.text = [dateFormatter stringFromDate: question.questionCreationDate];
    }
    else
    {
        self.questionTitleLabel.text = @"";
        self.questionVotesLabel.text = @"";
        self.questionAnswersLabel.text = @"";
        self.questionCreationDateLabel.text = @"";
    }
}

+ (CGSize)cellSizeWithQuestion:(JBStackExchangeQuestionItem *)question
                        isIpad:(BOOL)isIpad
{
    CGSize cellSize = CGSizeZero;
    
    NSAttributedString *questionTitle = [NSAttributedString attributedStringFromHTML: question.questionTitleHTML];
    
    if (isIpad)
    {
        CGSize questionTitleConstraintSizeIpad = CGSizeMake(kQuestionSummaryCellWidthIpad, 0.0);
        CGFloat questionTitleHeightIpad = [questionTitle boundingRectWithSize: questionTitleConstraintSizeIpad
                                                                      options: NSStringDrawingUsesLineFragmentOrigin
                                                                      context: NULL].size.height;
        
        cellSize = CGSizeMake(kQuestionSummaryCellWidthIpad, questionTitleHeightIpad + kQuestionSummaryVotesAndAnswersHeight + kQuestionSummaryVerticalPaddingTotal);
    }
    else
    {
        CGSize questionTitleConstraintSize = CGSizeMake(kQuestionSummaryCellWidth, 0.0);
        CGFloat questionTitleHeight = [questionTitle boundingRectWithSize: questionTitleConstraintSize
                                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                                                  context: NULL].size.height;
        
        cellSize = CGSizeMake(kQuestionSummaryCellWidth, questionTitleHeight + kQuestionSummaryVotesAndAnswersHeight + kQuestionSummaryVerticalPaddingTotal);
    }
    
    return cellSize;
}

@end