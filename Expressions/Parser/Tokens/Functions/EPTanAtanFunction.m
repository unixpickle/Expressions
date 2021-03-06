//
//  EPTanAtanFunction.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPTanAtanFunction.h"

@implementation EPTanAtanFunction

- (id)initWithString:(NSString *)aString {
	if ((self = [super initWithString:aString])) {
		if ([aString isEqualToString:@"atan"]) {
			isAtan = YES;
		} else if (![aString isEqualToString:@"tan"]) {
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
	if (isAtan) {
		answer = atan([anOperand doubleValue]);
	} else {
		answer = tan([anOperand doubleValue]);
	}
	return [EPNumericalToken numericalTokenWithDouble:answer];
}

- (BOOL)isAtan {
	return isAtan;
}

@end
