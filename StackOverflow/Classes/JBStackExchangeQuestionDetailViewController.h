//
//  JBStackExchangeQuestionDetailViewController.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBStackExchangeQuestion;

@interface JBStackExchangeQuestionDetailViewController : UICollectionViewController

@property (nonatomic, weak) JBStackExchangeQuestion *question;
@property (nonatomic, weak) JBStackExchangeAPIOptions *apiOptions;

@end
