//
//  EPVariableToken.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPVariableToken.h"

@implementation EPVariableToken

@synthesize doubleValue;

- (id)initWithString:(NSString *)aString {
	if ((self = [super init])) {
		variableName = [aString retain];
	}
	return self;
}

- (NSString *)toString {
	return variableName;
}

- (NSString *)variableName {
	return variableName;
}

- (id)negativeToken {
	EPVariableToken * token = [[EPVariableToken alloc] initWithString:variableName];
	[token setDoubleValue:-[self doubleValue]];
	return [token autorelease];
}

- (void)dealloc {
	[variableName release];
	[super dealloc];
}

@end
