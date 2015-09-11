
# ARAutocompleteTextView
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/alexruperez/ARAutocompleteTextView?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Twitter](http://img.shields.io/badge/contact-@alexruperez-blue.svg?style=flat)](http://twitter.com/alexruperez)
[![GitHub Issues](http://img.shields.io/github/issues/alexruperez/ARAutocompleteTextView.svg?style=flat)](http://github.com/alexruperez/ARAutocompleteTextView/issues)
[![Version Status](http://img.shields.io/cocoapods/v/ARAutocompleteTextView.svg?style=flat)](http://cocoadocs.org/docsets/ARAutocompleteTextView)
[![License Status](http://img.shields.io/cocoapods/l/ARAutocompleteTextView.svg?style=flat)](http://cocoadocs.org/docsets/ARAutocompleteTextView)
[![Platform Status](http://img.shields.io/cocoapods/p/ARAutocompleteTextView.svg?style=flat)](http://cocoadocs.org/docsets/ARAutocompleteTextView)
[![Pod Status](http://img.shields.io/cocoapods/v/ARAutocompleteTextView.svg?style=flat)](https://github.com/CocoaPods/Specs/blob/master/Specs/ARAutocompleteTextView/0.0.1/ARAutocompleteTextView.podspec.json)
[![Analytics](https://ga-beacon.appspot.com/UA-55329295-1/ARAutocompleteTextView/readme?pixel)](https://github.com/igrigorik/ga-beacon)

## Overview

ARAutocompleteTextView is a subclass of UITextView that automatically displays text suggestions in real-time.  This is perfect for automatically suggesting the domain as a user types an email address, #hashtag or @handle.

<img src="https://raw.github.com/alexruperez/ARAutocompleteTextView/master/ARTextViewAutocompletion.png" alt="ARTextViewAutocompletion" title="ARAutocompleteTextView" style="display:block; margin: 10px auto 30px auto; align:center">

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

# Etc.

* Use this in your apps whenever you can, particularly email addresses -- your users will appreciate it!
* Contributions are very welcome.
* Attribution is appreciated (let's spread the word!), but not mandatory.

## Use it? Love/hate it?

Tweet the author @alexruperez, and check out alexruperez's blog: http://alexruperez.com

## Other Links

[code4app Review](http://code4app.net/ios/ARAutocompleteTextView/528d8d86cb7e8464178b4e35)

[Cocoa Controls](http://cocoacontrols.com/controls/arautocompletetextview)
