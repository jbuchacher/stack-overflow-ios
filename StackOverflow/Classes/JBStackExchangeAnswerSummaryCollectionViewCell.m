//
//  JBStackExchangeAnswerSummaryCollectionViewCell.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeAnswerSummaryCollectionViewCell.h"
#import "JBStackExchangeAnswerItem.h"
#import "NSAttributedString+JBStackExchangeExtensions.h"

NSString * const kStackExchangeAnswerAcceptedImageName = @"checkmark-selected";
NSString * const kStackExchangeAnswerUnacceptedImageName = @"checkmark-unselected";

CGFloat const kAnswerSummaryCellWidth = 260;
CGFloat const kAnswerSummaryCellWidthIpad = 688;

// I just grabbed these values from the storyboard to get my UI looking better without
// actually spending much time on it.
CGFloat const kAnswerSummaryCellOwnerInfoHeight = 86;
CGFloat const kAnswerSummaryCellVerticalPaddingTotal = 40;

@interface JBStackExchangeAnswerSummaryCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *answerBodyLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerOwnerNameLabel;

@property (nonatomic, weak) IBOutlet UIImageView *answerAcceptedImageView;

@end

@implementation JBStackExchangeAnswerSummaryCollectionViewCell

- (void)prepareForReuse
{
    self.answer = nil;
}

- (void)setAnswer:(JBStackExchangeAnswerItem *)answer
{
    _answer = answer;
    
    if (answer)
    {
        self.answerBodyLabel.attributedText = [NSAttributedString attributedStringFromHTML: answer.answerBodyHTML];
        self.answerOwnerNameLabel.text = answer.answerOwner.ownerName;
        
        NSString *acceptedImageName = answer.isAcceptedAnswer ? kStackExchangeAnswerAcceptedImageName : kStackExchangeAnswerUnacceptedImageName;
        self.answerAcceptedImageView.image = [UIImage imageNamed: acceptedImageName];
    }
    else
    {
        self.answerBodyLabel.text = @"";
        self.answerOwnerNameLabel.text = @"";
        self.answerAcceptedImageView.image = nil;
    }
}

+ (CGSize)cellSizeWithAnswer:(JBStackExchangeAnswerItem *)answer
                      isIpad:(BOOL)isIpad
{
    CGSize cellSize = CGSizeZero;
    
    NSAttributedString *answerBody = [NSAttributedString attributedStringFromHTML: answer.answerBodyHTML];
    
    if (isIpad)
    {
        CGSize answerBodyConstraintSizeIpad = CGSizeMake(kAnswerSummaryCellWidthIpad, 0.0);
        CGFloat answerBodyHeightIpad = [answerBody boundingRectWithSize: answerBodyConstraintSizeIpad
                                                             options: NSStringDrawingUsesLineFragmentOrigin
                                                             context: NULL].size.height;
        
        cellSize = CGSizeMake(kAnswerSummaryCellWidthIpad, answerBodyHeightIpad + kAnswerSummaryCellOwnerInfoHeight);
    }
    else
    {
        CGSize answerBodyConstraintSize = CGSizeMake(kAnswerSummaryCellWidth, 0.0);
        CGFloat answerBodyHeight = [answerBody boundingRectWithSize: answerBodyConstraintSize
                                                            options: NSStringDrawingUsesLineFragmentOrigin
                                                            context: NULL].size.height;
        
        cellSize = CGSizeMake(kAnswerSummaryCellWidth, answerBodyHeight + kAnswerSummaryCellOwnerInfoHeight);
    }
    
    return cellSize;
}

@end