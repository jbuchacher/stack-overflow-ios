//
//  JBViewController.m
//  StackOverflow
//
//  Created by Josh Buchacher on 2/12/14.
//  Copyright (c) 2014 Josh Buchacher. All rights reserved.
//

#import "JBViewController.h"
#import "JBStackOverflowAPIManager.h"

@interface JBViewController ()

@end

@implementation JBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fetchSites:(id)sender
{
    [[JBStackOverflowAPIManager shared] fetchStackExchangeSitesWithSuccess:^(JBStackExchangeResponse *responseObject)
    {
        
    }
                                                                   failure:^(NSError *error)
    {
    
    }];
}

@end
