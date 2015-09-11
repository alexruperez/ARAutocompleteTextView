//
//  AREmailAutocompleteTextView.h
//  ARTextViewAutocompletionExample
//
//  Created by Alejandro Rupérez on 2/27/13.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import "ARAutocompleteTextView.h"

@interface AREmailAutocompleteTextView : ARAutocompleteTextView <ARAutocompleteDataSource>

@property (nonatomic, copy) NSArray *emailDomains; // modify to use your own custom list of email domains

@end
