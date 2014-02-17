//
//  JBStackExchangeFilterQuestionsViewController.m
//  StackOverflow
//
//  Created by Joshua Buchacher on 2/15/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBStackExchangeFilterQuestionsViewController.h"
#import "JBStackExchangeFilterItemTableViewCell.h"

NSString * const kStackExchangeFilterItemCollectionViewReuseIdentifier = @"kStackExchangeFilterItemCollectionViewReuseIdentifier";

@interface JBStackExchangeFilterQuestionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) JBStackExchangeFilterOptions *filters;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation JBStackExchangeFilterQuestionsViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JBStackExchangeFilterItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: kStackExchangeFilterItemCollectionViewReuseIdentifier
                                                                                        forIndexPath: indexPath];
    
    return cell;
}

- (IBAction)saveFilters
{
    if (self.filtersUpdated)
    {
        self.filtersUpdated(self.filters);
    }
    
    [self dismiss];
}

- (IBAction)dismiss
{
    if (self.parentPopoverController)
    {
        [self.parentPopoverController dismissPopoverAnimated: YES];
    }
    else
    {
        [self.presentingViewController dismissViewControllerAnimated: YES
                                                          completion: nil];
    }
}

@end