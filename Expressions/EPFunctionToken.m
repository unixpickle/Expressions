//
//  EPFunctionToken.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPFunctionToken.h"

@implementation EPFunctionToken

@synthesize negative;

- (id)initWithString:(NSString *)aString {
	if ((self = [super init])) {
		functionName = [aString retain];
	}
	return self;
}

- (NSString *)toString {
	return functionName;
}

- (NSString *)functionName {
	return functionName;
}

- (id)applyToOperand:(id)anOperand {
	return [self applyNegationToPositive:[self applyToOperandAbsolute:anOperand]];
}

- (EPNumericalToken *)applyToOperandAbsolute:(id)anOperand {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"This is an abstract method and must be overridden."
								 userInfo:nil];
}

- (EPNumericalToken *)applyNegationToPositive:(EPNumericalToken *)theResult {
	if (negative) {
		return [theResult negativeToken];
	}
	return theResult;
}

- (id)negativeToken {
	EPFunctionToken * newToken = [self copy];
	[newToken setNegative:([self negative] ? NO : YES)];
	return [newToken autorelease];
}

- (id)copyWithZone:(NSZone *)zone {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"This is an abstract method and must be overridden."
								 userInfo:nil];
}

- (void)dealloc {
	[functionName release];
	[super dealloc];
}

@end
