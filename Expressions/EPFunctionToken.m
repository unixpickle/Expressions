//
//  EPFunctionToken.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPFunctionToken.h"

@implementation EPFunctionToken

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
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"This is an abstract method and must be overridden."
								 userInfo:nil];
}

- (void)dealloc {
	[functionName release];
	[super dealloc];
}

@end
