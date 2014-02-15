//
//  JBStackExchangeQuestionDetailCollectionViewCell.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBStackExchangeQuestionDetailCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *questionTitleLabel;
@property (nonatomic, weak) IBOutlet UIWebView *questionBodyWebView;

@end