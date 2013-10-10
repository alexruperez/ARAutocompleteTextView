
# ARAutocompleteTextView


## Overview

ARAutocompleteTextView is a subclass of UITextView that automatically displays text suggestions in real-time.  This is perfect for automatically suggesting the domain as a user types an email address, #hashtag or @handle.

# Usage

## Installation

### Add the following files to your project:
* `ARAutocompleteTextView.m`
* `ARAutocompleteTextView.h`
* `ARAutocompleteManager.m`
* `ARAutocompleteManager.h`

## Quickstart Guide

Create an `ARAutocompleteTextView` instance exactly as as you would `UITextView`.  You can do eith either programmitcally or in Interface Builder.  Programmatically, this looks like:

    ARAutocompleteTextView* textField = [[ARAutocompleteTextView alloc] initWithFrame:CGRectMake(0,0,100,31)];

The data source is the brains of the autocomplete logic.  If you just want to autocomplete email addresses, #hashtags or @handles, use `ARAutocompleteManager` from the example project as follows:

    textField.autocompleteDataSource = [ARAutocompleteManager sharedManager];
    textField.autocompleteType = ARAutocompleteTypeEmail;

## Customization

### Autocompletion Data Source

`ARAutocompleteManager` (included in the example project) provides email address autocompletion out of the box.  It comes with a list of the top email domains.  You may want to tailor this list of email domains to match your own customers, or you may want to write autocomplete logic for a different type of text view (in the demo, names of colors are autocompleted).

Alternatively, you may wish to create your own data source class and user the `autocompleteType` property to differentiate between textviews with different data types.  A `ARAutocompleteTextView`'s data source must implement the following method, as part of the `ARAutocompleteDataSource` protocol.

    - (NSString *)textField:(ARAutocompleteTextView*)textField completionForPrefix:(NSString *)prefix

You may also set a default `dataSource` for all instances of `ARAutocompleteTextView`.  In the example project, we use a `ARAutocompleteManager` singleton:

     [autocompleteTextOffset setDefaultAutocompleteDataSource:[ARAutocompleteManager sharedManager]];

### Positioning and Formatting

To adjust the position of the autocomplete label by a fixed amount, set `autocompleteTextOffset`:

    textField.autocompleteTextOffset = CGPointMake(10.0, 10.0);

For more dynamic positioning of the autocomplete label, subclass `ARAutocompleteTextView` and override `- (CGRect)autocompleteRectForBounds:(CGRect)bounds`.

To adjust the properties (i.e. `font`, `textColor`) of the autocomplete label, do so via the `[AutocompleteTextField autocompleteLabel] property.

    textField.autocompleteLabel.textColor = [UIColor grayColor];

## Event Listening

In addition to observing the standard `UITextView` notifications (i.e. `UITextViewTextDidChangeNotification` and friends), you can use `[ARAutocompleteTextView autoCompleteTextFieldDelegate]` to listen for certain events.  This is particularly useful if you are collecting analytics.

Be careful setting the delegate, internally implements the method `- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text` to avoid replacing "double space" by "space with dot" in iOS7.

# Etc.

* Use this in your apps whenever you can, particularly email addresses -- your users will appreciate it!
* Ready to work with [alexruperez/STTweetLabel](https://github.com/alexruperez/STTweetLabel).
* Contributions are very welcome.
* Attribution is appreciated (let's spread the word!), but not mandatory.

## Use it? Love/hate it?

Tweet the author @alexruperez, and check out alexruperez's blog: http://alexruperez.com
