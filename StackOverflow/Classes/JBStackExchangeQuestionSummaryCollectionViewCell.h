//
//  JBQuestionSummaryCollectionViewCell.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBStackExchangeQuestion;

@interface JBStackExchangeQuestionSummaryCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) JBStackExchangeQuestion *question;

@end