//
//  ARAutocompleteManager.h
//  alexruperez
//
//  Created by Alejandro Rupérez on 12/6/12.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARAutocompleteTextView.h"

typedef enum {
    ARAutocompleteTypeEmail, // Default
    ARAutocompleteTypeNames,
} ARAutocompleteType;

@interface ARAutocompleteManager : NSObject <ARAutocompleteDataSource>

+ (ARAutocompleteManager *)sharedManager;

@end
