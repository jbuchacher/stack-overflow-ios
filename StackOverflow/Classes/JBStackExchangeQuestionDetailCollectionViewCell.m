//
//  JBStackExchangeQuestionDetailCollectionViewCell.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuestionDetailCollectionViewCell.h"
#import "JBStackExchangeQuestionItem.h"

@interface JBStackExchangeQuestionDetailCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *questionTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionBodyLabel;

@end

@implementation JBStackExchangeQuestionDetailCollectionViewCell

- (void)prepareForReuse
{
    self.question = nil;
}

- (void)setQuestion:(JBStackExchangeQuestionItem *)question
{
    _question = question;
    
    if (question)
    {
        self.questionTitleLabel.attributedText = question.questionTitle;
        self.questionBodyLabel.attributedText = question.questionBody;
    }
    else
    {
        self.questionTitleLabel.text = @"";
        self.questionBodyLabel.text = @"";
    }
}

+ (CGFloat)cellHeightWithQuestion:(JBStackExchangeQuestionItem *)question
{
    return 150.0;
}

@end
