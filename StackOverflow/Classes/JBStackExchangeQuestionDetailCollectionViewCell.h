//
//  JBStackExchangeQuestionDetailCollectionViewCell.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBStackExchangeQuestionItem;

@interface JBStackExchangeQuestionDetailCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) JBStackExchangeQuestionItem *question;

+ (CGFloat)cellHeightWithQuestion:(JBStackExchangeQuestionItem *)question;

@end