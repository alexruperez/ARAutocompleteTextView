//
//  ARSampleFieldsTableViewController.h
//  ARTextViewAutocompletionExample
//
//  Created by Alejandro Rupérez on 12/26/12.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARAutocompleteTextView.h"
#import "AREmailAutocompleteTextView.h"
#import "ARTwitterAutocompleteTextView.h"

@interface ARSampleFieldsTableViewController : UITableViewController <UITextViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet AREmailAutocompleteTextView *emailTextView;
@property (unsafe_unretained, nonatomic) IBOutlet ARTwitterAutocompleteTextView *allTextView;

@end
