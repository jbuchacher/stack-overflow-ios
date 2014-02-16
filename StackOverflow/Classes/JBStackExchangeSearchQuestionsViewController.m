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
#import "JBStackExchangeQuestion.h"

NSString * const kJBStackExchangeModalLoginSegueIdentifier = @"kJBStackExchangeModalLoginSegueIdentifier";
NSString * const kJBStackExchangePushToQuestionDetailsSegueIdentifier = @"kJBStackExchangePushToQuestionDetailsSegueIdentifier";
NSString * const kJBStackExchangePresentFiltersModalSegueIdentifier = @"kJBStackExchangePresentFiltersModalSegueIdentifier";

@interface JBStackExchangeSearchQuestionsViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *stackExchangeQuestions;

@end

@implementation JBStackExchangeSearchQuestionsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
}

- (void)loadStackExchangeQuestionsWithSearchText:(NSString *)searchText
{
    JBStackExchangeSearchQuery *query = [[JBStackExchangeSearchQuery alloc] init];
    query.inTitleQuery = searchText;
    
    [[JBStackExchangeAPIManager shared] fetchStackExchangeQuestionsWithQuery: query
                                                                     success:^(JBStackExchangeResponse *responseObject)
     {
         self.stackExchangeQuestions = responseObject.items;
         [self.collectionView reloadData];
     }
                                                                     failure:^(NSError *error)
     {
         [self.navigationController performSegueWithIdentifier: @"kJBStackExchangeModalLoginSegueIdentifier" sender: self];
         
         NSLog(@"Failed to fetch questions: %@", error);
     }];
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.stackExchangeQuestions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JBStackExchangeQuestionSummaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"JBStackExchangeQuestionSummaryCollectionViewCell"
                                                                                             forIndexPath: indexPath];
    
    cell.question = self.stackExchangeQuestions[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JBStackExchangeQuestion *question = self.stackExchangeQuestions[indexPath.row];
    return CGSizeMake(290.0, [JBStackExchangeQuestionSummaryCollectionViewCell cellHeightWithQuestion: question]);;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqual:UICollectionElementKindSectionHeader])
    {
        return [self.collectionView dequeueReusableSupplementaryViewOfKind: kind
                                                       withReuseIdentifier: @"JBStackExchangeQuestionSummaryCollectionViewHeader"
                                                              forIndexPath: indexPath];
    }
    
    return nil;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self loadStackExchangeQuestionsWithSearchText: searchBar.text];
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
