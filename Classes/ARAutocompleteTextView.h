//
//  ARAutocompleteTextView.h
//  alexruperez
//
//  Created by Alejandro Rupérez on 11/29/12.
//  Inspired by DOautocompleteTextView by DoAT.
//
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ARAutocompleteTextView;

@protocol ARAutocompleteDataSource <NSObject>

- (NSString*)textView:(ARAutocompleteTextView*)textView
   completionForPrefix:(NSString*)prefix
            ignoreCase:(BOOL)ignoreCase;

@end

@protocol ARAutocompleteTextViewDelegate <NSObject>

@optional
- (void)autoCompleteTextViewDidAutoComplete:(ARAutocompleteTextView *)autoCompleteField;
- (void)autoCompleteTextView:(ARAutocompleteTextView *)autocompleteTextView didChangeAutocompleteText:(NSString *)autocompleteText;

@end

@interface ARAutocompleteTextView : UITextView <UITextViewDelegate>

/*
 * Designated programmatic initializer (also compatible with Interface Builder)
 */
- (id)initWithFrame:(CGRect)frame;

/*
 * Autocomplete behavior
 */
@property (nonatomic, assign) NSUInteger autocompleteType; // Can be used by the dataSource to provide different types of autocomplete behavior
@property (nonatomic, assign) BOOL autocompleteDisabled;
@property (nonatomic, assign) BOOL ignoreCase;
@property (nonatomic, assign) id<ARAutocompleteTextViewDelegate> autoCompleteTextViewDelegate;

/*
 * Configure text field appearance
 */
@property (nonatomic, strong) UILabel *autocompleteLabel;
- (void)setFont:(UIFont *)font;
@property (nonatomic, assign) CGPoint autocompleteTextOffset;

/*
 * Specify a data source responsible for determining autocomplete text.
 */
@property (nonatomic, assign) id<ARAutocompleteDataSource> autocompleteDataSource;
+ (void)setDefaultAutocompleteDataSource:(id<ARAutocompleteDataSource>)dataSource;

/*
 * Subclassing:
 */
- (CGRect)autocompleteRectForBounds:(CGRect)bounds; // Override to alter the position of the autocomplete text
- (void)setupAutocompleteTextView; // Override to perform setup tasks.  Don't forget to call super.

/*
 * Refresh the autocomplete text manually (useful if you want the text to change while the user isn't editing the text)
 */
- (void)forceRefreshAutocompleteText;

@end