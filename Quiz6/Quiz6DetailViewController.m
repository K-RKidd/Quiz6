//
//  Quiz6DetailViewController.m
//  Quiz6
//
//  Created by Krystle on 3/28/14.
//  Copyright (c) 2014 Krystle Kidd. All rights reserved.
//

#import "Quiz6DetailViewController.h"

@interface Quiz6DetailViewController ()
- (void)configureView;
@end

@implementation Quiz6DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
