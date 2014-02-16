//
//  JBSearchQuestionsViewController.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeSearchQuestionsViewController.h"
#import "JBStackExchangeQuestionDetailViewController.h"
#import "JBStackExchangeQuestionSummaryCollectionViewCell.h"
#import "JBStackExchangeLoadMoreCellsCollectionViewCell.h"
#import "JBStackExchangeLoginViewController.h"
#import "JBStackExchangeQuestion.h"

enum
{
    JBStackExchangeQuestionSummaryQuestionSection,
    JBStackExchangeQuestionSummaryLoadMoreQuestionsSection,
    JBStackExchangeQuestionSummaryNumberOfSections
};


NSString * const kJBStackExchangeModalLoginViewControllerIdentifier = @"JBStackExchangeLoginViewController";
NSString * const kJBStackExchangePushToQuestionDetailsSegueIdentifier = @"kJBStackExchangePushToQuestionDetailsSegueIdentifier";
NSString * const kJBStackExchangePresentFiltersModalSegueIdentifier = @"kJBStackExchangePresentFiltersModalSegueIdentifier";

@interface JBStackExchangeSearchQuestionsViewController () <UISearchBarDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) JBStackExchangeSearchQuery *searchQuery;

@property (nonatomic, strong) NSArray *stackExchangeQuestions;

@end

@implementation JBStackExchangeSearchQuestionsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        _searchQuery = [[JBStackExchangeSearchQuery alloc] init];
        _searchQuery.pageNumber = 1;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

- (void)loadStackExchangeQuestionsWithQuery:(JBStackExchangeSearchQuery *)query
{
    [[JBStackExchangeAPIManager shared] fetchStackExchangeQuestionsWithQuery: query
                                                                     success:^(JBStackExchangeResponse *responseObject)
     {
         self.stackExchangeQuestions = responseObject.items;
         [self.collectionView reloadData];
     }
                                                                     failure:^(NSError *error)
     {
         JBStackExchangeLoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier: kJBStackExchangeModalLoginViewControllerIdentifier];
         loginViewController.loginHandler = ^(BOOL loginSuccess)
         {
             if (loginSuccess)
             {
                 [self loadStackExchangeQuestionsWithQuery: query];
             }
             else
             {
                 [[[UIAlertView alloc] initWithTitle: @"Login Error" message: @"Unable to complete login process." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil] show];
             }
         };
         
         [self.navigationController presentViewController: loginViewController animated: YES completion: nil];
         
         NSLog(@"Failed to fetch questions: %@", error);
     }];
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger numberOfSections = JBStackExchangeQuestionSummaryNumberOfSections;
    
    if (!self.stackExchangeQuestions.count)
    {
        numberOfSections--;
    }
    
    return numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section)
    {
        case JBStackExchangeQuestionSummaryQuestionSection:
        {
            return self.stackExchangeQuestions.count;
        }
            break;
        case JBStackExchangeQuestionSummaryLoadMoreQuestionsSection:
        {
            return 1;
        }
            break;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case JBStackExchangeQuestionSummaryQuestionSection:
        {
            JBStackExchangeQuestionSummaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"JBStackExchangeQuestionSummaryCollectionViewCell"
                                                                                                               forIndexPath: indexPath];
            
            cell.question = self.stackExchangeQuestions[indexPath.row];
            
            return cell;
        }
            break;
        case JBStackExchangeQuestionSummaryLoadMoreQuestionsSection:
        {
            JBStackExchangeLoadMoreCellsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"JBStackExchangeLoadMoreCellsCollectionViewCell"
                                                                                                             forIndexPath: indexPath];
            return cell;
        }
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case JBStackExchangeQuestionSummaryQuestionSection:
        {
            return CGSizeMake(300, 200);
        }
            break;
        case JBStackExchangeQuestionSummaryLoadMoreQuestionsSection:
        {
            return CGSizeMake(300, 44);
        }
            break;
    }
    
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case JBStackExchangeQuestionSummaryQuestionSection:
        {
            return CGSizeMake(320, 44);
        }
            break;
    }
    
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqual:UICollectionElementKindSectionHeader])
    {
        switch (indexPath.section)
        {
            case JBStackExchangeQuestionSummaryQuestionSection:
            {
                return [self.collectionView dequeueReusableSupplementaryViewOfKind: kind
                                                               withReuseIdentifier: @"JBStackExchangeQuestionSummaryCollectionViewHeader"
                                                                      forIndexPath: indexPath];
            }
                break;
        }
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case JBStackExchangeQuestionSummaryQuestionSection:
        {
            [self performSegueWithIdentifier: kJBStackExchangePushToQuestionDetailsSegueIdentifier
                                      sender: self];
        }
            break;
        case JBStackExchangeQuestionSummaryLoadMoreQuestionsSection:
        {
            self.searchQuery.pageNumber += 1;
            [self loadStackExchangeQuestionsWithQuery: self.searchQuery];
        }
            break;
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchQuery.inTitleQuery = searchBar.text;
    self.searchQuery.pageNumber = 1;
    
    [self loadStackExchangeQuestionsWithQuery: self.searchQuery];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: kJBStackExchangePushToQuestionDetailsSegueIdentifier])
    {
        NSIndexPath *indexPathOfSelectedCell = [self.collectionView indexPathForCell: sender];
        JBStackExchangeQuestion *question = self.stackExchangeQuestions[indexPathOfSelectedCell.row];
        
        JBStackExchangeQuestionDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.question = question;
    }
    else if ([segue.identifier isEqualToString: kJBStackExchangePresentFiltersModalSegueIdentifier])
    {
        
    }
}

@end
