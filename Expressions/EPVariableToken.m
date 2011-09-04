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

- (id)init {
	if ((self = [super init])) {
		// Initialization code here.
	}
	return self;
}

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

- (void)dealloc {
	[variableName release];
	[super dealloc];
}

@end
