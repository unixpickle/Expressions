//
//  EPSqrtFunction.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPSqrtFunction.h"

@implementation EPSqrtFunction

- (id)initWithString:(NSString *)aString {
	if ((self = [super initWithString:aString])) {
		if (![aString isEqualToString:@"sqrt"]) {
			[super dealloc];
			return nil;
		}
	}
	return self;
}

- (EPNumericalToken *)applyToOperand:(id)anOperand {
	if (![anOperand respondsToSelector:@selector(doubleValue)]) {
		return NO;
	}
	double answer = sqrt([anOperand doubleValue]);
	return [[[EPNumericalToken alloc] initWithDouble:answer] autorelease];
}

@end
