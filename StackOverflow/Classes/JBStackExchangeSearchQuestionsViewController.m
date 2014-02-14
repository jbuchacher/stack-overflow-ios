//
//  JBSearchQuestionsViewController.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeSearchQuestionsViewController.h"
#import "JBStackExchangeQuestionSummaryCollectionViewCell.h"
#import "JBStackExchangeQuestion.h"

@interface JBStackExchangeSearchQuestionsViewController ()

@property (nonatomic, strong) NSArray *stackExchangeQuestions;

@end

@implementation JBStackExchangeSearchQuestionsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self loadStackExchangeQuestions];
}

- (void)loadStackExchangeQuestions
{
    self.apiOptions.inTitleQuery = @"Objective-c";
    [[JBStackExchangeAPIManager shared] fetchStackExchangeQuestionsWithOptions: self.apiOptions
                                                                       success:^(JBStackExchangeResponse *responseObject)
     {
         self.stackExchangeQuestions = responseObject.items;
         [self.collectionView reloadData];
     }
                                                                       failure:^(NSError *error)
     {
         NSLog(@"Failed to fetch sites: %@", error);
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
    
    JBStackExchangeQuestion *question = self.stackExchangeQuestions[indexPath.row];

    cell.questionTitleLabel.text = question.questionTitle;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString: kJBStackExchangePushToQuestionsSegueIdentifier])
//    {
//        NSIndexPath *indexPathOfSelectedCell = [self.collectionView indexPathForCell: sender];
//        JBStackExchangeSiteItem *item = self.stackExchangeSites[indexPathOfSelectedCell.row];
//        
//        JBStackExchangeAPIOptions *apiOptions = [[JBStackExchangeAPIManager shared] apiOptions];
//        apiOptions.siteParameter = item.siteAPIParameter;
//    }
}

@end
