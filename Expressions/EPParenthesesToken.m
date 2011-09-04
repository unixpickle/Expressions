//
//  EPTParentheses.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPParenthesesToken.h"

@implementation EPParenthesesToken

- (id)init {
	if ((self = [super init])) {
		direction = EPTParenthesesOpen;
	}
	return self;
}

- (id)initWithString:(NSString *)aString {
	if ((self = [super init])) {
		if ([aString isEqualToString:@"("]) {
			direction = EPTParenthesesOpen;
		} else if ([aString isEqualToString:@")"]) {
			direction = EPTParenthesesClose;
		} else {
			[super dealloc];
			return nil;
		}
	}
	return self;
}

- (NSString *)toString {
	if (direction == EPTParenthesesClose) {
		return @")";
	} else {
		return @"(";
	}
}

- (EPTParenthesesDirection)direction {
	return direction;
}

@end
