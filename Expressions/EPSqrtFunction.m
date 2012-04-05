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
#if !__has_feature(objc_arc)
			[super dealloc];
#endif
			return nil;
		}
	}
	return self;
}

- (EPNumericalToken *)applyToOperand:(id)anOperand {
	if (![anOperand respondsToSelector:@selector(doubleValue)]) {
		return nil;
	}
	double answer = sqrt([anOperand doubleValue]);
#if __has_feature(objc_arc)
	return [[EPNumericalToken alloc] initWithDouble:answer];
#else
	return [[[EPNumericalToken alloc] initWithDouble:answer] autorelease];
#endif
}

@end
