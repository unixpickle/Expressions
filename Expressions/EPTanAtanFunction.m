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
	double answer = 0;
	if (isAtan) {
		answer = atan([anOperand doubleValue]);
	} else {
		answer = tan([anOperand doubleValue]);
	}
	return [EPNumericalToken numericalTokenWithDouble:answer];
}

- (id)copyWithZone:(NSZone *)zone {
	return [[EPTanAtanFunction allocWithZone:zone] initWithString:[self toString]];
}

- (BOOL)isAtan {
	return isAtan;
}

@end
