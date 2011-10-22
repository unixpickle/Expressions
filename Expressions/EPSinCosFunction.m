//
//  EPFunctionSine.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPSinCosFunction.h"

@implementation EPSinCosFunction

- (id)initWithString:(NSString *)aString {
	if ((self = [super initWithString:aString])) {
		if ([aString isEqualToString:@"cos"]) {
			isCosine = YES;
		} else if (![aString isEqualToString:@"sin"]) {
			[super dealloc];
			return nil;
		}
	}
	return self;
}

- (EPNumericalToken *)applyToOperandAbsolute:(id)anOperand {
	if (![anOperand respondsToSelector:@selector(doubleValue)]) {
		return nil;
	}
	if (isCosine) {
		return [EPNumericalToken numericalTokenWithDouble:cos([anOperand doubleValue])];
	} else {
		return [EPNumericalToken numericalTokenWithDouble:sin([anOperand doubleValue])];
	}
}

- (BOOL)isCosine {
	return isCosine;
}

@end
