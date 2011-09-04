//
//  EPMulDivOperator.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPMulDivOperator.h"

@implementation EPMulDivOperator

- (id)init {
	if ((self = [super init])) {
		// Initialization code here.
	}
	return self;
}

- (id)initWithString:(NSString *)aString {
	if ((self = [super init])) {
		if ([aString isEqualToString:@"/"]) {
			isDivision = YES;
		} else if ([aString isEqualToString:@"*"]) {
			isDivision = NO;
		} else {
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
	if (isDivision) {
		double answer = (double)[anOperand doubleValue] / (double)[anotherOperand doubleValue];
		return [EPNumericalToken numericalTokenWithDouble:answer];
	} else {
		double answer = (double)[anOperand doubleValue] * (double)[anotherOperand doubleValue];
		return [EPNumericalToken numericalTokenWithDouble:answer];
	}
}

- (BOOL)isDivision {
	return isDivision;
}

@end
