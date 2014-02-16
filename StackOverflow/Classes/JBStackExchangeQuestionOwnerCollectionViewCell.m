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

@property (nonatomic, weak) IBOutlet UILabel *badgeGoldLabel;
@property (nonatomic, weak) IBOutlet UIImageView *badgeGoldImageView;

@property (nonatomic, weak) IBOutlet UILabel *badgeSilverLabel;
@property (nonatomic, weak) IBOutlet UIImageView *badgeSilverImageView;

@property (nonatomic, weak) IBOutlet UILabel *badgeBronzeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *badgeBronzeImageView;

@property (nonatomic, weak) IBOutlet UILabel *ownerNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *ownerAvatarImageView;

@end

@implementation JBStackExchangeQuestionOwnerCollectionViewCell


- (void)setItemOwner:(JBStackExchangeItemOwner *)itemOwner
{
    _itemOwner = itemOwner;
    
    if (itemOwner)
    {
        self.ownerNameLabel.text = itemOwner.ownerName;
    }
    else
    {
        self.ownerNameLabel.text = @"";
    }
    
    // -updateBadgeLabel:andBadgeImageView:withBadge handles hiding the views if badges are nil.
    [self updateBadgeLabel: self.badgeGoldLabel
         andBadgeImageView: self.badgeGoldImageView
                 withBadge: itemOwner.ownerBadges.goldBadges];
    
    [self updateBadgeLabel: self.badgeSilverLabel
         andBadgeImageView: self.badgeSilverImageView
                 withBadge: itemOwner.ownerBadges.silverBadges];
    
    [self updateBadgeLabel: self.badgeBronzeLabel
         andBadgeImageView: self.badgeBronzeImageView
                 withBadge: itemOwner.ownerBadges.bronzeBadges];
}

- (void)updateBadgeLabel:(UILabel *)label andBadgeImageView:(UIImageView *)imageView withBadge:(NSInteger)badge
{
    label.text = badge ? [NSString stringWithFormat: @"%ld", badge] : @"";
    BOOL hideBadges = badge == 0;
    label.hidden = hideBadges;
    imageView.hidden = hideBadges;
}

@end