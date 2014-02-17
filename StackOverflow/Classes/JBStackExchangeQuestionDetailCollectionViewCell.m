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

CGFloat const kQuestionDetailCellWidth = 300;
CGFloat const kQuestionDetailCellWidthIpad = 728;

// I just grabbed these values from the storyboard to get my UI looking better without
// actually spending much time on it.
CGFloat const kQuestionDetailCellVerticalLabelPadding = 8;
CGFloat const kQuestionDetailCellVerticalPaddingTotal = 40;
CGFloat const kQuestionDetailCellHorizontalPaddingTotal = 40;

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
    CGSize cellSize = CGSizeZero;
    
    NSAttributedString *questionBody = [NSAttributedString attributedStringFromHTML: question.questionBodyHTML];
    NSAttributedString *questionTitle = [NSAttributedString attributedStringFromHTML: question.questionTitleHTML];
    
    if (isIpad)
    {
        CGFloat questionCellHeight = 0;
        CGSize cellConstraintSizeIpad = CGSizeMake(kQuestionDetailCellWidthIpad - kQuestionDetailCellHorizontalPaddingTotal, 0.0);
        
        CGFloat questionBodyHeightIpad = [questionBody boundingRectWithSize: cellConstraintSizeIpad
                                                                    options: NSStringDrawingUsesLineFragmentOrigin
                                                                    context: NULL].size.height;
        
        CGFloat questionTitleHeightIpad = [questionTitle boundingRectWithSize: cellConstraintSizeIpad
                                                                      options: NSStringDrawingUsesLineFragmentOrigin
                                                                      context: NULL].size.height;
        
        questionCellHeight += questionBodyHeightIpad;
        questionCellHeight += questionTitleHeightIpad;
        questionCellHeight += kQuestionDetailCellVerticalLabelPadding;
        questionCellHeight += kQuestionDetailCellVerticalPaddingTotal;
        
        cellSize = CGSizeMake(kQuestionDetailCellWidthIpad, questionCellHeight);
    }
    else
    {
        CGFloat questionCellHeight = 0;
        CGSize cellConstraintSize = CGSizeMake(kQuestionDetailCellWidth - kQuestionDetailCellHorizontalPaddingTotal, 0.0);
        
        CGFloat questionBodyHeight = [questionBody boundingRectWithSize: cellConstraintSize
                                                                options: NSStringDrawingUsesLineFragmentOrigin
                                                                context: NULL].size.height;
        
        CGFloat questionTitleHeight = [questionTitle boundingRectWithSize: cellConstraintSize
                                                                  options: NSStringDrawingUsesLineFragmentOrigin
                                                                  context: NULL].size.height;
        
        questionCellHeight += questionBodyHeight;
        questionCellHeight += questionTitleHeight;
        questionCellHeight += kQuestionDetailCellVerticalLabelPadding;
        questionCellHeight += kQuestionDetailCellVerticalPaddingTotal;
        
        cellSize = CGSizeMake(kQuestionDetailCellWidth, questionCellHeight);
    }
    
    return cellSize;
}

@end
