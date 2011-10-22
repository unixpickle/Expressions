//
//  EPExpression.h
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPTokenString.h"

@interface EPExpression : NSObject {
	NSMutableArray * tokens;
	BOOL negateExpression;
}

@property (readwrite) BOOL negateExpression;

- (id)initWithTokenString:(EPTokenString *)tString;
- (EPNumericalToken *)evaluateToToken;

@end
