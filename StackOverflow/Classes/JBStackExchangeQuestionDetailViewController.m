//
//  JBStackExchangeQuestionDetailViewController.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeQuestionDetailViewController.h"
#import "JBStackExchangeQuestionDetailCollectionViewCell.h"
#import "JBStackExchangeQuestion.h"

@interface JBStackExchangeQuestionDetailViewController ()

@end

@implementation JBStackExchangeQuestionDetailViewController

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
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
