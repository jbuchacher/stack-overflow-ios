//
//  JBStackExchangeSitesCollectionViewCell.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeSitesCollectionViewCell.h"

@implementation JBStackExchangeSitesCollectionViewCell

- (void)prepareForReuse
{
    self.siteLogoImageView.image = nil;
}

@end
