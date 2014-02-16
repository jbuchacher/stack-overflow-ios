//
//  JBStackExchangeLoadMoreCellsCollectionViewCell.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeLoadMoreCellsCollectionViewCell.h"

@interface JBStackExchangeLoadMoreCellsCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation JBStackExchangeLoadMoreCellsCollectionViewCell

- (void)setLoadingMoreResults:(BOOL)loading
{
    loading ? [self.activityIndicator startAnimating] : [self.activityIndicator stopAnimating];
}

@end
