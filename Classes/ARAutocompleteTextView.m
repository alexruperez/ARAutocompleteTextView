//
//  ARAutocompleteTextView.m
//  alexruperez
//
//  Created by Alejandro Rupérez on 11/29/12.
//  Inspired by DOautocompleteTextView by DoAT.
//
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import "ARAutocompleteTextView.h"

static NSObject<ARAutocompleteDataSource> *DefaultAutocompleteDataSource = nil;

@interface ARAutocompleteTextView ()

@property (nonatomic, strong) NSString *autocompleteString;

@end

@implementation ARAutocompleteTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupAutocompleteTextView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupAutocompleteTextView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void)setupAutocompleteTextView
{
    self.delegate = self;
    
    self.autocompleteLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.autocompleteLabel.font = self.font;
    self.autocompleteLabel.backgroundColor = [UIColor clearColor];
    self.autocompleteLabel.textColor = [UIColor lightGrayColor];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    NSLineBreakMode lineBreakMode = NSLineBreakByClipping;
#else
    UILineBreakMode lineBreakMode = UILineBreakModeClip;
#endif
    
    self.autocompleteLabel.lineBreakMode = lineBreakMode;
    self.autocompleteLabel.hidden = YES;
    [self addSubview:self.autocompleteLabel];
    [self bringSubviewToFront:self.autocompleteLabel];

    self.autocompleteString = @"";
    
    self.ignoreCase = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ar_textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - Configuration

+ (void)setDefaultAutocompleteDataSource:(id)dataSource
{
    DefaultAutocompleteDataSource = dataSource;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self.autocompleteLabel setFont:font];
}

#pragma mark - UIResponder

- (BOOL)becomeFirstResponder
{
    if (!self.autocompleteDisabled)
    {
        self.autocompleteLabel.hidden = NO;
    }

    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    if (!self.autocompleteDisabled)
    {
        self.autocompleteLabel.hidden = YES;

        if ([self commitAutocompleteText]) {
            // Only notify if committing autocomplete actually changed the text.
        

            // This is necessary because committing the autocomplete text changes the text field's text, but for some reason UITextView doesn't post the UITextViewTextDidChangeNotification notification on its own
            [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
        }
    }
    return [super resignFirstResponder];
}

#pragma mark - Autocomplete Logic

- (CGRect)autocompleteRectForBounds:(CGRect)bounds
{
    CGRect caretRect = [self caretRectForPosition:self.selectedTextRange.start];
    
    CGRect returnRect = CGRectMake(caretRect.origin.x + 1.0f, caretRect.origin.y, self.frame.size.width, 19.0f);
    
    return returnRect;
}

- (void)ar_textDidChange:(NSNotification*)notification
{
    [self refreshAutocompleteText];
}

- (void)updateAutocompleteLabel
{
    [self.autocompleteLabel setText:self.autocompleteString];
    [self.autocompleteLabel sizeToFit];
    [self.autocompleteLabel setFrame: [self autocompleteRectForBounds:self.bounds]];
	
	if ([self.autoCompleteTextViewDelegate respondsToSelector:@selector(autoCompleteTextView:didChangeAutocompleteText:)]) {
		[self.autoCompleteTextViewDelegate autoCompleteTextView:self didChangeAutocompleteText:self.autocompleteString];
	}
}

- (void)refreshAutocompleteText
{
    if (!self.autocompleteDisabled)
    {
        id <ARAutocompleteDataSource> dataSource = nil;
        
        if ([self.autocompleteDataSource respondsToSelector:@selector(textView:completionForPrefix:ignoreCase:)])
        {
            dataSource = (id <ARAutocompleteDataSource>)self.autocompleteDataSource;
        }
        else if ([DefaultAutocompleteDataSource respondsToSelector:@selector(textView:completionForPrefix:ignoreCase:)])
        {
            dataSource = DefaultAutocompleteDataSource;
        }
        
        if (dataSource)
        {
            self.autocompleteString = [dataSource textView:self completionForPrefix:self.text ignoreCase:self.ignoreCase];

            if (self.autocompleteString.length > 0)
            {
                if ([self.text hasSuffix:@" "]) {
                    self.text = [self.text substringToIndex:[self.text length] - 1];
                    [self autocompleteText:self];
                }
            }
            
            [self updateAutocompleteLabel];
        }
    }
}

- (BOOL)commitAutocompleteText
{
    NSString *currentText = self.text;
    if (self.autocompleteString && [self.autocompleteString isEqualToString:@""] == NO
        && self.autocompleteDisabled == NO)
    {
        self.text = [NSString stringWithFormat:@"%@%@", self.text, self.autocompleteString];
        
        self.autocompleteString = @"";
        [self updateAutocompleteLabel];
		
		if ([self.autoCompleteTextViewDelegate respondsToSelector:@selector(autoCompleteTextViewDidAutoComplete:)]) {
			[self.autoCompleteTextViewDelegate autoCompleteTextViewDidAutoComplete:self];
		}
    }
    return ![currentText isEqualToString:self.text];
}

- (void)forceRefreshAutocompleteText
{
    [self refreshAutocompleteText];
}

#pragma mark - UITextView Delegate Methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@". "]) return NO;
    return YES;
}

#pragma mark - Accessors

- (void)setAutocompleteString:(NSString *)autocompleteString
{
    _autocompleteString = autocompleteString;
}

#pragma mark - Private Methods

- (void)autocompleteText:(id)sender
{
    if (!self.autocompleteDisabled)
    {
        self.autocompleteLabel.hidden = NO;
        
        [self commitAutocompleteText];
        
        // This is necessary because committing the autocomplete text changes the text field's text, but for some reason UITextView doesn't post the UITextViewTextDidChangeNotification notification on its own
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
    }
}

@end
