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
    }
    else
    {
        self.answerBodyLabel.text = @"";
        self.answerOwnerNameLabel.text = @"";
    }
}

+ (CGSize)cellSizeWithAnswer:(JBStackExchangeAnswerItem *)answer
                      isIpad:(BOOL)isIpad
{
    if (isIpad)
    {
        return CGSizeMake(600, 200);
    }
    
    return CGSizeMake(280, 400);
}

@end