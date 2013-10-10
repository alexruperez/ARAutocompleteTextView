//
//  ARSampleFieldsTableViewController.m
//  ARTextViewAutocompletionExample
//
//  Created by Alejandro Rupérez on 12/26/12.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import "ARSampleFieldsTableViewController.h"
#import "ARAutocompleteManager.h"

@interface ARSampleFieldsTableViewController ()

@end

@implementation ARSampleFieldsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set a default data source for all ARAutocompleteTextView instances. Otherwise, you can specify the data source on individual text fields via the autocompleteDataSource property or use my default AREmailAutocompleteTextView and ARTwitterAutocompleteTextView like in this sample
    [ARAutocompleteTextView setDefaultAutocompleteDataSource:[ARAutocompleteManager sharedManager]];
    
    // Dismiss the keyboard when the user taps outside of a text field
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.emailTextView resignFirstResponder];
    [self.allTextView resignFirstResponder];
}

@end
