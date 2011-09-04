//
//  ExpressionToken.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPToken.h"

@implementation EPToken

- (id)init {
	if ((self = [super init])) {
		// Initialization code here.
	}
	return self;
}

- (id)initWithString:(NSString *)aString {
	[super dealloc];
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"This is an abstract class and must be subclassed."
								 userInfo:nil];
}

- (NSString *)toString {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"This is an abstract class and must be subclassed."
								 userInfo:nil];
}

@end
