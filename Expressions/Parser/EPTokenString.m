//
//  EPTokenString.m
//  Expressions
//
//  Created by Alex Nichol on 9/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define IS_OPERATOR(x) (x == '+' || x == '-' || x == '/' || x == '*' || x == '(' || x == ')' || x == '^')

#import "EPTokenString.h"

@interface EPTokenString (Private)

- (id)initWithTokens:(NSArray *)tokens;
- (EPToken *)tokenFromString:(NSString *)tString vars:(id<EPTokenStringVariableSource>)vars functs:(id<EPTokenStringFunctionSource>)functs;

@end

@implementation EPTokenString

- (id)initWithExpression:(NSString *)expression varSource:(id<EPTokenStringVariableSource>)variables
			  funcSource:(id<EPTokenStringFunctionSource>)functions {
	if ((self = [super init])) {
		NSMutableString * currentBuff = [NSMutableString string];
		NSMutableArray * tArray = [[NSMutableArray alloc] init];
		for (int i = 0; i < [expression length]; i++) {
			unichar aChar = [expression characterAtIndex:i];
			// check for a single-character operator
			if (IS_OPERATOR(aChar)) {
				if ([currentBuff length] > 0) {
					EPToken * token = [self tokenFromString:currentBuff vars:variables functs:functions];
					[currentBuff deleteCharactersInRange:NSMakeRange(0, [currentBuff length])];
					if (token) {
						[tArray addObject:token];
					} else {
#if !__has_feature(objc_arc)
						[tArray release];
                        [super dealloc];
#endif
						return nil;
					}
				}
				NSString * tString = [NSString stringWithFormat:@"%C", aChar];
				EPToken * token = [self tokenFromString:tString vars:variables functs:functions];
				if (token) {
					[tArray addObject:token];
				} else {
#if !__has_feature(objc_arc)
                    [tArray release];
                    [super dealloc];
#endif
					return nil;
				}
			} else if (!isspace(aChar)) {
				[currentBuff appendFormat:@"%C", aChar];
			}
		}
		if ([currentBuff length] > 0) {
			EPToken * token = [self tokenFromString:currentBuff vars:variables functs:functions];
			if (token) {
				[tArray addObject:token];
			} else {
#if !__has_feature(objc_arc)
				[tArray release];
                [super dealloc];
#endif
				return nil;
			}
		}
		tokenArray = [[NSArray alloc] initWithArray:tArray];
#if !__has_feature(objc_arc)
		[tArray release];
#endif
	}
	return self;
}

- (NSArray *)tokenArray {
	return tokenArray;
}

- (EPTokenString *)substringWithRange:(NSRange)tokenRange {
	if (tokenRange.location + tokenRange.length > [tokenArray count]) {
		@throw [NSException exceptionWithName:NSRangeException
									   reason:@"Invalid bounds specified for substringWithRange:"
									 userInfo:nil];
	}
	
	NSMutableArray * subArray = [[NSMutableArray alloc] init];
	for (NSUInteger i = tokenRange.location; i < tokenRange.location + tokenRange.length; i++) {
		[subArray addObject:[tokenArray objectAtIndex:i]];
	}
	
	NSArray * immutable = [NSArray arrayWithArray:subArray];
#if !__has_feature(objc_arc)
	[subArray release];
#endif
#if __has_feature(objc_arc)
    return [[EPTokenString alloc] initWithTokens:immutable];
#else
	return [[[EPTokenString alloc] initWithTokens:immutable] autorelease];
#endif
}

#if !__has_feature(objc_arc)
- (void)dealloc {
	[tokenArray release];
	[super dealloc];
}
#endif

#pragma mark Private

- (id)initWithTokens:(NSArray *)tokens {
	if ((self = [super init])) {
		tokenArray = [tokens copyWithZone:NSDefaultMallocZone()];
	}
	return self;
}

- (EPToken *)tokenFromString:(NSString *)_tString vars:(id<EPTokenStringVariableSource>)vars functs:(id<EPTokenStringFunctionSource>)functs {
	// go through a series of possibilities
	EPToken * theToken = nil;
	
	NSString * tString = [NSString stringWithString:_tString];
	
#if __has_feature(objc_arc)
    if ((theToken = [[EPParenthesesToken alloc] initWithString:tString]) != nil) return theToken;	
	if ((theToken = [[EPAddSubOperator alloc] initWithString:tString]) != nil) return theToken;
	if ((theToken = [[EPMulDivOperator alloc] initWithString:tString]) != nil) return theToken;
	if ((theToken = [[EPPowerOperator alloc] initWithString:tString]) != nil) return theToken;
	if ((theToken = [[EPNumericalToken alloc] initWithString:tString]) != nil) return theToken;
#else
	if ((theToken = [[EPParenthesesToken alloc] initWithString:tString]) != nil) return [theToken autorelease];	
	if ((theToken = [[EPAddSubOperator alloc] initWithString:tString]) != nil) return [theToken autorelease];
	if ((theToken = [[EPMulDivOperator alloc] initWithString:tString]) != nil) return [theToken autorelease];
	if ((theToken = [[EPPowerOperator alloc] initWithString:tString]) != nil) return [theToken autorelease];
	if ((theToken = [[EPNumericalToken alloc] initWithString:tString]) != nil) return [theToken autorelease];
#endif
	
	if ([vars variableExists:tString]) {
		theToken = [[EPVariableToken alloc] initWithString:tString];
		[(EPVariableToken *)theToken setDoubleValue:[vars variableValue:tString]];
#if __has_feature(objc_arc)
        return theToken;
#else
		return [theToken autorelease];
#endif
	}
	
	if ([functs functionExists:tString]) {
		theToken = [functs functionTokenForName:tString];
		return theToken;
	}
	
	return theToken;
}

@end
