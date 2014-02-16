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
#import "JBStackExchangeQuestion.h"
#import "JBStackExchangeAnswer.h"

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
                    cell.questionTitleLabel.text = self.question.questionTitle;
                    [cell.questionBodyWebView loadHTMLString: self.question.questionBodyHTML
                                                     baseURL: nil];
                    
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
            return CGSizeMake(300, 400);
        }
            break;
        case JBStackExchangeQuestionDetailsSectionOwner:
        {
            return CGSizeMake(300, 110);
        }
            break;
        case JBStackExchangeQuestionDetailsSectionAnswers:
        {
            return CGSizeMake(300, 400);
        }
            break;
    }
    
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
//    if ([kind isEqual:UICollectionElementKindSectionHeader])
//    {
//        return [self.collectionView dequeueReusableSupplementaryViewOfKind: kind
//                                                       withReuseIdentifier: @"JBStackExchangeQuestionSummaryCollectionViewHeader"
//                                                              forIndexPath: indexPath];
//    }
    
    return nil;
}

@end
