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
#if __has_feature(objc_arc)
        variableName = aString;
#else
		variableName = [aString retain];
#endif
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
#if __has_feature(objc_arc)
    return token;
#else
    return [token autorelease];
#endif
}

- (id)copyWithZone:(NSZone *)zone {
	EPVariableToken * token = [[EPVariableToken allocWithZone:zone] initWithString:[self toString]];
	[token setDoubleValue:[self doubleValue]];
	return token;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
	[variableName release];
	[super dealloc];
}
#endif

@end
