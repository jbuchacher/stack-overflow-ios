//
//  JBQuestionSummaryCollectionViewCell.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBStackExchangeQuestionItem;

@interface JBStackExchangeQuestionSummaryCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) JBStackExchangeQuestionItem *question;

+ (CGFloat)cellHeightWithQuestion:(JBStackExchangeQuestionItem *)question;

@end