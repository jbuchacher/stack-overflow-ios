//
//  JBStackExchangeQuestionDetailCollectionViewCell.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuestionDetailCollectionViewCell.h"
#import "JBStackExchangeQuestionItem.h"
#import "NSAttributedString+JBStackExchangeExtensions.h"

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
        self.questionTitleLabel.attributedText = [NSAttributedString attributedStringFromHTML: question.questionTitleHTML];
        self.questionBodyLabel.attributedText = [NSAttributedString attributedStringFromHTML: question.questionBodyHTML];
    }
    else
    {
        self.questionTitleLabel.text = @"";
        self.questionBodyLabel.text = @"";
    }
}

+ (CGSize)cellSizeWithQuestion:(JBStackExchangeQuestionItem *)question
                        isIpad:(BOOL)isIpad
{
    if (isIpad)
    {
        return CGSizeMake(728, 600);
    }
    
    return CGSizeMake(300, 400);
}

@end
