//
//  EPMulDivOperator.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPMulDivOperator.h"

@implementation EPMulDivOperator

- (id)initWithString:(NSString *)aString {
	if ((self = [super init])) {
		isDivision = NO; // should already be NO because of the Objective-C runtime
		if ([aString isEqualToString:@"/"]) {
			isDivision = YES;
		} else if (![aString isEqualToString:@"*"]) {
			[super dealloc];
			return nil;
		}
	}
	return self;
}

- (NSString *)toString {
	if (isDivision) {
		return @"/";
	} else {
		return @"*";
	}
}

- (id)applyLeftOperand:(id)anOperand toRight:(id)anotherOperand {
	if (![anOperand respondsToSelector:@selector(doubleValue)]) {
		return nil;
	}
	if (![anotherOperand respondsToSelector:@selector(doubleValue)]) {
		return nil;
	}
	double answer = 0;
	if (isDivision) {
		answer = (double)[anOperand doubleValue] / (double)[anotherOperand doubleValue];
	} else {
		answer = (double)[anOperand doubleValue] * (double)[anotherOperand doubleValue];
	}
	return [EPNumericalToken numericalTokenWithDouble:answer];
}

- (BOOL)isDivision {
	return isDivision;
}

@end
