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
#import "JBStackExchangeQuestionSummaryHeader.h"
#import "JBStackExchangeLoginViewController.h"
#import "JBStackExchangeFilterQuestionsViewController.h"
#import "JBStackExchangeQuestionItem.h"

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

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) JBStackExchangeSearchQuery *searchQuery;
@property (nonatomic, assign) BOOL canLoadMoreItems;
@property (nonatomic, strong) NSArray *stackExchangeQuestions;

@end

@implementation JBStackExchangeSearchQuestionsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        _searchQuery = [[JBStackExchangeSearchQuery alloc] init];
        _searchQuery.pageNumber = 1;
        
        _canLoadMoreItems = NO;
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
         self.canLoadMoreItems = responseObject.hasMoreItems;

         [self fetchedQuestions: responseObject.items];
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

- (void)fetchedQuestions:(NSArray *)questions
{
    // If I were ever to merge another response, I would move this logic somewhere more appropriate
    // for automagically merging sequential response items'. 
    if (self.searchQuery.pageNumber > 1)
    {
        NSArray *mergedQuestions = [self.stackExchangeQuestions arrayByAddingObjectsFromArray: questions];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity: questions.count];
        for (JBStackExchangeQuestionItem *question in questions)
        {
            [indexPaths addObject: [NSIndexPath indexPathForItem: [mergedQuestions indexOfObject: question]
                                                      inSection: 0]];
        }
        
        self.stackExchangeQuestions = mergedQuestions;
        [self.collectionView insertItemsAtIndexPaths: indexPaths];
    }
    else
    {
        self.stackExchangeQuestions = questions;
        [self.collectionView reloadData];
    }
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
            return self.canLoadMoreItems ? 1 : 0;
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
            JBStackExchangeQuestionItem *question = self.stackExchangeQuestions[indexPath.row];

            return [JBStackExchangeQuestionSummaryCollectionViewCell cellSizeWithQuestion: question
                                                                                   isIpad: (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)];
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
                JBStackExchangeQuestionSummaryHeader *header = [self.collectionView dequeueReusableSupplementaryViewOfKind: kind
                                                                                                       withReuseIdentifier: @"JBStackExchangeQuestionSummaryHeader"
                                                                                                              forIndexPath: indexPath];
                header.searchBar.placeholder = [NSString stringWithFormat: @"Search %@", self.searchQuery.stackExchangeSite.siteName];
                return header;
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
        JBStackExchangeQuestionItem *question = self.stackExchangeQuestions[indexPathOfSelectedCell.row];
        
        JBStackExchangeQuestionDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.question = question;
    }
    else if ([segue.identifier isEqualToString: kJBStackExchangePresentFiltersModalSegueIdentifier])
    {
        if ([segue isKindOfClass: [UIStoryboardPopoverSegue class]])
        {
            JBStackExchangeFilterQuestionsViewController *destination = [segue destinationViewController];
            destination.parentPopoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        }
    }
}

@end
