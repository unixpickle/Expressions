//
//  EPPowerOperator.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPPowerOperator.h"

@implementation EPPowerOperator

- (id)init {
	if ((self = [super init])) {
	}
	return self;
}

- (id)initWithString:(NSString *)aString {
	if ((self = [super init])) {
		if (![aString isEqualToString:@"^"]) {
			[super dealloc];
			return nil;
		}
	}
	return self;
}

- (NSString *)toString {
	return @"^";
}

- (id)applyLeftOperand:(id)anOperand toRight:(id)anotherOperand {
	if (![anOperand respondsToSelector:@selector(doubleValue)]) {
		return nil;
	}
	if (![anotherOperand respondsToSelector:@selector(doubleValue)]) {
		return nil;
	}
	double answer = pow((double)[anOperand doubleValue], (double)[anotherOperand doubleValue]);
	return [EPNumericalToken numericalTokenWithDouble:answer];
}

@end
