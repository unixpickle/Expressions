//
//  EPNumericalToken.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EPNumericalToken.h"

@implementation EPNumericalToken

- (id)initWithString:(NSString *)aString {
	if ((self = [super init])) {
		// find any illegal characters
		BOOL hasFoundDot = NO;
		for (int i = 0; i < [aString length]; i++) {
			unichar aChar = [aString characterAtIndex:i];
			if (!isnumber(aChar) && aChar != '-' && aChar != '.') {
#if !__has_feature(objc_arc)
                [super dealloc];
#endif
				return nil;
			} else if (aChar == '-' && i != 0) {
#if !__has_feature(objc_arc)
                [super dealloc];
#endif
				return nil;
			} else if (aChar == '.') {
				if (!hasFoundDot) {
					hasFoundDot = YES;
				} else {
#if !__has_feature(objc_arc)
                    [super dealloc];
#endif
					return nil;
				}
			}
		}
		doubleValue = [aString doubleValue];
	}
	return self;
}

- (id)initWithDouble:(double)dVal {
	if ((self = [super init])) {
		doubleValue = dVal;
	}
	return self;
}

+ (EPNumericalToken *)numericalTokenWithDouble:(double)dVal {
    id obj = [[EPNumericalToken alloc] initWithDouble:dVal];
#if __has_feature(objc_arc)
    return obj;
#else
    return [obj autorelease];
#endif
}

- (NSString *)toString {
	NSMutableString * aString = [[NSMutableString alloc] initWithFormat:@"%1000.5lf", doubleValue];
	
	if ([aString length] == 0) {
#if !__has_feature(objc_arc)
        [aString release];
#endif
		return @"";
	}
	
	// Delete trailing zeroes, and, if needed, the trailing decimal point.
	unichar lastChar = [aString characterAtIndex:([aString length] - 1)];
	while (lastChar == '0' || lastChar == '.') {
		[aString deleteCharactersInRange:NSMakeRange([aString length] - 1, 1)];
		if ([aString length] == 0) break;
		lastChar = [aString characterAtIndex:([aString length] - 1)];
	}
	
	NSString * immutable = [NSString stringWithString:aString];
#if !__has_feature(objc_arc)
    [aString release];
#endif
	return immutable;
}

- (id)negativeToken {
	EPNumericalToken * token = [[EPNumericalToken alloc] initWithDouble:-[self doubleValue]];
#if !__has_feature(objc_arc)
    return [token autorelease];
#else
    return token;
#endif
}

- (id)copyWithZone:(NSZone *)zone {
	return [[EPNumericalToken allocWithZone:zone] initWithDouble:[self doubleValue]];
}

- (double)doubleValue {
	return doubleValue;
}

@end
