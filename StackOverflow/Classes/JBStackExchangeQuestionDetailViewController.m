//
//  JBStackExchangeQuestionDetailViewController.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuestionDetailViewController.h"
#import "JBStackExchangeQuestionDetailCollectionViewCell.h"
#import "JBStackExchangeQuestionOwnerCollectionViewCell.h"
#import "JBStackExchangeAnswerSummaryCollectionViewCell.h"
#import "JBStackExchangeQuestionItem.h"
#import "JBStackExchangeAnswerItem.h"

enum
{
    JBStackExchangeQuestionDetailsSectionQuestion,
    JBStackExchangeQuestionDetailsSectionOwner,
    JBStackExchangeQuestionDetailsSectionAnswers,
    JBStackExchangeQuestionDetailsNumberOfSections
};

@interface JBStackExchangeQuestionDetailViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation JBStackExchangeQuestionDetailViewController

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger numberOfSections = JBStackExchangeQuestionDetailsNumberOfSections;
    
    if (!self.question)
    {
        numberOfSections -= 2; // One for question, one for owner.
    }
    
    if (!self.question.questionAnswers.count)
    {
        numberOfSections--;
    }
    
    return numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section)
    {
        case JBStackExchangeQuestionDetailsSectionQuestion:
        {
            return 1;
        }
            break;
        case JBStackExchangeQuestionDetailsSectionOwner:
        {
            return 1;
        }
            break;
        case JBStackExchangeQuestionDetailsSectionAnswers:
        {
            return self.question.questionAnswers.count;
        }
            break;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case JBStackExchangeQuestionDetailsSectionQuestion:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    JBStackExchangeQuestionDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"JBStackExchangeQuestionDetailCollectionViewCell"
                                                                                                                      forIndexPath: indexPath];
                    cell.question = self.question;
                    
                    return cell;
                }
                    
                break;
            }
            
            break;
        }
        case JBStackExchangeQuestionDetailsSectionOwner:
        {
            JBStackExchangeQuestionOwnerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"JBStackExchangeQuestionOwnerCollectionViewCell"
                                                                                                             forIndexPath: indexPath];
            cell.itemOwner = self.question.questionOwner;
            
            [[JBStackExchangeAPIManager shared] fetchImageWithURLString: self.question.questionOwner.ownerAvatarURLString
                                                                success: ^(UIImage *image)
             {
                 cell.ownerAvatarImageView.image = image;
             }
                                                                failure: ^(NSError *error)
             {
                 NSLog(@"Failed to fetch site logo: %@", error);
             }];
            
            return cell;
        }
            break;
        case JBStackExchangeQuestionDetailsSectionAnswers:
        {
            JBStackExchangeAnswerSummaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"JBStackExchangeAnswerSummaryCollectionViewCell"
                                                                                                              forIndexPath: indexPath];
            cell.answer = self.question.questionAnswers[indexPath.row];
            
            return cell;
        }
            break;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case JBStackExchangeQuestionDetailsSectionQuestion:
        {
            JBStackExchangeQuestionItem *question = self.question;
            
            return [JBStackExchangeQuestionDetailCollectionViewCell cellSizeWithQuestion: question
                                                                                  isIpad: (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)];
        }
            break;
        case JBStackExchangeQuestionDetailsSectionOwner:
        {
            JBStackExchangeItemOwner *owner = self.question.questionOwner;
            
            return [JBStackExchangeQuestionOwnerCollectionViewCell cellSizeWithItemOwner: owner
                                                                                  isIpad: (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)];
        }
            break;
        case JBStackExchangeQuestionDetailsSectionAnswers:
        {
            JBStackExchangeAnswerItem *answer = self.question.questionAnswers[indexPath.row];
            
            return [JBStackExchangeAnswerSummaryCollectionViewCell cellSizeWithAnswer: answer
                                                                               isIpad: (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)];
        }
            break;
    }
    
    return CGSizeZero;
}

@end