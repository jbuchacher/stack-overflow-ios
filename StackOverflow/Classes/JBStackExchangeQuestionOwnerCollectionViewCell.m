//
//  JBStackExchangeQuestionOwnerCollectionViewCell.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuestionOwnerCollectionViewCell.h"
#import "JBStackExchangeItemOwner.h"

@interface JBStackExchangeQuestionOwnerCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *reputationGoldLabel;
@property (nonatomic, weak) IBOutlet UIImageView *reputationGoldImageView;

@property (nonatomic, weak) IBOutlet UILabel *reputationSilverLabel;
@property (nonatomic, weak) IBOutlet UIImageView *reputationSilverImageView;

@property (nonatomic, weak) IBOutlet UILabel *reputationBronzeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *reputationBronzeImageView;

@property (nonatomic, weak) IBOutlet UILabel *ownerNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *ownerAvatarImageView;

@end

@implementation JBStackExchangeQuestionOwnerCollectionViewCell


- (void)setItemOwner:(JBStackExchangeItemOwner *)itemOwner
{
    _itemOwner = itemOwner;
    
    _ownerNameLabel.text = itemOwner.ownerName;
}

@end