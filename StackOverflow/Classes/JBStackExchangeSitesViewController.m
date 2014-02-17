//
//  JBStackExchangeSitesViewController.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeSitesViewController.h"
#import "JBStackExchangeSitesCollectionViewCell.h"
#import "JBStackExchangeSearchQuestionsViewController.h"
#import "JBStackExchangeLoginViewController.h"
#import "JBStackExchangeSiteItem.h"

NSString * const kJBStackExchangePushToQuestionsSegueIdentifier = @"kJBStackExchangePushToQuestionsSegueIdentifier";

@interface JBStackExchangeSitesViewController ()

@property (nonatomic, strong) NSArray *stackExchangeSites;

@end

@implementation JBStackExchangeSitesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self loadStackExchangeSites];
}

- (void)loadStackExchangeSites
{
    [[JBStackExchangeAPIManager shared] fetchStackExchangeSitesWithSuccess:^(JBStackExchangeResponse *responseObject)
     {
         self.stackExchangeSites = responseObject.items;
         [self.collectionView reloadData];
     }
                                                                   failure:^(NSError *error)
     {
         JBStackExchangeLoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier: kJBStackExchangeModalLoginViewControllerIdentifier];
         loginViewController.loginHandler = ^(BOOL loginSuccess)
         {
             if (loginSuccess)
             {
                 [self loadStackExchangeSites];
             }
             else
             {
                 [[[UIAlertView alloc] initWithTitle: @"Login Error" message: @"Unable to complete login process." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil] show];
             }
         };
         
         [self.navigationController presentViewController: loginViewController animated: YES completion: nil];
         
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
    return self.stackExchangeSites.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JBStackExchangeSitesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"JBStackExchangeSitesCollectionViewCell"
                                                                                             forIndexPath: indexPath];
    JBStackExchangeSiteItem *item = self.stackExchangeSites[indexPath.row];
    
    [[JBStackExchangeAPIManager shared] fetchImageWithURLString: item.siteLogoURL
                                                        success: ^(UIImage *image)
    {
        cell.siteLogoImageView.image = image;
    }
                                                        failure: ^(NSError *error)
     {
         NSLog(@"Failed to fetch site logo: %@", error);
     }];
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: kJBStackExchangePushToQuestionsSegueIdentifier])
    {
        NSIndexPath *indexPathOfSelectedCell = [self.collectionView indexPathForCell: sender];
        JBStackExchangeSearchQuestionsViewController *destination = [segue destinationViewController];
        destination.searchQuery.stackExchangeSite = self.stackExchangeSites[indexPathOfSelectedCell.row];
    }
}

@end