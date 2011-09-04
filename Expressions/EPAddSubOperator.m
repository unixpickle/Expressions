//
//  EPAddSubOperator.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPAddSubOperator.h"

@implementation EPAddSubOperator

- (id)init {
	if ((self = [super init])) {
		// Initialization code here.
	}
	return self;
}

- (id)initWithString:(NSString *)aString {
	if ((self = [super init])) {
		if ([aString isEqualToString:@"+"]) {
			isSubtraction = NO;
		} else if ([aString isEqualToString:@"-"]) {
			isSubtraction = YES;
		} else {
			[super dealloc];
			return nil;
		}
	}
	return self;
}

- (NSString *)toString {
	if (isSubtraction) {
		return @"-";
	} else {
		return @"+";
	}
}

- (BOOL)isSubtraction {
	return isSubtraction;
}

- (id)applyLeftOperand:(id)anOperand toRight:(id)anotherOperand {
	if (![anOperand respondsToSelector:@selector(doubleValue)]) {
		return nil;
	}
	if (![anotherOperand respondsToSelector:@selector(doubleValue)]) {
		return nil;
	}
	if (isSubtraction) {
		double answer = (double)[anOperand doubleValue] - (double)[anotherOperand doubleValue];
		return [EPNumericalToken numericalTokenWithDouble:answer];
	} else {
		double answer = (double)[anOperand doubleValue] + (double)[anotherOperand doubleValue];
		return [EPNumericalToken numericalTokenWithDouble:answer];
	}
}

@end
