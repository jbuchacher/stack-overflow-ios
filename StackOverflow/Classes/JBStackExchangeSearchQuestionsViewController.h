//
//  JBSearchQuestionsViewController.h
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBStackExchangeAPIOptions.h"

extern NSString * const kJBStackExchangeModalLoginViewControllerIdentifier;

@interface JBStackExchangeSearchQuestionsViewController : UICollectionViewController

@property (nonatomic, strong, readonly) JBStackExchangeSearchQuery *searchQuery;

@end