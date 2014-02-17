//
//  JBStackExchangeQuestionOwnerCollectionViewCell.h
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JBStackExchangeItemOwner;

@interface JBStackExchangeQuestionOwnerCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *ownerAvatarImageView;

@property (nonatomic, strong) JBStackExchangeItemOwner *itemOwner;

@end