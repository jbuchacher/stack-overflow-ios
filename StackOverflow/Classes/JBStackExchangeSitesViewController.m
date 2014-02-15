//
//  JBStackExchangeSitesViewController.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/14/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeSitesViewController.h"
#import "JBStackExchangeSitesCollectionViewCell.h"
#import "JBStackExchangeSiteItem.h"
#import "JBStackExchangeSearchQuestionsViewController.h"

NSString * const kJBStackExchangePushToQuestionsSegueIdentifier = @"kJBStackExchangePushToQuestionsSegueIdentifier";

@interface JBStackExchangeSitesViewController ()

@property (nonatomic, strong) NSArray *stackExchangeSites;
@property (nonatomic, strong) JBStackExchangeAPIOptions *apiOptions;

@end

@implementation JBStackExchangeSitesViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        _apiOptions = [[JBStackExchangeAPIOptions alloc] init];
    }
    
    return self;
}

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
    [[JBStackExchangeAPIManager shared] fetchStackExchangeSitesWithOptions: nil
                                                                   success:^(JBStackExchangeResponse *responseObject)
     {
         self.stackExchangeSites = responseObject.items;
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
        JBStackExchangeSiteItem *item = self.stackExchangeSites[indexPathOfSelectedCell.row];
        self.apiOptions.siteParameter = item.siteAPIParameter;
        
        JBStackExchangeSearchQuestionsViewController *searchViewController = [segue destinationViewController];
        searchViewController.apiOptions = self.apiOptions;
    }
}

@end