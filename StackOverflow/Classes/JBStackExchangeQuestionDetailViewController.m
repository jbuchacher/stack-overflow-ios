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

@interface JBStackExchangeQuestionDetailViewController ()

@end

@implementation JBStackExchangeQuestionDetailViewController

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger numberOfSections = 0;
    
    if (self.question)
    {
        numberOfSections += 2; // One for question, one for owner.
    }
    
    if (self.question.questionAnswers.count)
    {
        numberOfSections++;
    }
    
    return numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
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
        case 0:
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
        case 1:
        {
            JBStackExchangeQuestionOwnerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"JBStackExchangeQuestionOwnerCollectionViewCell"
                                                                                                             forIndexPath: indexPath];
            cell.itemOwner = self.question.questionOwner;
            
            return cell;
        }
            break;
        case 2:
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
