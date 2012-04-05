//
//  EPLogLnToken.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPLogLnToken.h"

@implementation EPLogLnToken

- (id)initWithString:(NSString *)aString {
	if ((self = [super initWithString:aString])) {
		if ([aString isEqualToString:@"ln"]) {
			natural = YES;
		} else if (![aString isEqualToString:@"log"]) {
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
	double answer = 0;
	if (natural) {
		answer = log([anOperand doubleValue]);
	} else {
		answer = log10([anOperand doubleValue]);
	}
#if __has_feature(objc_arc)
    return [[EPNumericalToken alloc] initWithDouble:answer];
#else
	return [[[EPNumericalToken alloc] initWithDouble:answer] autorelease];
#endif
}

- (BOOL)isNatural {
	return natural;
}

@end
