//
//  JBStackExchangeAnswerSummaryCollectionViewCell.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBStackExchangeAnswer;

@interface JBStackExchangeAnswerSummaryCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) JBStackExchangeAnswer *answer;

@end
