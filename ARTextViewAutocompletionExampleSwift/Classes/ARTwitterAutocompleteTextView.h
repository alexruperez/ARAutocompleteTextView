//
//  ARTwitterAutocompleteTextView.h
//  ARTextViewAutocompletionExample
//
//  Created by Alejandro Rupérez on 2/27/13.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import "ARAutocompleteTextView.h"

@interface ARTwitterAutocompleteTextView : ARAutocompleteTextView <ARAutocompleteDataSource>

@property (nonatomic, copy) NSArray *autocomplete; // modify to use your own custom list

@end
