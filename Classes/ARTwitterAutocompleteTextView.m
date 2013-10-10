//
//  ARTwitterAutocompleteTextView.m
//  ARTextViewAutocompletionExample
//
//  Created by Alejandro Rupérez on 2/27/13.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import "ARTwitterAutocompleteTextView.h"

@implementation ARTwitterAutocompleteTextView

- (void)setupAutocompleteTextView
{
    [super setupAutocompleteTextView];
    
    // Default list to suggest
    self.autocomplete = @[ @"@alexruperez", @"@gigigoapps", @"@GigigoMexico", @"@KimberlySunster", @"@sbaro_gigigo", @"@davidr_79", @"#alexruperez", @"#gigigo", @"#google", @"#facebook", @"#twitter", @"#hashtag" ];
    
    self.autocompleteDataSource = self;
}

#pragma mark - ARAutocompleteDataSource

- (NSString *)textView:(ARAutocompleteTextView *)textView completionForPrefix:(NSString *)prefix ignoreCase:(BOOL)ignoreCase
{
    // Check that text field contains an @ or #
    NSString *contains = @"@";
    NSRange atSignRange = [prefix rangeOfString:@"@" options:NSBackwardsSearch];
    NSRange atSignRange2 = [prefix rangeOfString:@"#" options:NSBackwardsSearch];
    
    if ((atSignRange.location == NSNotFound) && (atSignRange2.location == NSNotFound)) {
        return @"";
    }
    
    if ((atSignRange.location == NSNotFound) || (((atSignRange.location != NSNotFound) && (atSignRange2.location != NSNotFound)) && (atSignRange2.location > atSignRange.location))) {
        atSignRange = atSignRange2;
        contains = @"#";
    }
    
    NSArray *textComponents = [prefix componentsSeparatedByString:contains];

    if ([textComponents count] > 1)
    {
        NSString *lastText = [[textComponents lastObject] stringByReplacingOccurrencesOfString:@" " withString:@""];
        // Use the first in the list by default
        if ([lastText length] == 0)
        {
            for (NSString *stringFromReference in self.autocomplete)
            {
                if ([stringFromReference hasPrefix:contains])
                {
                    return [stringFromReference stringByReplacingOccurrencesOfString:contains withString:@""];
                }
            }
        }
        
        NSString *stringToLookFor = lastText;
        if (ignoreCase)
        {
            stringToLookFor = [stringToLookFor lowercaseString];
        }
        
        for (NSString *stringFromReference in self.autocomplete)
        {
            NSString *stringToCompare = [stringFromReference stringByReplacingOccurrencesOfString:contains withString:@""];
            if (ignoreCase)
            {
                stringToCompare = [stringToCompare lowercaseString];
            }
            
            if ([stringToCompare hasPrefix:stringToLookFor])
            {
                NSRange range = [stringToCompare rangeOfString:stringToLookFor];
                range.length++;
                return [stringFromReference stringByReplacingCharactersInRange:range withString:@""];
            }
            
        }
    }
    
    return @"";
    
}

@end
